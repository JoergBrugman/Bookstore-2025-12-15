page 50101 "BSB Book List"
{
    Caption = 'Books';
    PageType = List;
    SourceTable = "BSB Book";
    Editable = false;
    CardPageId = "BSB Book Card";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Books)
            {
                field("No."; Rec."No.") { }
                field(Description; Rec.Description) { }
                field(ISBN; Rec.ISBN) { }
                field(Author; Rec.Author) { }
                field(Type; Rec.Type) { }
                field("No. of Pages"; Rec."No. of Pages") { Visible = false; }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links) { ApplicationArea = RecordLinks; }
            systempart(Notes; Notes) { ApplicationArea = Notes; }
        }
    }

    actions
    {
        area(processing)
        {
            action(CreateBooks)
            {
                Caption = 'Create Books';
                Image = CreateDocuments;
                ApplicationArea = All;
                ToolTip = 'Executes the Create Books action.';
                RunObject = codeunit "BSB Create Books";
            }
            action(ClassicProgramming)
            {
                Caption = 'Classic';
                Image = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                    BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                    IsHandled: Boolean;
                begin
                    OnBeforeProcessBookType(Rec, IsHandled);
                    if IsHandled then
                        exit;

                    case Rec.Type of
                        "BSB Book Type"::Hardcover:
                            begin
                                BSBBookTypeHardcoverImpl.StartDeployBook();
                                BSBBookTypeHardcoverImpl.StartDeliverBook();
                            end;
                        "BSB Book Type"::Paperback:
                            begin
                                BSBBookTypePaperbackImpl.StartDeployBook();
                                BSBBookTypePaperbackImpl.StartDeliverBook();
                            end;
                        else
                            Message('Nicht implementiert');
                    end;
                end;
            }
            action(PlainInterface)
            {
                Caption = 'Plain Interface';
                ApplicationArea = All;
                Image = Process;

                trigger OnAction()
                var
                    BSBBookTypeDefaultImpl: Codeunit "BSB Book Type Default Impl.";
                    BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                    BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                    BSBBookTypeProcess: interface "BSB Book Type Process";
                begin
                    case Rec.Type of
                        "BSB Book Type"::" ":
                            BSBBookTypeProcess := BSBBookTypeDefaultImpl;
                        "BSB Book Type"::Hardcover:
                            BSBBookTypeProcess := BSBBookTypeHardcoverImpl;
                        "BSB Book Type"::Paperback:
                            BSBBookTypeProcess := BSBBookTypePaperbackImpl;
                    end;
                    BSBBookTypeProcess.StartDeployBook();
                    BSBBookTypeProcess.StartDeliverBook();
                end;
            }
            action(InterfaceWithEnum)
            {
                Caption = 'Interface with Enum';
                ApplicationArea = All;
                Image = Process;

                trigger OnAction()
                var
                    BSBBookTypeProcess: interface "BSB Book Type Process";
                begin
                    BSBBookTypeProcess := Rec.Type;
                    BSBBookTypeProcess.StartDeployBook();
                    if BSBBookTypeProcess is "BSB Book Type Process V2" then
                        (BSBBookTypeProcess as "BSB Book Type Process V2").StartQualityCheck();
                    BSBBookTypeProcess.StartDeliverBook();
                end;
            }
        }
    }

    [IntegrationEvent(false, false)]
    local procedure OnBeforeProcessBookType(Rec: Record "BSB Book"; var IsHandled: Boolean)
    begin
    end;
}