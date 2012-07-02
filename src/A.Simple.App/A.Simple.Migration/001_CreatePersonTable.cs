using FluentMigrator;

namespace A.Simple.Migrations
{
    [Migration(1)]
    public class CreatePersonTable : Migration
    {
        const string _tableName = "People";

        public override void Up()
        {
            Create.Table(_tableName)
                .WithColumn("Id").AsGuid().Identity()
                .WithColumn("FirstName").AsString(50)
                .WithColumn("LastName").AsString(100);
        }

        public override void Down()
        {
            Delete.Table(_tableName);
        }
    }
}