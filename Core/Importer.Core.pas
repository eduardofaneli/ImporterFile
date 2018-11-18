unit Importer.Core;

interface

uses
  Database.Core;

type
  TImporterCore = class abstract
  private
    Fdatabase: TDatabase;
    function Getdatabase: TDatabase;
    procedure Setdatabase(const Value: TDatabase);
  public
    constructor create();
    destructor Destroy; override;
    property database: TDatabase read Getdatabase write Setdatabase;
  end;

implementation

uses
  System.SysUtils;

{ TImporterCore }

constructor TImporterCore.create;
begin
  Fdatabase := TDatabase.create();
end;

destructor TImporterCore.Destroy;
begin
  FreeAndNil(FDatabase);
  inherited;
end;

function TImporterCore.Getdatabase: TDatabase;
begin
  Result := Fdatabase;
end;

procedure TImporterCore.Setdatabase(const Value: TDatabase);
begin
  Fdatabase := Value;
end;

end.

