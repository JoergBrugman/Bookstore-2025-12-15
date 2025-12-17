codeunit 50149 "BSB Create Books"
{
    trigger OnRun()
    var
        Cnt: Integer;
    begin
        for Cnt := 1 to 100 do CreateBook(Cnt);
    end;

    var
        BSBBook: Record "BSB Book";

    local procedure CreateBook(Int: Integer)
    var
        Suffix: Text;
    begin
        BSBBook.Init();
        Suffix := format(int);
        if not BSBBook.Get('B' + Suffix) then BSBBook."No." := 'B' + Suffix;
        BSBBook.Validate(Description, 'Buch ' + Suffix);
        BSBBook.Author := 'Autor ' + Suffix;
        BSBBook.ISBN := CopyStr(Suffix, 1, MaxStrLen(BSBBook.ISBN));
        BSBBook."No. of Pages" := Int * 10;
        BSBBook.Type := int mod 3;
        BSBBook."Date of Publishing" := Today() + Int;
        if not BSBBook.insert(true) then BSBBook.Modify(true);
    end;
}
