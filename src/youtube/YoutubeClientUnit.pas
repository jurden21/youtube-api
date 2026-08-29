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
    IYoutubeClient = interface
        function ChannelsByChannelId(AChannelId: String): TChannelsResponse;
        function ChannelsByHandle(AHandle: String): TChannelsResponse;
        function ChannelsByUsername(AUsername: String): TChannelsResponse;
        function PlaylistItemsByPlaylistId(APlaylistId: String; APageToken: String = ''): TPlaylistItemsResponse;
    end;

    TYoutubeClient = class(TInterfacedObject, IYoutubeClient)
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
    HttpClientUnit;

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
    Response: String;
begin
    var Url: String := UrlService.ChannelsByChannelId(AChannelId);
    var HttpClient: IHttpClient := THttpClient.Create;
    Response := HttpClient.Get(Url);
    Result := TChannelsResponse.Parse(Response);
end;

// https://developers.google.com/youtube/v3/docs/channels/list
function TYoutubeClient.ChannelsByHandle(AHandle: String): TChannelsResponse;
var
    Response: String;
begin
    var Url: String := UrlService.ChannelsByChannelHandle(AHandle);
    var HttpClient: IHttpClient := THttpClient.Create;
    Response := HttpClient.Get(Url);
    Result := TChannelsResponse.Parse(Response);
end;

// https://developers.google.com/youtube/v3/docs/channels/list
function TYoutubeClient.ChannelsByUsername(AUsername: String): TChannelsResponse;
var
    Response: String;
begin
    var Url: String := UrlService.ChannelsByUsername(AUsername);
    var HttpClient: IHttpClient := THttpClient.Create;
    Response := HttpClient.Get(Url);
    Result := TChannelsResponse.Parse(Response);
end;

// https://developers.google.com/youtube/v3/docs/playlistItems/list
function TYoutubeClient.PlaylistItemsByPlaylistId(APlaylistId, APageToken: String): TPlaylistItemsResponse;
var
    Response: String;
begin
    var Url: String := FUrlBuilder.PlaylistItemsByPlaylistId(APlaylistId, APageToken);
    var HttpClient: IHttpClient := THttpClient.Create;
    Response := HttpClient.Get(Url);
    Result := TPlaylistItemsResponse.Parse(Response);
end;

end.
