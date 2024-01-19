unit YoutubeClientUnit;

interface

uses
    System.Generics.Collections, UrlBuilderUnit, ChannelListResponseUnit;

type
    TYoutubeClient = class
    private
        FUrlBuilder: TUrlBuilder;
    public
        constructor Create(AKey: String);
        destructor Destroy; override;
        function ChannelsListByChannelId(AChannelId: String): TChannelListResponse;
        function ChannelsListByUsername(AUsername: String): TChannelListResponse;
    end;

implementation

uses
    HttpUtilUnit;

{ TYoutubeClient }

constructor TYoutubeClient.Create(AKey: String);
begin
    FUrlBuilder := TUrlBuilder.Create(AKey);
end;

destructor TYoutubeClient.Destroy;
begin
    FUrlBuilder.Free;
end;

function TYoutubeClient.ChannelsListByChannelId(AChannelId: String): TChannelListResponse;
var
    Request: THttpRequest;
    Response: THttpResponse;
begin
    Request.Url := FUrlBuilder.ChannelsListByChannelId(AChannelId);
    Response := THttpUtil.Execute(Request);
    Result := TChannelListResponse.Parse(Response);
end;

function TYoutubeClient.ChannelsListByUsername(AUsername: String): TChannelListResponse;
var
    Request: THttpRequest;
    Response: THttpResponse;
begin
    Request.Url := FUrlBuilder.ChannelsListByUsername(AUsername);
    Response := THttpUtil.Execute(Request);
    Result := TChannelListResponse.Parse(Response);
end;

end.
