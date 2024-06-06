## Prereq

Ensure you have the dotnet-script tool installed before proceeding, which can be installed with the following powershell command: `dotnet tool install -g dotnet-script`

---

## Generating Transformation Files

From the `DataTransformation` folder in the `Core` project within the BWW Backend solution, run the following powershell command: `dotnet script .\GenerateTransformation.csx "<your description>"`

Where <your description> is the description of your transformation

---

## Example

Command run: `dotnet script .\GenerateTransformation.csx "Add ChapterHeadingMapping Collection for non-existent items"`

Resulting file: `Transform_20230912063825_Add_ChapterHeadingMapping_Collection_for_nonexistent_items.cs`

Resulting file contents:

![devenv_JQ9pDfqyHi.png](/.attachments/devenv_JQ9pDfqyHi-8d5fa2b1-91cd-45ab-ac69-15e8a71ced6f.png)