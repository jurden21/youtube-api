unit ChannelUnit;

interface

uses
    System.SysUtils, System.Json,
    ChannelSnippetUnit, ChannelContentDetailsUnit;

type
    /// <summary>https://developers.google.com/youtube/v3/docs/channels#resource-representation</summary>
    TChannel = class
    private
        FId: String;
        FKind: String;
        FSnippet: TChannelSnippet;
        FContentDetails: TChannelContentDetails;
    public
        /// <summary>https://developers.google.com/youtube/v3/docs/channels#id</summary>
        property Id: String read FId;
        /// <summary>https://developers.google.com/youtube/v3/docs/channels#kind</summary>
        property Kind: String read FKind;
        /// <summary>https://developers.google.com/youtube/v3/docs/channels#snippet</summary>
        property Snippet: TChannelSnippet read FSnippet;
        /// <summary>https://developers.google.com/youtube/v3/docs/channels#contentDetails</summary>
        property ContentDetails: TChannelContentDetails read FContentDetails;
        constructor Create(AJson: TJSONValue); overload;
        function ToString: String; override;
    end;

implementation

uses
    JsonUtilUnit;

{ TChannel }

constructor TChannel.Create(AJson: TJSONValue);
begin
    FId := TJsonUtil.ReadString(AJson, 'id');
    FKind := TJsonUtil.ReadString(AJson, 'kind');
    FSnippet := TChannelSnippet.Create(AJson.FindValue('snippet'));
    FContentDetails := TChannelContentDetails.Create(AJson.FindValue('contentDetails'));
end;

function TChannel.ToString: String;
begin
    Result := Format('TChannel{Id=%s, Kind=%s, Snippet=%s, ContentDetails=%s}', [FId, FKind, FSnippet.ToString, FContentDetails.ToString]);
end;

end.
