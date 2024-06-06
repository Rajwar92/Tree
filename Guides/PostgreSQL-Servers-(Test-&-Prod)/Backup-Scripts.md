# invoke_backup_cleaner.sh
```
#!/bin/bash

~/backup_cleaner.py --backup-dir ~/dumps/ --day 1 --week 1 --month 1 --year 2 --keep-older
```

# dump_backup.sh
```
#!/bin/bash

# use pg_basebackup to make a dump of the local database, should run this on the secondary node

BACKUP_NAME="backup_"`date -u "+%Y-%m-%d-%H-%M-%S"`

cd ~/dumps/
pg_basebackup -D "${BACKUP_NAME}"
tar cvzf "${BACKUP_NAME}.tar.gz" "${BACKUP_NAME}"
rm -r "${BACKUP_NAME}"
```

# backup_cleaner.py
```
#!/usr/bin/python3
import argparse
import os
import shutil
import sys
from datetime import datetime, timedelta
from typing import List, Tuple

_FileDateList = List[Tuple[str, datetime]]


_UTC_NOW = datetime.utcnow


class _TimeBucketing:
    def __init__(self, start: datetime, length: timedelta, limit: int):
        self._start = start
        self._end = start - length
        self._length = length
        self._limit = limit

    def _bucketing(self, file_date_list: _FileDateList) -> List[_FileDateList]:
        file_date_list.sort(key=lambda x: x[1], reverse=True)
        buckets: List[_FileDateList] = []

        start = self._start

        bucketing_delta = self._length / self._limit
        for _ in range(self._limit):
            end = start - bucketing_delta
            bucket = []
            while file_date_list and file_date_list[0][1] > end:
                bucket.append(file_date_list.pop(0))
            if bucket:
                buckets.append(bucket)
            start -= bucketing_delta

        for bucket in buckets:
            bucket.sort(key=lambda x: x[1])
        return buckets

    def get_keeping_list(self, file_list: _FileDateList) -> List[str]:
        file_list_in_range = []

        for file, date in file_list:
            if self._end < date < self._start:
                file_list_in_range.append((file, date))

        keeping_list: List[str] = []

        if self._limit == 0:
            return []

        buckets = self._bucketing(file_list_in_range)

        while buckets:
            remaining_buckets = []
            for bucket in buckets:
                first = bucket.pop(0)[0]
                if len(keeping_list) < self._limit:
                    keeping_list.append(first)
                if bucket:
                    remaining_buckets.append(bucket)
            buckets = remaining_buckets

        return keeping_list


class BackupCleaner:
    """
    Backup Cleaner

    Clean backup files and keep backups in a logarithmically manner.
    Need to specify the backup directory and how many backups are needed for each time period.

    The backups should be name as:

    name_yyyy-mm-dd-hh-mm-ss.ext

    * "name" can be any string without the _ (underscore).
    * The time is in UTC time.

    Example: backup_2021-02-16-23-18-68.gz
    """

    def __init__(self, args: List[str]):
        parser = self._argument_parser()
        arguments = parser.parse_args(args)

        self._backup_dir = arguments.backup_dir
        self._backups_this_day = arguments.day
        self._backups_this_week = arguments.week
        self._backups_this_month = arguments.month
        self._backups_this_year = arguments.year
        self._dry_run = arguments.dry_run
        self._keep_older = arguments.keep_older

    @staticmethod
    def _argument_parser():
        parser = argparse.ArgumentParser(description="Backup Cleaner")
        parser.add_argument(
            "--backup-dir",
            dest="backup_dir",
            type=str,
            required=True,
            help="Backup directory, search backups in the directory.",
        )
        parser.add_argument(
            "--day",
            dest="day",
            type=int,
            required=True,
            help="How many backups need for the previous day.",
        )
        parser.add_argument(
            "--week",
            dest="week",
            type=int,
            required=True,
            help="How many backups need for the previous week.",
        )
        parser.add_argument(
            "--month",
            dest="month",
            type=int,
            required=True,
            help="How many backups need for the previous month.",
        )
        parser.add_argument(
            "--year",
            dest="year",
            type=int,
            required=True,
            help="How many backups need for the previous year.",
        )
        parser.add_argument(
            "--dry-run",
            dest="dry_run",
            action="store_true",
            default=False,
            required=False,
            help="Not actually remove files, only display the files to remove and to keep.",
        )
        parser.add_argument(
            "--keep-older",
            dest="keep_older",
            action="store_true",
            default=False,
            required=False,
            help="Keep the files which is older than a year",
        )
        return parser

    @staticmethod
    def _parse_file_name(filepath: str) -> datetime:
        filename = os.path.basename(filepath)
        time_string = filename.split("_")[1].split(".")[0]  # IndexError
        time = datetime.strptime(time_string, "%Y-%m-%d-%H-%M-%S")
        return time

    def _find_db_backup_files(self) -> _FileDateList:
        file_and_date: _FileDateList = []
        for file in os.scandir(self._backup_dir):
            date = self._parse_file_name(file.path)
            file_and_date.append((file.path, date))
        return file_and_date

    @staticmethod
    def _remove(path):
        if os.path.isdir(path):
            shutil.rmtree(path)
        else:
            os.remove(path)

    def clean(self):
        current_time = _UTC_NOW()

        file_and_date = self._find_db_backup_files()

        start = current_time
        today = _TimeBucketing(start, timedelta(days=1), self._backups_this_day)
        today_keeping_list = today.get_keeping_list(file_and_date)
        today_keeping_list.sort(reverse=True)

        start -= timedelta(days=1)
        this_week = _TimeBucketing(start, timedelta(days=7), self._backups_this_week)
        this_week_keeping_list = this_week.get_keeping_list(file_and_date)
        this_week_keeping_list.sort(reverse=True)

        start -= timedelta(days=7)
        this_month = _TimeBucketing(start, timedelta(days=30), self._backups_this_month)
        this_month_keeping_list = this_month.get_keeping_list(file_and_date)
        this_month_keeping_list.sort(reverse=True)

        start -= timedelta(days=30)
        this_year = _TimeBucketing(start, timedelta(days=365), self._backups_this_year)
        this_year_keeping_list = this_year.get_keeping_list(file_and_date)
        this_year_keeping_list.sort(reverse=True)

        keeping_list = (
            today_keeping_list
            + this_week_keeping_list
            + this_month_keeping_list
            + this_year_keeping_list
        )

        if self._keep_older:
            start -= timedelta(days=365)
            older = list(filter(lambda x: x[1] < start, file_and_date))
            older_files = list(map(lambda x: x[0], older))
            keeping_list += older_files

        # Assign remove list explicitly, so newly generated files won't be removed
        remove_list = list(set(map(lambda x: x[0], file_and_date)) - set(keeping_list))
        remove_list.sort(reverse=True)

        print("Is Dry Run:", self._dry_run)
        print("")

        print("Files to keep:")
        print("day:", today_keeping_list)
        print("week:", this_week_keeping_list)
        print("month:", this_month_keeping_list)
        print("year:", this_year_keeping_list)
        if self._keep_older:
            print("older:", older_files)

        print("")
        print("Files to remove:")
        print(remove_list)

        if not self._dry_run:
            for file in remove_list:
                self._remove(file)
            print("Files removed")


if __name__ == "__main__":
    CLEANER = BackupCleaner(sys.argv[1:])
    CLEANER.clean()
```