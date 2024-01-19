unit JsonUtilUnit;

interface

uses
    System.SysUtils, System.Classes, System.Json, System.Generics.Collections;

type
    TJsonUtil = class
    public
        class function ReadString(AJson: TJSONValue; AKey: String): String;
        class function ReadBool(AJson: TJSONValue; AKey: String): Boolean;
        class function ReadStringList(AJson: TJSONValue; AKey: String): TStringList;
    end;

implementation

{ TJsonUtil }

class function TJsonUtil.ReadString(AJson: TJSONValue; AKey: String): String;
var
    Value: String;
begin
    AJson.TryGetValue(AKey, Value);
    Result := Value;
end;

class function TJsonUtil.ReadBool(AJson: TJSONValue; AKey: String): Boolean;
var
    Value: String;
begin
    AJson.TryGetValue(AKey, Value);
    Result := StrToBool(Value);
end;

class function TJsonUtil.ReadStringList(AJson: TJSONValue; AKey: String): TStringList;
var
    Values: TJSONArray;
begin
    Result := TStringList.Create;
    Values := AJson.FindValue(AKey) as TJSONArray;
    for var Index := 0 to Values.Count - 1 do
        Result.Add(Values.Items[Index].Value);
end;

end.
