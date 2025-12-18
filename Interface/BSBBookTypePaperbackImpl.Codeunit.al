codeunit 50111 "BSB Book Type Paperback Impl." implements "BSB Book Type Process"
{
    procedure StartDeployBook()
    begin
        Message('Print on demand');
    end;

    procedure StartDeliverBook()
    begin
        Message('Mit DPD versenden');
    end;
}
