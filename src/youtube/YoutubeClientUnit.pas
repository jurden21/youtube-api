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
        function ChannelsByChannelId(AChannelId: String): TChannelsResponse;
        function ChannelsByHandle(AHandle: String): TChannelsResponse;
        function ChannelsByUsername(AUsername: String): TChannelsResponse;
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
function TYoutubeClient.ChannelsByChannelId(AChannelId: String): TChannelsResponse;
var
    Request: THttpRequest;
    Response: THttpResponse;
begin
    Request.Url := FUrlBuilder.ChannelsByChannelId(AChannelId);
    Response := THttpUtil.Execute(Request);
    Result := TChannelsResponse.Parse(Response);
end;

// https://developers.google.com/youtube/v3/docs/channels/list
function TYoutubeClient.ChannelsByHandle(AHandle: String): TChannelsResponse;
var
    Request: THttpRequest;
    Response: THttpResponse;
begin
    Request.Url := FUrlBuilder.ChannelsByHandle(AHandle);
    Response := THttpUtil.Execute(Request);
    Result := TChannelsResponse.Parse(Response);
end;

// https://developers.google.com/youtube/v3/docs/channels/list
function TYoutubeClient.ChannelsByUsername(AUsername: String): TChannelsResponse;
var
    Request: THttpRequest;
    Response: THttpResponse;
begin
    Request.Url := FUrlBuilder.ChannelsByUsername(AUsername);
    Response := THttpUtil.Execute(Request);
    Result := TChannelsResponse.Parse(Response);
end;

end.
