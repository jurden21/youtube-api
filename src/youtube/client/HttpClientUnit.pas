unit HttpClientUnit;

interface

type
    IHttpClient = interface
        function Get(AUrl: String): String;
    end;

    THttpClient = class(TInterfacedObject, IHttpClient)
    public
        function Get(AUrl: String): String;
    end;

implementation

uses
    System.Classes,
    System.SysUtils,
    IdHTTP,
    IdSSLOpenSSL;

{ THttpClient }

function THttpClient.Get(AUrl: String): String;
var
    IdHttpClient: TIdHTTP;
    SSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    Stream: TStringStream;
begin
    IdHttpClient := TIdHTTP.Create(nil);
    SSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    IdHttpClient.IOHandler := SSLIOHandlerSocketOpenSSL;
    Stream := TStringStream.Create('', TEncoding.UTF8);
    try
        IdHttpClient.Request.Accept := 'application/json';
        IdHttpClient.Request.ContentType := 'application/json';
        IdHttpClient.Get(AUrl, Stream);
        Stream.Position := 0;
        Result := Stream.DataString;
    finally
        Stream.Free;
        SSLIOHandlerSocketOpenSSL.Free;
        IdHttpClient.Free;
    end;
end;

end.
