unit HttpUtilUnit;

interface

uses
    System.Classes, System.SysUtils, IdHTTP, IdSSLOpenSSL;

type
    THttpRequest = record
    private
        FUrl: String;
    public
        property Url: String read FUrl write FUrl;
    end;

    THttpResponse = record
    private
        FContent: String;
    public
        property Content: String read FContent write FContent;
    end;

    THttpUtil = class
    public
        class function Execute(ARequest: THttpRequest): THttpResponse;
    end;

implementation

{ THttpUtil }

class function THttpUtil.Execute(ARequest: THttpRequest): THttpResponse;
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
        HttpClient.Get(ARequest.Url, Stream);
        Stream.Position := 0;
        Result.Content := Stream.DataString;
    finally
        Stream.Free;
        SSLIOHandlerSocketOpenSSL.Free;
        HttpClient.Free;
    end;
end;

end.
