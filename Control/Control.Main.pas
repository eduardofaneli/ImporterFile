unit Control.Main;

interface

uses
  Importer.Core;

type
  TControlMain = class(TImporterCore)
  private
    class var FInstance: TImporterCore;
  public
    class function getInstance(): TImporterCore;
  end;
implementation

{ TControlMain }

class function TControlMain.getInstance: TImporterCore;
begin
  if not Assigned(FInstance) then
    FInstance := Self.Create;
  Result := FInstance;
end;

end.
