unit KeyServiceUnit;

interface

type
    IKeyService = interface
        function GetKey: String;
    end;

    TKeyService = class(TInterfacedObject, IKeyService)
    private const
        KEY_STR = '?key=%s';
    private
        Key: String;
    public
        constructor Create(AKey: String);
        function GetKey: String;
    end;

implementation

uses
    System.SysUtils;

{ TKeyService }

constructor TKeyService.Create(AKey: String);
begin
    Key := AKey;
end;

function TKeyService.GetKey: String;
begin
    Result := Format(KEY_STR, [Key]);
end;

end.
