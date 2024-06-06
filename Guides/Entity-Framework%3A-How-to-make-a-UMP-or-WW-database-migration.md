The UMP project uses Entity Framework Core as its object-database mapper. In order to update the database you will need to add a new migration which provides the relevant instructions to upgrade the database from the previous version to the new one. The migration also contains instruction on how to downgrade from the new version to the previous one.

I will use the example of adding a new required boolean `isEnabled` column to the `OrgContact` table.

Follow these instructions to complete your first migration:

- Ensure you have the EF Core tools installed: [EF Core tools reference (.NET CLI) - EF Core](https://docs.microsoft.com/en-us/ef/core/cli/dotnet#installing-the-tools)

- Edit the model you wish to update:

  * Within the *Database* project locate the *Models* folder and the *OrgContact* model: `Database/Models/OrgContact.cs`
  * Add a field for the new column: `public bool OcIsEnabled { get; set; }`
    * This defines that the column should be of type bool (bit) and that it is required

- Add additional context:

  * In the same project find *DatabaseContext*: `Database/DatabaseContext.cs`
  * Update the respective `modelBuilder.Entity<>()` call that defines how the model is mapped to the database table
    * In this example the following would be added:

  ```
  	entity.Property(e => e.OcIsEnabled)
  		.IsRequired()
  		.HasColumnName("OC_IsEnabled")
  		.HasDefaultValue(true);
  ```

- Add a new migration ([official documentation](https://docs.microsoft.com/en-us/ef/core/managing-schemas/migrations/managing?tabs=dotnet-core-cli)):

  * Open the command line in Visual Studio: *Tools \> Command Line \> Developer Command Prompt*
  * Run the following command: `dotnet ef migrations add <NameOfMigration> --project Database`, in this case `AddOcIsEnabled`
    * This should create a new file in the *Migrations* folder within the *Database* project named something like `XXXXXXXXXXXXXX_AddOcIsEnabled.cs`
  * The new file should contain two methods, `Up` and `Down` that are already populated with migration instructions.
  * To apply the migration run the following command in the same command prompt as previously: `dotnet ef database update --project Database`
    * Similarly to undo the migration run `dotnet ef database update <NameOfPreviousMigration> --project Database`
    * **Note**: the migration will also be applied automatically when the API is run locally

- Verify that the database has been updated in Microsoft SQL Server Management Studio

To remove the last migration from the solution run the following:

- `dotnet ef migrations remove --project Database`

- This should not be done after the migration has already been applied to the production database