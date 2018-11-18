unit View.Importer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Database.Core, Control.Main, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtDlgs, System.Classes, Vcl.WinXPanels,
  Vcl.WinXCtrls, Vcl.Imaging.pngimage, Vcl.ComCtrls;

type
  TViewImporter = class(TForm)
    pnlMain: TPanel;
    odTextFile: TOpenTextFileDialog;
    cardPanelImporter: TCardPanel;
    cardNewLayout: TCard;
    cardListLayout: TCard;
    svMenu: TSplitView;
    cardHome: TCard;
    cardImporter: TCard;
    gbArquivo: TGroupBox;
    btnAbrirArquivo: TSpeedButton;
    edtArquivo: TEdit;
    Button2: TButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    pnlExpand: TPanel;
    imgExpand: TImage;
    pnlListLayouts: TPanel;
    pnlStatus: TPanel;
    imgHome: TImage;
    pbStatus: TProgressBar;
    lblStatus: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAbrirArquivoClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure imgExpandClick(Sender: TObject);
  private
    FFile: TStringList;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewImporter: TViewImporter;

implementation

uses
  DAO.LAYOUT, System.Generics.Collections, Model.LayoutTemplate,
  Control.Importer;

{$R *.dfm}

procedure TViewImporter.btnAbrirArquivoClick(Sender: TObject);
begin
  if (odTextFile.Execute(Handle)) then
  begin
    edtArquivo.Text := odTextFile.FileName;
  end;
end;

procedure TViewImporter.Button2Click(Sender: TObject);
var
  importer: IControlImporter;
  line: string;
begin
  try
    if FileExists(Trim(edtArquivo.Text)) then
    begin
      importer := TControlImporter.new();
      importer.FileImport.LoadFromFile(Trim(edtArquivo.Text), TEncoding.UTF8);
      importer.LabelStatus := lblStatus;
      importer.ProgressBar := pbStatus;
      importer.execute();

      Application.MessageBox('Importação concluída.', 'Informação', MB_ICONINFORMATION);
    end;
  except on E: Exception do
    Application.MessageBox(PChar(E.Message), 'Erro', MB_ICONERROR);
  end;
end;

procedure TViewImporter.FormCreate(Sender: TObject);
begin
  TControlMain.getInstance().database.connect();
end;

procedure TViewImporter.FormDestroy(Sender: TObject);
begin
  TControlMain.getInstance().Free;
end;

procedure TViewImporter.imgExpandClick(Sender: TObject);
begin
  svMenu.Opened := not svMenu.Opened;
end;

procedure TViewImporter.SpeedButton2Click(Sender: TObject);
begin
  cardPanelImporter.ActiveCard := cardImporter;
end;

procedure TViewImporter.SpeedButton3Click(Sender: TObject);
begin
  cardPanelImporter.ActiveCard := cardListLayout
end;

procedure TViewImporter.SpeedButton4Click(Sender: TObject);
begin
  cardPanelImporter.ActiveCard := cardHome;
end;

end.

