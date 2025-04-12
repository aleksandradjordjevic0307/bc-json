pageextension 50150 "JSON" extends "Sales Order"
{
    actions
    {
        addfirst(processing)
        {
            action(ShowJson)
            {
                Caption = 'Show JSON';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = all;
                Image = Document;
                trigger OnAction()
                var
                    obj: JsonObject;  //main object
                    O2: JsonObject;
                    item: JsonObject; //object that is added to an array
                    ja: JsonArray; //array in which items are added
                    Token: JsonToken;
                    T2: JsonToken;
                    T3: JsonToken;
                    v: JsonValue;
                    txt: Text;
                begin
                    obj.Add('field', 'Youtube Video');
                    v.SetValue(123.456);

                    obj.Add('Price', v);
                    //obj.Add('Price', 123.345);
                    obj.Add('version', '0.2.0');
                    //item.Add('No', '1234'); //first item
                    item.Add('No', 20201110D);
                    ja.Add(item); //adding to an array
                    Clear(item);
                    //item.Add('No', '2345'); //second item
                    item.Add('No', 20201112D);

                    ja.Add(item); //adding to an array
                    //ja.Add(100); //also, value can be added to an array
                    //ja.Add(200);
                    obj.Add('Items', ja); //adding an array to a main object

                    if obj.Contains('Items') then begin
                        obj.Get('Items', Token);
                        foreach T2 in Token.AsArray() do begin   //"as array" because compiler does not know if it is an array
                            if T2.IsObject() then begin
                                O2 := T2.AsObject();
                                O2.Get('No', T3);
                                if T3.IsValue then begin
                                    v := T3.AsValue();
                                    //Message('Value as a code: %1 ', v.AsCode());
                                    Message('Value as a code: %1 ', CalcDate('+5D', v.AsDate()));

                                end;
                                //Message('Value: %1', T3.AsValue());
                            end;

                        end;
                    end;



                    //obj.WriteTo(txt);
                    //Message(txt);

                end;


            }
        }
    }
}