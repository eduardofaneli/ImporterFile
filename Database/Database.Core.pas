unit Database.Core;

interface

uses
  Vcl.Forms,
  System.SysUtils,
  Vcl.Controls,
  System.Variants,
  Vcl.Dialogs,
  FireDAC.Comp.Client,
  System.Rtti,
  System.Classes,
  System.IniFiles;

type
  TDatabase = class
    private
      FServer: string;
      FPath: string;
      FPort: string;
      FConnection: TFDConnection;
    public
      property server: string read FServer write FServer;
      property path: string read FPath write FPath;
      property port: string read FPort write FPort;
      property connection: TFDConnection read FConnection;

      function loadConfigFile(): TDatabase;
      function saveConfigFile(): TDatabase;
      function connect(): TDatabase;
      procedure manageErro(AErro: Exception);

      constructor create();
      destructor destroy; override;
  end;

implementation

uses
  System.StrUtils,
  Message.Error;

{ TDatabase }

function TDatabase.connect: TDatabase;
begin

  loadConfigFile();
  try
    FConnection.Close;
    FConnection.Params.Values['User_Name'] := 'sysdba';
    FConnection.Params.Values['Password']  := 'masterkey';
    FConnection.Params.Values['Database']  := path;
    FConnection.Params.Values['Port'] := port;
    FConnection.Params.Values['Server'] := server;
    FConnection.Params.Values['DriverID']  := 'FB';
    FConnection.Open();

  except
    on E:Exception do
      raise TMessageError.Create('Problema ao conectar ao banco de dados: ' + e.Message);
  end;

  Result := Self;
end;

constructor TDatabase.create;
begin
  FConnection := TFDConnection.Create(nil);
end;

destructor TDatabase.Destroy;
begin
  FreeAndNil(FConnection);

  inherited;
end;

function TDatabase.loadConfigFile: TDatabase;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
  try
    server := ini.ReadString('DATABASE','Server', '');
    path := ini.ReadString('DATABASE','Path', '');
    port := ini.ReadString('DATABASE','Port', '');
  finally
    FreeAndNil(ini);
  end;

  Result := Self;
end;

procedure TDatabase.manageErro(AErro: Exception);
begin
  if ContainsText(AErro.Message, 'reference target does not exist') then
    raise TMessageBusiness.Create('Valor chave não informado.')
  else
  if ContainsText(AErro.Message, 'FOREIGN') then
    raise TMessageBusiness.Create('Não pode remover um registro que possui dependências.')
  else
  if ContainsText(AErro.Message, 'PRIMARY') then
    raise TMessageBusiness.Create('Um registro já foi inserido com este mesmos dados, por favor verifique.')
  else
    raise TMessageError.Create(AErro.Message);

end;

function TDatabase.saveConfigFile: TDatabase;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
  try
    ini.WriteString('DATABASE','Server', server);
    ini.WriteString('DATABASE','Path', path);
    ini.WriteString('DATABASE','Port', port);
  finally
    FreeAndNil(ini);
  end;

  Result := Self;
end;

end.
