program FileImporter;

uses
  Vcl.Forms,
  View.Importer in 'View\View.Importer.pas' {ViewImporter},
  Model.LayoutName in 'Model\Model.LayoutName.pas',
  Database.Core in 'Core\Database\Database.Core.pas',
  Message.Default in 'Core\Messages\Message.Default.pas',
  Message.Error in 'Core\Messages\Message.Error.pas',
  Importer.Core in 'Core\Importer.Core.pas',
  Control.Main in 'Control\Control.Main.pas',
  DAO.LAYOUT in 'DAO\DAO.LAYOUT.pas',
  Model.LayoutTemplate in 'Model\Model.LayoutTemplate.pas',
  Control.Importer in 'Control\Control.Importer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewImporter, ViewImporter);
  Application.Run;

  ReportMemoryLeaksOnShutdown := True;
end.
