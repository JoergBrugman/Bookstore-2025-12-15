/// <summary>
/// Table BSB Book (ID 50100). MASTERTABLE
/// </summary>
table 50100 "BSB Book"
{
    Caption = 'Book ';
    DataCaptionFields = "No.", Description;
    LookupPageId = "BSB Book List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            ToolTip = 'Specifies the value of the No. field. (Table)', Comment = '%';

        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the value of the Description field.', Comment = '%';

            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := CopyStr(Description, 1, MaxStrLen("Search Description"));
            end;
        }
        field(3; "Search Description"; Code[100])
        {
            Caption = 'Search Description';
            ToolTip = 'Specifies the value of the Search Description field.', Comment = '%';
            //[x] Search Description standardkonform implementieren
        }
        field(4; Blocked; Boolean)
        {
            Caption = 'Blocked';
            ToolTip = 'Specifies the value of the Blocked field.', Comment = '%';
        }
        field(5; Type; enum "BSB Book Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the value of the Type field.', Comment = '%';
        }
        field(7; Created; Date)
        {
            Caption = 'Created';
            ToolTip = 'Specifies the value of the Created field.', Comment = '%';
            Editable = false;
            //[x] Created automatisch befüllen
        }
        field(8; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            ToolTip = 'Specifies the value of the Last Date Modified field.', Comment = '%';
            Editable = false;
            //[x] Last Date Modified automatisch befüllen
        }
        field(10; Author; Text[50])
        {
            Caption = 'Author';
            ToolTip = 'Specifies the value of the Author field.', Comment = '%';
        }
        field(11; "Author Provision %"; Decimal)
        {
            Caption = 'Author Provision %';
            ToolTip = 'Specifies the value of the Author Provision % field.', Comment = '%';
            DecimalPlaces = 0 : 2;
            MinValue = 0;
            MaxValue = 100;
        }
        field(15; ISBN; Code[20])
        {
            Caption = 'ISBN';
            ToolTip = 'Specifies the value of the ISBN field.', Comment = '%';
        }
        field(16; "No. of Pages"; Integer)
        {
            Caption = 'No. of Pages';
            MinValue = 0;
            ToolTip = 'Specifies the value of the No. of Pages field.', Comment = '%';
        }
        field(17; "Edition No."; Integer)
        {
            Caption = 'Edition No.';
            ToolTip = 'Specifies the value of the Edition No. field.', Comment = '%';
            MinValue = 0;
        }
        field(18; "Date of Publishing"; Date)
        {
            Caption = 'Date of Publishing';
            ToolTip = 'Specifies the value of the Date of Publishing field.', Comment = '%';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, Author) { }
    }

    var
        OnDeleteBookErr: Label 'A Book cannot be deleted';

    trigger OnInsert()
    begin
        Created := Today;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    //[x] Das Löschen eines Buchs soll unbedingt verhindert werden
    trigger OnDelete()
    begin
        Error(OnDeleteBookErr);
    end;


    //[x] Procedure TestBlocked() implementieren
    // Funktionsüberladung erwünscht!!
    // Es können Funktionen mit gleichem Namen angelegt werden (Funktionsüberladung), sofern sie sich 
    // in ihrer Signatur unterscheiden.
    // Grund das zu tun, ist mehr Komfort in die Nutzung der Funktion zu bringen.

    /// <summary>
    /// Check if book with the tranfered No. is blocked or not. 
    /// </summary>
    /// <param name="BSBFavoriteBookNo">Code[20]. No. tho check</param>
    procedure TestBlocked(BSBFavoriteBookNo: Code[20])
    var
        BSBBook: Record "BSB Book";
    begin
        if BSBFavoriteBookNo = '' then
            exit;
        BSBBook.Get(BSBFavoriteBookNo);
        TestBlocked(BSBBook);
    end;

    /// <summary>
    /// Check if book is blocked or not.
    /// </summary>
    procedure TestBlocked()
    begin
        TestBlocked(Rec);
    end;

    local procedure TestBlocked(var BSBBook: Record "BSB Book")
    begin
        BSBBook.TestField(Blocked, false);  // Eigentliche Prüfung an EINER zentralen Stelle
    end;

    procedure ShowCard()
    begin
        ShowCard(Rec);
    end;

    procedure ShowCard(BookNo: Code[20])
    var
        BSBBook: Record "BSB Book";
    begin
        if BookNo = '' then
            exit;
        BSBBook.Get(BookNo);
        ShowCard(BSBBook);
    end;

    local procedure ShowCard(var BSBBook: Record "BSB Book")
    begin
        Page.RunModal(page::"BSB Book Card", BSBBook);
    end;
}
