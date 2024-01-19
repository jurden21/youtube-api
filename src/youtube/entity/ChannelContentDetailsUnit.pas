unit ChannelContentDetailsUnit;

interface

uses
    System.SysUtils, System.JSON;

type
    /// <summary>https://developers.google.com/youtube/v3/docs/channels#contentDetails.relatedPlaylists</summary>
    TRelatedPlaylistsData = class
    private
        FUploads: String;
    public
        /// <summary>https://developers.google.com/youtube/v3/docs/channels#contentDetails.relatedPlaylists.uploads</summary>
        property Uploads: String read FUploads;
        constructor Create(AJson: TJSONValue);
        function ToString: String; override;
    end;

    /// <summary>https://developers.google.com/youtube/v3/docs/channels#contentDetails</summary>
    TChannelContentDetails = class
    private
        FRelatedPlaylists: TRelatedPlaylistsData;
    public
        /// <summary>https://developers.google.com/youtube/v3/docs/channels#contentDetails.relatedPlaylists</summary>
        property RelatedPlaylists: TRelatedPlaylistsData read FRelatedPlaylists;
        constructor Create(AJson: TJSONValue);
        function ToString: String; override;
    end;

implementation

uses
  JsonUtilUnit;

{ TRelatedPlaylistsData }

constructor TRelatedPlaylistsData.Create(AJson: TJSONValue);
begin
    FUploads := TJsonUtil.ReadString(AJson, 'uploads');
end;

function TRelatedPlaylistsData.ToString: String;
begin
    Result := Format('TRelatedPlaylistsData{Uploads=%s}', [FUploads]);
end;

{ TChannelContentDetails }

constructor TChannelContentDetails.Create(AJson: TJSONValue);
begin
    FRelatedPlaylists := TRelatedPlaylistsData.Create(AJson.FindValue('relatedPlaylists'));
end;

function TChannelContentDetails.ToString: String;
begin
    Result := Format('TChannelContentDetails{RelatedPaylists=%s}', [FRelatedPlaylists.ToString]);
end;

end.
