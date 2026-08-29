unit PlaylistItemsResponseUnit;

interface

uses
    System.Generics.Collections, System.JSON, HttpUtilUnit, PlaylistItemUnit;

type
    // https://developers.google.com/youtube/v3/docs/playlistItems/list
    TPlaylistItemsResponse = class
    private
        FPlaylistItems: TObjectList<TPlaylistItem>;
    public
        class function Parse(AContent: String): TPlaylistItemsResponse;
        constructor Create;
        destructor Destroy; override;
        property PlaylistItems: TObjectList<TPlaylistItem> read FPlaylistItems;
    end;

implementation

{ TPlaylistItemsResponse }

constructor TPlaylistItemsResponse.Create;
begin
    FPlaylistItems := TObjectList<TPlaylistItem>.Create;
end;

destructor TPlaylistItemsResponse.Destroy;
begin
    FPlaylistItems.Free;
end;

class function TPlaylistItemsResponse.Parse(AContent: String): TPlaylistItemsResponse;
var
    Json: TJSONObject;
    PlaylistItems: TJSONArray;
begin
    Json := TJsonObject.ParseJSONValue(AContent) as TJSONObject;
    Result := TPlaylistItemsResponse.Create;
    PlaylistItems := Json.FindValue('items') as TJSONArray;
    for var Index := 0 to PlaylistItems.Count - 1 do
        Result.PlaylistItems.Add(TPlaylistItem.Create(PlaylistItems.Items[Index]));
end;

end.
