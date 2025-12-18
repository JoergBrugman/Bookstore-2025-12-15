permissionset 50100 "BSB BOOKSTORE, EDIT"
{
    Caption = 'Edit and Create Books etc.';
    Assignable = true;

    Permissions =
        table "BSB Book" = X,
        tabledata "BSB Book" = RIMD,
        table "BSB AL Issue" = X,
        tabledata "BSB AL Issue" = RIMD;
}