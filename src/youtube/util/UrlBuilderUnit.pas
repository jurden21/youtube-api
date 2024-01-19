unit UrlBuilderUnit;

interface

uses
    System.SysUtils;

type
    TUrlBuilder = class
    private const
        API_URL = 'https://youtube.googleapis.com/youtube/v3/';
        CHANNELS_RESOURCE = 'channels';
        CHANNELS_PART = 'contentDetails,snippet';
    private
        FKey: String;
    public
        constructor Create(AKey: String);
        function ChannelsListByChannelId(AChannelId: String): String;
        function ChannelsListByUsername(AUsername: String): String;
    end;

implementation

{ TUrlBuilder }

constructor TUrlBuilder.Create(AKey: String);
begin
    FKey := AKey;
end;

function TUrlBuilder.ChannelsListByChannelId(AChannelId: String): String;
begin
    Result := Format('%s%s?part=%s&id=%s&key=%s', [API_URL, CHANNELS_RESOURCE, CHANNELS_PART, AChannelId, FKey]);
end;

function TUrlBuilder.ChannelsListByUsername(AUsername: String): String;
begin
    Result := Format('%s%s?part=%s&forUsername=%s&key=%s', [API_URL, CHANNELS_RESOURCE, CHANNELS_PART, AUsername, FKey]);
end;

end.
