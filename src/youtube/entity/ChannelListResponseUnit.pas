unit ChannelListResponseUnit;

interface

uses
    System.Generics.Collections, System.JSON, HttpUtilUnit, ChannelUnit, Vcl.Dialogs;

type
    // https://developers.google.com/youtube/v3/docs/channels/list
    TChannelListResponse = class
    private
        FChannels: TObjectList<TChannel>;
    public
        class function Parse(AResponse: THttpResponse): TChannelListResponse;
        constructor Create;
        destructor Destroy; override;
        property Channels: TObjectList<TChannel> read FChannels;
    end;

implementation

{ TChannelListResponse }

constructor TChannelListResponse.Create;
begin
    FChannels := TObjectList<TChannel>.Create;
end;

destructor TChannelListResponse.Destroy;
begin
    FChannels.Free;
end;

class function TChannelListResponse.Parse(AResponse: THttpResponse): TChannelListResponse;
var
    Json: TJSONObject;
    Channels: TJSONArray;
begin
    Json := TJsonObject.ParseJSONValue(AResponse.Content) as TJSONObject;
    Result := TChannelListResponse.Create;
    Channels := Json.FindValue('items') as TJSONArray;
    for var Index := 0 to Channels.Count - 1 do
        Result.Channels.Add(TChannel.Create(Channels.Items[Index]));
end;

end.
