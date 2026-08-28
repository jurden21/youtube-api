unit YoutubeClientUnit;

interface

uses
    System.Generics.Collections,
    KeyServiceUnit,
    UrlServiceUnit,
    UrlBuilderUnit,
    ChannelsResponseUnit,
    PlaylistItemsResponseUnit;

type
    TYoutubeClient = class
    private
        KeyService: IKeyService;
        UrlService: IUrlService;
        FUrlBuilder: TUrlBuilder;
    public
        constructor Create(AKey: String);
        destructor Destroy; override;
        function ChannelsByChannelId(AChannelId: String): TChannelsResponse;
        function ChannelsByHandle(AHandle: String): TChannelsResponse;
        function ChannelsByUsername(AUsername: String): TChannelsResponse;
        function PlaylistItemsByPlaylistId(APlaylistId: String; APageToken: String = ''): TPlaylistItemsResponse;
    end;

implementation

uses
    HttpUtilUnit;

{ TYoutubeClient }

constructor TYoutubeClient.Create(AKey: String);
begin
    KeyService := TKeyService.Create(AKey);
    UrlService := TUrlService.Create(KeyService);
    FUrlBuilder := TUrlBuilder.Create(KeyService);
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
    Request.Url := UrlService.ChannelsByChannelId(AChannelId);
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

// https://developers.google.com/youtube/v3/docs/playlistItems/list
function TYoutubeClient.PlaylistItemsByPlaylistId(APlaylistId, APageToken: String): TPlaylistItemsResponse;
var
    Request: THttpRequest;
    Response: THttpResponse;
begin
    Request.Url := FUrlBuilder.PlaylistItemsByPlaylistId(APlaylistId, APageToken);
    Response := THttpUtil.Execute(Request);
    Result := TPlaylistItemsResponse.Parse(Response);
end;

end.
