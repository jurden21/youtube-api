unit UrlBuilderUnit;

interface

uses
    System.SysUtils,
    System.StrUtils,
    System.Classes,
    KeyServiceUnit;

type
    TUrlBuilder = class
    private const
        PAIR_STR = '&%s=%s';
        API_URL = 'https://youtube.googleapis.com/youtube/v3/';
    private const
        CHANNELS_RESOURCE = 'channels';
        CHANNELS_PART = 'contentDetails,snippet';
        PLAYLISTITEMS_RESOURCE = 'playlistItems';
        PLAYLISTITEMS_PART = 'snippet';
        VIDEOS_RESOURCE = 'videos';
        VIDEOS_PART = 'contentDetails';
        SEARCH_RESOURCE = 'search';
        SEARCH_PART = 'snippet';
    private const
        PART_KEY = 'part';
        ID_KEY = 'id';
        HANDLE_KEY = 'forHandle';
        USERNAME_KEY = 'forUsername';
        MAX_RESULTS_KEY = 'maxResults';
        PLAYLISTID_KEY = 'playlistId';
        PAGETOKEN_KEY = 'pageToken';
        TYPE_KEY = 'type';
        QUERY_KEY = 'q';
    private const
        MAX_RESULTS = 50;
    private
        KeyService: IKeyService;
    private
        function GetParamPair(AKey, AValue: String): String;
    public
        constructor Create(AKeyService: IKeyService);
        function ChannelsByChannelId(AChannelId: String): String;
        function ChannelsByHandle(AHandle: String): String;
        function ChannelsByUsername(AUsername: String): String;
        function PlaylistItemsByPlaylistId(APlaylistId: String; APageToken: String = ''; AMaxResults: Integer = MAX_RESULTS): String;
        function VideosByIds(AIds: TStringList): String;
        function SearchByKeyword(AType: String; AQuery: String; APageToken: String = ''; AMaxResults: Integer = MAX_RESULTS): String;
    end;

implementation

{ TUrlBuilder }

constructor TUrlBuilder.Create(AKeyService: IKeyService);
begin
    KeyService := AKeyService;
end;

function TUrlBuilder.GetParamPair(AKey, AValue: String): String;
begin
    if AValue <> ''
    then Result := Format(PAIR_STR, [AKey, AValue])
    else Result := '';
end;

function TUrlBuilder.ChannelsByChannelId(AChannelId: String): String;
begin
    Result := API_URL + CHANNELS_RESOURCE + KeyService.GetKey +
        GetParamPair(PART_KEY, CHANNELS_PART) +
        GetParamPair(ID_KEY, AChannelId);
end;

function TUrlBuilder.ChannelsByHandle(AHandle: String): String;
begin
    Result := API_URL + CHANNELS_RESOURCE + KeyService.GetKey +
        GetParamPair(PART_KEY, CHANNELS_PART) +
        GetParamPair(HANDLE_KEY, AHandle);
end;

function TUrlBuilder.ChannelsByUsername(AUsername: String): String;
begin
    Result := API_URL + CHANNELS_RESOURCE + KeyService.GetKey +
        GetParamPair(PART_KEY, CHANNELS_PART) +
        GetParamPair(USERNAME_KEY, AUsername);
end;

function TUrlBuilder.PlaylistItemsByPlaylistId(APlaylistId: String; APageToken: String = ''; AMaxResults: Integer = MAX_RESULTS): String;
begin
    Result := API_URL + PLAYLISTITEMS_RESOURCE + KeyService.GetKey +
        GetParamPair(PAGETOKEN_KEY, APageToken) +
        GetParamPair(PART_KEY, PLAYLISTITEMS_PART) +
        GetParamPair(MAX_RESULTS_KEY, AMaxResults.ToString) +
        GetParamPair(PLAYLISTID_KEY, APlaylistId);
end;

function TUrlBuilder.VideosByIds(AIds: TStringList): String;
begin
    AIds.Delimiter := ',';
    Result := API_URL + VIDEOS_RESOURCE + KeyService.GetKey +
        GetParamPair(PART_KEY, VIDEOS_PART) +
        GetParamPair(ID_KEY, AIds.DelimitedText);
end;

function TUrlBuilder.SearchByKeyword(AType, AQuery: String; APageToken: String = ''; AMaxResults: Integer = MAX_RESULTS): String;
begin
    Result := API_URL + SEARCH_RESOURCE + KeyService.GetKey +
        GetParamPair(PAGETOKEN_KEY, APageToken) +
        GetParamPair(PART_KEY, SEARCH_PART) +
        GetParamPair(MAX_RESULTS_KEY, AMaxResults.ToString) +
        GetParamPair(TYPE_KEY, AType) +
        GetParamPair(QUERY_KEY, AQuery);
end;

end.
