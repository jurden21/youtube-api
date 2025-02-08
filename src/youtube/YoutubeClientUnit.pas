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
        function ChannelsListByHandle(AHandle: String): TChannelListResponse;
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

// https://developers.google.com/youtube/v3/docs/channels/list
function TYoutubeClient.ChannelsListByChannelId(AChannelId: String): TChannelListResponse;
var
    Request: THttpRequest;
    Response: THttpResponse;
begin
    Request.Url := FUrlBuilder.ChannelsListByChannelId(AChannelId);
    Response := THttpUtil.Execute(Request);
    Result := TChannelListResponse.Parse(Response);
end;

// https://developers.google.com/youtube/v3/docs/channels/list
function TYoutubeClient.ChannelsListByHandle(AHandle: String): TChannelListResponse;
var
    Request: THttpRequest;
    Response: THttpResponse;
begin
    Request.Url := FUrlBuilder.ChannelsListByHandle(AHandle);
    Response := THttpUtil.Execute(Request);
    Result := TChannelListResponse.Parse(Response);
end;

// https://developers.google.com/youtube/v3/docs/channels/list
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
