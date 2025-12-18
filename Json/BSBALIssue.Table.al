table 50145 "BSB AL Issue"
{
    Caption = 'AL Issue';

    fields
    {
        field(1; Id; Integer) { Caption = 'ID'; }
        field(2; Number; Integer) { Caption = 'Number'; }
        field(3; Title; text[250]) { Caption = 'Title'; }
        field(5; "Created at"; DateTime) { Caption = 'Created at'; }
        field(6; User; text[50]) { Caption = 'User'; }
        field(7; State; text[30]) { Caption = 'State'; }
        field(8; Website; text[250])
        {
            Caption = 'Website';
            ExtendedDatatype = URL;
        }
    }

    keys
    {
        key(PK; id)
        {
            Clustered = true;
        }
    }

    procedure RefreshIssues()
    var
        RefreshALIssues: Codeunit "BSB AL Issue Mgt.";
    begin
        RefreshALIssues.Refresh();
    end;

}