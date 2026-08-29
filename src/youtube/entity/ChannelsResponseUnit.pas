unit ChannelsResponseUnit;

interface

uses
    System.Generics.Collections, System.JSON, ChannelUnit;

type
    // https://developers.google.com/youtube/v3/docs/channels/list
    TChannelsResponse = class
    private
        FChannels: TObjectList<TChannel>;
    public
        class function Parse(AContent: String): TChannelsResponse;
        constructor Create;
        destructor Destroy; override;
        property Channels: TObjectList<TChannel> read FChannels;
    end;

implementation

{ TChannelsResponse }

constructor TChannelsResponse.Create;
begin
    FChannels := TObjectList<TChannel>.Create;
end;

destructor TChannelsResponse.Destroy;
begin
    FChannels.Free;
end;

class function TChannelsResponse.Parse(AContent: String): TChannelsResponse;
var
    Json: TJSONObject;
    Channels: TJSONArray;
begin
    Json := TJsonObject.ParseJSONValue(AContent) as TJSONObject;
    Result := TChannelsResponse.Create;
    Channels := Json.FindValue('items') as TJSONArray;
    for var Index := 0 to Channels.Count - 1 do
        Result.Channels.Add(TChannel.Create(Channels.Items[Index]));
end;

end.
