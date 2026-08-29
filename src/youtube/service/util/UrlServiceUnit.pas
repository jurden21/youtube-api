unit UrlServiceUnit;

interface

uses
    KeyServiceUnit;

type
    IUrlService = interface
        function ChannelsByChannelId(AChannelId: String): String;
        function ChannelsByChannelHandle(AChannelHandle: String): String;
        function ChannelsByUsername(AUsername: String): String;
    end;

    TUrlService = class (TInterfacedObject, IUrlService)
    private const
        URL: String = 'https://youtube.googleapis.com/youtube/v3/';
    private const
        // https://developers.google.com/youtube/v3/docs/channels/list
        CHANNELS_RESOURCE: String = 'channels';
    private const
        // https://developers.google.com/youtube/v3/docs/channels/list
        // auditDetails brandingSettings contentDetails contentOwnerDetails id localizations snippet statistics status topicDetails
        CHANNELS_PART: String = 'contentDetails,snippet';
        // CHANNEL_PART: String = 'contentDetails,snippet';
    private const
        PAIR_STR = '&%s=%s';
    private const
        PART_PARAM_NAME = 'part';
        ID_PARAM_NAME = 'id';
        HANDLE_PARAM_NAME = 'forHandle';
        USERNAME_PARAM_NAME = 'forUsername';
    private
        KeyService: IKeyService;
        function GetParamValue(AName, AValue: String): String;
        function GetPartParamValue(AValue: String): String;
        function GetIdParamValue(AValue: String): String;
        function GetHandleParamValue(AValue: String): String;
        function GetUsernameParamValue(AValue: String): String;
    public
        constructor Create(AKeyService: IKeyService);
        function ChannelsByChannelId(AChannelId: String): String;
        function ChannelsByChannelHandle(AChannelHandle: String): String;
        function ChannelsByUsername(AUsername: String): String;
    end;

implementation

uses
    System.SysUtils;

{ TUrlService }

constructor TUrlService.Create(AKeyService: IKeyService);
begin
    KeyService := AKeyService;
end;

function TUrlService.GetParamValue(AName, AValue: String): String;
begin
    if (AName.Trim <> '') and (AValue.Trim <> '')
    then Result := Format(PAIR_STR, [AName, AValue])
    else Result := '';
end;

function TUrlService.GetPartParamValue(AValue: String): String;
begin
    Result := GetParamValue(PART_PARAM_NAME, AValue);
end;

function TUrlService.GetIdParamValue(AValue: String): String;
begin
    Result := GetParamValue(ID_PARAM_NAME, AValue);
end;

function TUrlService.GetHandleParamValue(AValue: String): String;
begin
    Result := GetParamValue(HANDLE_PARAM_NAME, AValue);
end;

function TUrlService.GetUsernameParamValue(AValue: String): String;
begin
    Result := GetParamValue(USERNAME_PARAM_NAME, AValue);
end;

function TUrlService.ChannelsByChannelId(AChannelId: String): String;
begin
    Result := URL + CHANNELS_RESOURCE + KeyService.GetKey + GetPartParamValue(CHANNELS_PART) + GetIdParamValue(AChannelId);
end;

function TUrlService.ChannelsByChannelHandle(AChannelHandle: String): String;
begin
    Result := URL + CHANNELS_RESOURCE + KeyService.GetKey + GetPartParamValue(CHANNELS_PART) + GetHandleParamValue(AChannelHandle);
end;

function TUrlService.ChannelsByUsername(AUsername: String): String;
begin
    Result := URL + CHANNELS_RESOURCE + KeyService.GetKey + GetPartParamValue(CHANNELS_PART) + GetUsernameParamValue(AUsername);
end;

end.
