program YoutubeApiTests;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  System.Generics.Collections,
  IniUtilUnit in 'util\IniUtilUnit.pas',
  ChannelUnit in 'youtube\entity\ChannelUnit.pas',
  ChannelContentDetailsUnit in 'youtube\entity\ChannelContentDetailsUnit.pas',
  ChannelSnippetUnit in 'youtube\entity\ChannelSnippetUnit.pas',
  YoutubeClientUnit in 'youtube\YoutubeClientUnit.pas',
  UrlBuilderUnit in 'youtube\util\UrlBuilderUnit.pas',
  HttpUtilUnit in 'youtube\util\HttpUtilUnit.pas',
  JsonUtilUnit in 'youtube\util\JsonUtilUnit.pas',
  ChannelsResponseUnit in 'youtube\entity\ChannelsResponseUnit.pas',
  PlaylistItemsResponseUnit in 'youtube\entity\PlaylistItemsResponseUnit.pas',
  PlaylistItemUnit in 'youtube\entity\PlaylistItemUnit.pas',
  PlaylistItemSnippetUnit in 'youtube\entity\PlaylistItemSnippetUnit.pas',
  PlaylistItemResourceIdUnit in 'youtube\entity\PlaylistItemResourceIdUnit.pas',
  ChannelServiceUnit in 'youtube\service\channel\ChannelServiceUnit.pas',
  ChannelUrlServiceUnit in 'youtube\service\channel\ChannelUrlServiceUnit.pas',
  KeyServiceUnit in 'youtube\service\util\KeyServiceUnit.pas';

var
    Key: String;
    Client: TYoutubeClient;
    Channels: TObjectList<TChannel>;
    PlaylistItems: TObjectList<TPlaylistItem>;
begin
    Key := TIniUtil.ReadString('Google', 'Key');
    Client := TYoutubeClient.Create(Key);

    try

        Writeln('Start ChannelsByChannelId... (id=UC_x5XG1OV2P6uZZ5FSM9Ttw)');
        Channels := Client.ChannelsByChannelId('UC_x5XG1OV2P6uZZ5FSM9Ttw').Channels;
        if (Channels <> nil)
        then begin
            Writeln('Channels.Count = ' + Channels.Count.ToString);
            for var Index := 0 to Channels.Count - 1 do
                Writeln(Channels[Index].ToString);
        end;
        Writeln('==============================================================');
        Writeln('');

        Writeln('Start ChannelsByHandle... (Handle=@GoogleDevelopers)');
        Channels := Client.ChannelsByHandle('@GoogleDevelopers').Channels;
        if (Channels <> nil)
        then begin
            Writeln('Channels.Count = ' + Channels.Count.ToString);
            for var Index := 0 to Channels.Count - 1 do
                Writeln(Channels[Index].ToString);
        end;
        Writeln('==============================================================');
        Writeln('');

        Writeln('Start ChannelsByUsername... (Username=GoogleDevelopers)');
        Channels := Client.ChannelsByUsername('GoogleDevelopers').Channels;
        if (Channels <> nil)
        then begin
            Writeln('Channels.Count = ' + Channels.Count.ToString);
            for var Index := 0 to Channels.Count - 1 do
                Writeln(Channels[Index].ToString);
        end;
        Writeln('==============================================================');
        Writeln('');

        Writeln('Start PlaylistItemsByPlaylistId... (PlaylistId=UU_x5XG1OV2P6uZZ5FSM9Ttw)');
        PlaylistItems := Client.PlaylistItemsByPlaylistId('UU_x5XG1OV2P6uZZ5FSM9Ttw').PlaylistItems;
        if (PlaylistItems <> nil)
        then begin
            Writeln('PlaylistItems.Count = ' + PlaylistItems.Count.ToString);
            for var Index := 0 to PlaylistItems.Count - 1 do
                Writeln(PlaylistItems[Index].ToString);
        end;
        Writeln('==============================================================');
        Writeln('');

    finally
        Client.Free;
    end;

    Writeln('Press ENTER...');
    Readln;

end.
