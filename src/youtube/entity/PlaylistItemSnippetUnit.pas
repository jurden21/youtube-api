unit PlaylistItemSnippetUnit;

interface

uses
    System.SysUtils, System.Json, PlaylistItemResourceIdUnit;

type
    TPlaylistItemSnippet = class
    private
        FTitle: String;
        FChannelId: String;
        FChannelTitle: String;
        FPlaylistId: String;
        FPublishedAt: String;
        FResourceId: TPlaylistItemResourceId;
    public
        property Title: String read FTitle;
        property ChannelId: String read FChannelId;
        property ChannelTitle: String read FChannelTitle;
        property PlaylistId: String read FPlaylistId;
        property ResourceId: TPlaylistItemResourceId read FResourceId;
        constructor Create(AJson: TJSONValue);
        function ToString: String; override;
    end;

implementation

uses
    JsonUtilUnit;

{ TPlaylistItemSnippet }

constructor TPlaylistItemSnippet.Create(AJson: TJSONValue);
begin
    FTitle := TJsonUtil.ReadString(AJson, 'title');
    FChannelId := TJsonUtil.ReadString(AJson, 'channelId');
    FChannelTitle := TJsonUtil.ReadString(AJson, 'channelTitle');
    FPlaylistId := TJsonUtil.ReadString(AJson, 'playlistId');
    FPublishedAt := TJsonUtil.ReadDateTimeText(AJson, 'publishedAt');
    FResourceId := TPlaylistItemResourceId.Create(AJson.FindValue('resourceId'));
end;

function TPlaylistItemSnippet.ToString: String;
begin
    Result := Format('TPlaylistItemSnippet{Title=%s, ChannelId=%s, ChannelTitle=%s, PlaylistId=%s, PublishedAt=%s, ResourceId=%s}',
                   [FTitle, FChannelId, FChannelTitle, FPlaylistId, FPublishedAt, FResourceId.ToString]);
end;

end.
