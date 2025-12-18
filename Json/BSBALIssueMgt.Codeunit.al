codeunit 50145 "BSB AL Issue Mgt."
{
    procedure Refresh()
    var
        BSBALIssue: Record "BSB AL Issue";
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonToken: JsonToken;
        EntryNo: Integer;
    begin
        BSBALIssue.DeleteAll();

        // Get JSON Array (only read 2 pages to not exceed the github limit)
        JsonArray := ReadPages('https://api.github.com/repos/Microsoft/AL/issues', 1);

        // Process JSON array insert records to AL Issue
        foreach JsonToken in JsonArray do begin
            JsonObject := JsonToken.AsObject();
#pragma warning disable AA0139
            BSBALIssue.Init();
            // BSBALIssue.Id := GetJsonToken(JsonObject, 'id').AsValue().AsInteger(); // War notwendig wg. Integer-Überlauf!
            EntryNo += 1;
            BSBALIssue.Id := EntryNo;
            BSBALIssue.Number := GetJsonToken(JsonObject, 'number').AsValue().AsInteger();
            BSBALIssue.Title := TrimText(GetJsonToken(JsonObject, 'title').AsValue().AsText(), MaxStrLen(BSBALIssue.Title));
            BSBALIssue."Created at" := GetJsonToken(JsonObject, 'created_at').AsValue().AsDateTime();
            BSBALIssue.User := TrimText(SelectJsonToken(JsonObject, '$.user.login').AsValue().AsText(), MaxStrLen(BSBALIssue.User));
            BSBALIssue.State := TrimText(GetJsonToken(JsonObject, 'state').AsValue().AsText(), MaxStrLen(BSBALIssue.State));
            BSBALIssue.Website := TrimText(GetJsonToken(JsonObject, 'html_url').AsValue().AsText(), MaxStrLen(BSBALIssue.Website));
            BSBALIssue.Insert();
#pragma warning restore
        end;
    end;

    local procedure ReadPages(Url: Text; MaxPages: Integer) JsonArray: JsonArray
    var
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        JsonObject: JsonObject;
        JsonArrayCurr: JsonArray;
        JsonToken: JsonToken;
        StopReading: Boolean;
        i: Integer;
        JsonText: Text;
    begin
        i := 1;
        StopReading := false;

        while not StopReading do begin
            // Simple web service call
            HttpClient.DefaultRequestHeaders().Add('User-Agent', 'Dynamics 365');
            if not HttpClient.Get(Url + StrSubstNo('?page=%1', i), HttpResponseMessage) then
                Error('The call to the web service failed');

            if not HttpResponseMessage.IsSuccessStatusCode() then
                error('The web service returned an error message:\\' +
                      'Status code: %1\' +
                      'Description: %2',
                      HttpResponseMessage.HttpStatusCode(),
                      HttpResponseMessage.ReasonPhrase());

            HttpResponseMessage.Content().ReadAs(JsonText);
            if not JsonArrayCurr.ReadFrom(JsonText) then
                Error('Invalid response, expected an JSON array as root object');
            if JsonArrayCurr.Count() = 0 then begin
                message('Fertig auf Seite %1', i);
                StopReading := true;
            end;

            foreach JsonToken in JsonArrayCurr do begin
                JsonObject := JsonToken.AsObject();
                JsonArray.Add(JsonObject);
            end;

            i += 1;
            StopReading := (MaxPages > 0) and (i > MaxPages)
        end;
    end;

    procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error('Could not find a token with key %1', TokenKey);
    end;

    procedure SelectJsonToken(JsonObject: JsonObject; Path: text) JsonToken: JsonToken
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            Error('Could not find a token with path %1', Path);
    end;

    local procedure TrimText(Txt: Text; Length: Integer): Text
    begin
        if Length = 0 then
            exit('');

        if (StrLen(Txt) <= Length) then
            exit(Txt)
        else
            exit(Txt.Substring(1, Length));
    end;
}