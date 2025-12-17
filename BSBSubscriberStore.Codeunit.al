codeunit 50100 "BSB Subscriber Store"
{
    var
        FavoriteBookHintMsg: Label 'Do not forget to enter %1 in %2 %3 %4', Comment = 'de-DE=Bitte vergessen Sie nicht %1 ind %2 %3 %4 einzugeben';

    [EventSubscriber(ObjectType::Table, Database::Customer, OnAfterInsertEvent, '', true, true)]
    local procedure FavoriteBookHintCustOnAfterInsertEvent(var Rec: Record Customer)
    begin
        if Rec."BSB Favorite Book No." = '' then
            Message(FavoriteBookHintMsg,
               Rec.FieldCaption("BSB Favorite Book No."),
               Rec.TableCaption,
               Rec."No.",
               Rec.Name);
    end;

}