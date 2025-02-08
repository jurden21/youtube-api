unit YoutubeClientUnit;

interface

uses
    System.Generics.Collections, UrlBuilderUnit, ChannelsResponseUnit;

type
    TYoutubeClient = class
    private
        FUrlBuilder: TUrlBuilder;
    public
        constructor Create(AKey: String);
        destructor Destroy; override;
        function ChannelsListByChannelId(AChannelId: String): TChannelsResponse;
        function ChannelsListByHandle(AHandle: String): TChannelsResponse;
        function ChannelsListByUsername(AUsername: String): TChannelsResponse;
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
function TYoutubeClient.ChannelsListByChannelId(AChannelId: String): TChannelsResponse;
var
    Request: THttpRequest;
    Response: THttpResponse;
begin
    Request.Url := FUrlBuilder.ChannelsListByChannelId(AChannelId);
    Response := THttpUtil.Execute(Request);
    Result := TChannelsResponse.Parse(Response);
end;

// https://developers.google.com/youtube/v3/docs/channels/list
function TYoutubeClient.ChannelsListByHandle(AHandle: String): TChannelsResponse;
var
    Request: THttpRequest;
    Response: THttpResponse;
begin
    Request.Url := FUrlBuilder.ChannelsListByHandle(AHandle);
    Response := THttpUtil.Execute(Request);
    Result := TChannelsResponse.Parse(Response);
end;

// https://developers.google.com/youtube/v3/docs/channels/list
function TYoutubeClient.ChannelsListByUsername(AUsername: String): TChannelsResponse;
var
    Request: THttpRequest;
    Response: THttpResponse;
begin
    Request.Url := FUrlBuilder.ChannelsListByUsername(AUsername);
    Response := THttpUtil.Execute(Request);
    Result := TChannelsResponse.Parse(Response);
end;

end.
