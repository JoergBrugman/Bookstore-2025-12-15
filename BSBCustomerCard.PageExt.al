pageextension 50100 "BSB Customer Card" extends "Customer Card"
{
    layout
    {
        addafter(General)
        {
            group("BSB Bookstore")
            {
                Caption = 'Bookstore';

                field("BSB Favorite Book No."; Rec."BSB Favorite Book No.") { ApplicationArea = All; }
                field("BSB Favorite Book Description"; Rec."BSB Favorite Book Description") { ApplicationArea = All; }
            }
        }
    }
}