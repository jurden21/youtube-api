unit ChannelServiceUnit;

interface

uses
    UrlServiceUnit;

type
    IChannelService = interface

    end;
    TChannelService = class(TInterfacedObject, IChannelService)
    private
        UrlService: IUrlService;
    public
        constructor Create(AUrlService: IUrlService);
    end;

implementation

{ TChannelService }

constructor TChannelService.Create(AUrlService: IUrlService);
begin
    UrlService := AUrlService;
end;

end.
