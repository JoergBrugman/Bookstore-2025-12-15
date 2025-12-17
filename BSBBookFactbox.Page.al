page 50102 "BSB Book Factbox"
{
    Caption = 'Book Details';
    PageType = CardPart;
    SourceTable = "BSB Book";
    Editable = false;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            field("No."; Rec."No.")
            {
                Caption = 'Book No.';

                trigger OnDrillDown()
                begin
                    ShowDetail()
                end;
            }
            field(Description; Rec.Description) { }
            field("Date of Publishing"; Rec."Date of Publishing") { }
            field("No. of Pages"; Rec."No. of Pages") { }
            field(Author; Rec.Author) { }
        }
    }

    local procedure ShowDetail()
    begin
        Rec.ShowCard();
    end;
}