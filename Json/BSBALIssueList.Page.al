page 50145 "BSB AL Issue List"
{
    PageType = List;
    SourceTable = "BSB AL Issue";
    Caption = 'AL Issues';
    Editable = false;
    SourceTableView = order(descending);
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Number; Rec.Number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Number field';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field';
                }
                field(CreatedAt; Rec."Created at")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created at field';
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User field';
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the State field';
                }
                field(Website; Rec.Website)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Website field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(RefreshALIssueList)
            {
                Caption = 'Refresh Issues';
                Promoted = true;
                PromotedCategory = Process;
                Image = RefreshLines;
                ApplicationArea = All;
                ToolTip = 'Executes the Refresh Issues action';

                trigger OnAction();
                begin
                    Rec.RefreshIssues();
                    CurrPage.Update();
                    if Rec.FindFirst() then;
                end;
            }
        }
    }

}