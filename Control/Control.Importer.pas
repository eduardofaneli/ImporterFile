unit Control.Importer;

interface

uses
  System.Classes, Vcl.ComCtrls, Vcl.StdCtrls;

type
  IControlImporter = interface
    ['{379A8D55-FD1E-4AB1-8E4D-B21F2ECA6640}']
    function GetFileImport: TStringList;
    procedure SetFileImport(const Value: TStringList);
    function execute(): IControlImporter;
    function GetLabelStatus: TLabel;
    function GetProgressBar: TProgressBar;
    procedure SetLabelStatus(const Value: TLabel);
    procedure SetProgressBar(const Value: TProgressBar);
    function GetLayoutIdentifier: string;
    procedure SetLayoutIdentifier(const Value: string);
    property FileImport: TStringList read GetFileImport write SetFileImport;
    property ProgressBar: TProgressBar read GetProgressBar write SetProgressBar;
    property LabelStatus: TLabel read GetLabelStatus write SetLabelStatus;
    property LayoutIdentifier: string read GetLayoutIdentifier write SetLayoutIdentifier;
  end;
  TControlImporter = class(TInterfacedObject, IControlImporter)
  private
    FFileImport: TStringList;
    FProgressBar: TProgressBar;
    FLabelStatus: TLabel;
    FLayoutIdentifier: string;
    function GetFileImport: TStringList;
    procedure SetFileImport(const Value: TStringList);
    function GetLabelStatus: TLabel;
    function GetProgressBar: TProgressBar;
    procedure SetLabelStatus(const Value: TLabel);
    procedure SetProgressBar(const Value: TProgressBar);
    function GetLayoutIdentifier: string;
    procedure SetLayoutIdentifier(const Value: string);
    { private declarations }
  protected
    constructor Create();
    destructor Destroy(); override;
    procedure processLine(ALine: string);
    { protected declarations }
  public
    class function new(const ALayoutIdentifier: string): IControlImporter;
    function execute(): IControlImporter;
    property FileImport: TStringList read GetFileImport write SetFileImport;
    property ProgressBar: TProgressBar read GetProgressBar write SetProgressBar;
    property LabelStatus: TLabel read GetLabelStatus write SetLabelStatus;
    property LayoutIdentifier: string read GetLayoutIdentifier write SetLayoutIdentifier;
    { public declarations }
  end;

implementation

uses
  System.Generics.Collections, DAO.LAYOUT, Model.LayoutTemplate, System.Types,
  System.SysUtils, System.Variants, Vcl.Forms, Model.LayoutName;

{ TControlImporter }

constructor TControlImporter.Create();
begin
  FFileImport := TStringList.Create;
end;

destructor TControlImporter.Destroy;
begin
  FreeAndNil(FFileImport);
  inherited;
end;

function TControlImporter.execute: IControlImporter;
var
  line: string;
  index: Integer;
begin
  try
    if Assigned(ProgressBar) then
    begin
      ProgressBar.Min := 0;
      ProgressBar.Max := Pred(FileImport.Count);
      ProgressBar.Step := 1;
    end;
    if Assigned(LabelStatus) then
      LabelStatus.Caption := Format('Linhas carregadas: %s', [FileImport.Count.ToString]);
    index := 0;
    if FileImport.Count > 0 then
    for line in FileImport do
    begin
      processLine(line);

      if Assigned(LabelStatus) then
      begin
        LabelStatus.Caption := Format('Importando: %s de %s', [index.ToString, Pred(FileImport.Count).ToString]);
      end;
      if Assigned(ProgressBar) then
        ProgressBar.Position := index;
      Inc(index);
      Application.ProcessMessages;
    end;
  finally
    Result := Self;
  end;
end;

function TControlImporter.GetFileImport: TStringList;
begin
  Result := FFileImport;
end;

function TControlImporter.GetLabelStatus: TLabel;
begin
  Result := FLabelStatus;
end;

function TControlImporter.GetLayoutIdentifier: string;
begin
  Result := FLayoutIdentifier;
end;

function TControlImporter.GetProgressBar: TProgressBar;
begin
  Result := FProgressBar;
end;

class function TControlImporter.new(const ALayoutIdentifier: string): IControlImporter;
begin
  Result := Self.Create;
  Result.LayoutIdentifier := ALayoutIdentifier;
end;

procedure TControlImporter.processLine(ALine: string);
var
  line: TArray<string>;
  layout: TList<IModelLayoutTemplate>;
  I: Integer;
  layoutInformation: IModelLayoutName;
begin
  try
    try
      layoutInformation := TDAOLayout.new(LayoutIdentifier).getLayoutInformation();
      line := ALine.Trim.Split([layoutInformation.separator], None);
      layout := TDAOLayout.new(LayoutIdentifier).getLayoutTemplate();

      for I := 0 to Length(line) - 1 do
      begin
        if line[I].IsEmpty then
          layout[I].fieldValue := Null
        else
          layout[I].fieldValue := line[I];
      end;
      TDAOLayout.new(LayoutIdentifier).insertRow(layoutInformation, layout);
    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
    if Assigned(layout) then
      while layout.Count > 0 do
      begin
        layout.Delete(0);
      end;
      FreeAndNil(layout);
  end;
end;

procedure TControlImporter.SetFileImport(const Value: TStringList);
begin
  FFileImport := Value;
end;

procedure TControlImporter.SetLabelStatus(const Value: TLabel);
begin
  FLabelStatus := Value;
end;

procedure TControlImporter.SetLayoutIdentifier(const Value: string);
begin
  FLayoutIdentifier := Value;
end;

procedure TControlImporter.SetProgressBar(const Value: TProgressBar);
begin
  FProgressBar := Value;
end;

end.
