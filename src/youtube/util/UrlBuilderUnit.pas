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
        function ChannelsListByHandle(AHandle: String): String;
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
    Result := Format('%s%s?key=%s&part=%s&id=%s', [API_URL, CHANNELS_RESOURCE, FKey, CHANNELS_PART, AChannelId]);
end;

function TUrlBuilder.ChannelsListByHandle(AHandle: String): String;
begin
    Result := Format('%s%s?key=%s&part=%s&forHandle=%s', [API_URL, CHANNELS_RESOURCE, FKey, CHANNELS_PART, AHandle]);
end;

function TUrlBuilder.ChannelsListByUsername(AUsername: String): String;
begin
    Result := Format('%s%s?key=%s&part=%s&forUsername=%s', [API_URL, CHANNELS_RESOURCE, FKey, CHANNELS_PART, AUsername]);
end;

end.
