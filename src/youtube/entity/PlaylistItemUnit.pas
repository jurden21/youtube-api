unit PlaylistItemUnit;

interface

uses
    System.SysUtils, System.Json, PlaylistItemSnippetUnit;

type
    TPlaylistItem = class
    private
        FId: String;
        FKind: String;
        FSnippet: TPlaylistItemSnippet;
    public
        property Id: String read FId;
        property Kind: String read FKind;
        property Snippet: TPlaylistItemSnippet read FSnippet;
        constructor Create(AJson: TJSONValue); overload;
        function ToString: String; override;
    end;

implementation

uses
    JsonUtilUnit;

{ TPlaylistItem }

constructor TPlaylistItem.Create(AJson: TJSONValue);
begin
    FId := TJsonUtil.ReadString(AJson, 'id');
    FKind := TJsonUtil.ReadString(AJson, 'kind');
    FSnippet := TPlaylistItemSnippet.Create(AJson.FindValue('snippet'));
end;

function TPlaylistItem.ToString: String;
begin
    Result := Format('TPlaylistItem{Id=%s, Kind=%s, Snippet=%s}',
                  [FId, FKind, FSnippet.ToString]);
end;

end.
