unit PlaylistItemResourceIdUnit;

interface

uses
    System.SysUtils, System.Json;

type
    TPlaylistItemResourceId = class
    private
        FVideoId: String;
        FKind: String;
    public
        property VideoId: String read FVideoId;
        property Kind: String read FKind;
        constructor Create(AJson: TJSONValue);
        function ToString: String; override;
    end;

implementation

uses
    JsonUtilUnit;

{ TPlaylistItemResourceId }

constructor TPlaylistItemResourceId.Create(AJson: TJSONValue);
begin
    FVideoId := TJsonUtil.ReadString(AJson, 'videoId');
    FKind := TJsonUtil.ReadString(AJson, 'kind');
end;

function TPlaylistItemResourceId.ToString: String;
begin
    Result := Format('TPlaylistItemResourceId{VideoId=%s, Kind=%s}',
                  [FVideoId, FKind]);
end;

end.
