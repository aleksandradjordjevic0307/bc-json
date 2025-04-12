pageextension 50151 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage()
    var
        jtext: Text;
        j: JsonObject;
    begin
        jtext := '{"company": {"employees": [{"id":"Marcy","salary":8.95}, {"id":"John","salary":7}, {"id":"Diana","salary":10.95}]}}';
        j.ReadFrom(jtext);

        Message('%1', SelectEmployeeSalary(j.AsToken(), 'Diana'));
    end;

    local procedure SelectEmployeeSalary(companyData: JsonToken; employeeID: Text) salary: Decimal
    var
        query: Text;
        salaryToken: JsonToken;
    begin
        query := '$.company.employees[?(@.id==''' + employeeID + ''')].salary';
        companyData.SelectToken(query, salaryToken);

        salary := salaryToken.AsValue().AsDecimal();
    end;

}