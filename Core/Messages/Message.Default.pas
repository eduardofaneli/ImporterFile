unit Message.Default;

interface

uses
  Vcl.Forms,
  System.SysUtils,
  Winapi.Windows;

type
  TMensagem = class
    public
      class function pergunta(AMensagem: string): Integer;
      class function informacao(AMensagem: string): Integer;
  end;

implementation

{ TMensagem }

class function TMensagem.informacao(AMensagem: string): Integer;
begin
  Result := Application.MessageBox(PChar(AMensagem), 'Informação', MB_ICONINFORMATION + MB_OK);
end;

class function TMensagem.pergunta(AMensagem: string): Integer;
begin
  Result := Application.MessageBox(PChar(AMensagem), 'Confirmar', MB_ICONQUESTION + MB_YESNO);
end;

end.
