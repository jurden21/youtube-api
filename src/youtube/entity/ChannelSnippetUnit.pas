unit ChannelSnippetUnit;

interface

uses
    System.SysUtils, System.JSON;

type
    /// <summary>https://developers.google.com/youtube/v3/docs/channels#snippet</summary>
    TChannelSnippet = class
    private
        FTitle: String;
        FCustomUrl: String;
    public
        /// <summary>https://developers.google.com/youtube/v3/docs/channels#snippet.title</summary>
        property Title: String read FTitle;
        /// <summary>https://developers.google.com/youtube/v3/docs/channels#snippet.customUrl</summary>
        property CustomUrl: String read FCustomUrl;
        constructor Create(AJson: TJSONValue);
        function ToString: String; override;
    end;

implementation

uses
    JsonUtilUnit;

{ TChannelSnippet }

constructor TChannelSnippet.Create(AJson: TJSONValue);
begin
    FTitle := TJsonUtil.ReadString(AJson, 'title');
    FCustomUrl := TJsonUtil.ReadString(AJson, 'customUrl');
end;

function TChannelSnippet.ToString: String;
begin
    Result := Format('TChannelSnippet{Title=%s, CustomUrl=%s}', [FTitle, FCustomUrl]);
end;

end.
