unit Message.Error;

interface

uses
  System.Classes,
  System.SysUtils;

type
  TMessageError = class(Exception)
    public
      function getMessage(const id: string): string;

      constructor Create(const Msg: string);overload;
      destructor destroy();override;
  end;

  TMessageBusiness = class(TMessageError)
  end;

implementation

{ TMessageError }

constructor TMessageError.Create(const Msg: string);
begin
  inherited Create(Msg);

end;

destructor TMessageError.destroy;
begin

  inherited;
end;

function TMessageError.getMessage(const id: string): string;
begin

end;

end.
