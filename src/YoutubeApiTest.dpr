program YoutubeApiTest;

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
  ChannelsResponseUnit in 'youtube\entity\ChannelsResponseUnit.pas';

var
    Key: String;
    Client: TYoutubeClient;
    Channels: TObjectList<TChannel>;

begin
    Key := TIniUtil.ReadString('Google', 'Key');
    Client := TYoutubeClient.Create(Key);

    try

        Writeln('Start ChannelsListByChannelId... (id=UC_x5XG1OV2P6uZZ5FSM9Ttw)');
        Channels := Client.ChannelsListByChannelId('UC_x5XG1OV2P6uZZ5FSM9Ttw').Channels;
        if (Channels <> nil)
        then begin
            Writeln('Channels.Count = ' + Channels.Count.ToString);
            for var Index := 0 to Channels.Count - 1 do
                Writeln(Channels[Index].ToString);
        end;
        Writeln('==============================================================');
        Writeln('');

        Writeln('Start ChannelsListByHandle... (Handle=@GoogleDevelopers)');
        Channels := Client.ChannelsListByHandle('@GoogleDevelopers').Channels;
        if (Channels <> nil)
        then begin
            Writeln('Channels.Count = ' + Channels.Count.ToString);
            for var Index := 0 to Channels.Count - 1 do
                Writeln(Channels[Index].ToString);
        end;
        Writeln('==============================================================');
        Writeln('');

        Writeln('Start ChannelsListByUsername... (Username=GoogleDevelopers)');
        Channels := Client.ChannelsListByUsername('GoogleDevelopers').Channels;
        if (Channels <> nil)
        then begin
            Writeln('Channels.Count = ' + Channels.Count.ToString);
            for var Index := 0 to Channels.Count - 1 do
                Writeln(Channels[Index].ToString);
        end;
        Writeln('==============================================================');
        Writeln('');

    finally
        Client.Free;
    end;

    Writeln('Press ENTER...');
    Readln;

end.
