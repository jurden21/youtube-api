unit ChannelUrlServiceUnit;

interface

uses
    KeyServiceUnit;

type
    IChannelUrlService = interface
        function ChannelsByChannelId(AChannelId: String): String;
    end;

    TChannelUrlService = class(TInterfacedObject, IChannelUrlService)
    private const
        API_URL = 'https://youtube.googleapis.com/youtube/v3/';
        CHANNELS_RESOURCE = 'channels';
    private
        KeyService: IKeyService;
    public
        constructor Create(AKeyService: IKeyService);
        function ChannelsByChannelId(AChannelId: String): String;
    end;

implementation

{ TChannelUrlService }

constructor TChannelUrlService.Create(AKeyService: IKeyService);
begin
    KeyService := AKeyService;
end;

function TChannelUrlService.ChannelsByChannelId(AChannelId: String): String;
begin
//    Result := API_URL + CHANNELS_RESOURCE + GetKeyPair +
//        GetParamPair(PART_KEY, CHANNELS_PART) +
//        GetParamPair(ID_KEY, AChannelId);
end;

end.
