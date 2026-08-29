unit HttpUtilUnit;

interface

uses
    System.Classes, System.SysUtils, IdHTTP, IdSSLOpenSSL;

type
    THttpUtil = class
    public
        class function Execute(AUrl: String): String;
    end;

implementation

{ THttpUtil }

class function THttpUtil.Execute(AUrl: String): String;
var
    HttpClient: TIdHTTP;
    SSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    Stream: TStringStream;
begin
    HttpClient := TIdHTTP.Create(nil);
    SSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    HttpClient.IOHandler := SSLIOHandlerSocketOpenSSL;
    Stream := TStringStream.Create('', TEncoding.UTF8);
    try
        HttpClient.Request.Accept := 'application/json';
        HttpClient.Request.ContentType := 'application/json';
        HttpClient.Get(AUrl, Stream);
        Stream.Position := 0;
        Result := Stream.DataString;
    finally
        Stream.Free;
        SSLIOHandlerSocketOpenSSL.Free;
        HttpClient.Free;
    end;
end;

end.
