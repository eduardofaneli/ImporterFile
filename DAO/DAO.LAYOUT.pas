unit DAO.LAYOUT;

interface

uses
  Database.Core, System.Generics.Collections, System.Classes, Model.LayoutTemplate,
  FireDAC.Comp.Client, Model.LayoutName;

type
  IDAOLayout = interface
    ['{A5982793-559B-4671-A700-56E0535DCAE2}']
    function GetIdentifier: string;
    procedure SetIdentifier(const Value: string);
    function getLayoutTemplate(): TList<IModelLayoutTemplate>;
    function getLayoutInformation(): IModelLayoutName;
    function insertRow(const ALayoutInformation: IModelLayoutName; const ALayoutTemplate: TList<IModelLayoutTemplate>): IDAOLayout;
    property Identifier: string read GetIdentifier write SetIdentifier;
  end;

  TDAOLayout = class(TInterfacedObject, IDAOLayout)
  protected
    function generateSQL(const ALayoutInformation: IModelLayoutName; const ALayoutTemplate: TList<IModelLayoutTemplate>): string;
  private
    FIdentifier: string;
    function GetIdentifier: string;
    procedure SetIdentifier(const Value: string);
  public
    class function new(const AIdentifier: string): IDAOLayout;
    function getLayoutTemplate(): TList<IModelLayoutTemplate>;
    function getLayoutInformation(): IModelLayoutName;
    function insertRow(const ALayoutInformation: IModelLayoutName; const ALayoutTemplate: TList<IModelLayoutTemplate>): IDAOLayout;
    property Identifier: string read GetIdentifier write SetIdentifier;
  end;

implementation

uses
  System.SysUtils, Control.Main, FireDAC.DApt, System.Variants, FireDAC.Phys,
  FireDAC.Stan.Param;

{ TDAOLayout }

function TDAOLayout.generateSQL(const ALayoutInformation: IModelLayoutName; const ALayoutTemplate: TList<IModelLayoutTemplate>): string;
var
  sql: TStringBuilder;
  I: Integer;
  valueField: string;
begin
  try
    sql := TStringBuilder.Create;
    try
      sql.Append('INSERT INTO ')
         .Append('"')
         .Append(ALayoutInformation.owner)
         .Append('".')
         .Append(ALayoutInformation.table)
         .Append('(');

      for I := 0 to Pred(ALayoutTemplate.Count) do
        if I = 0 then
          sql.Append(ALayoutTemplate[I].field)
        else
          sql.AppendLine(Format(',%s', [ALayoutTemplate[I].field]));
      sql.AppendLine(')');

      sql.AppendLine('VALUES(');
      for I := 0 to Pred(ALayoutTemplate.Count) do
      begin
        if ALayoutTemplate[I].fieldValue <> Null then
          valueField := QuotedStr(ALayoutTemplate[I].fieldValue)
        else
          valueField := 'Null';
        if I = 0 then
          sql.AppendLine(valueField)
        else
          sql.AppendLine(Format(',%s', [valueField]));
      end;
      sql.AppendLine(')');
      Result := sql.ToString;
    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
    FreeAndNil(sql);
  end;
end;

function TDAOLayout.GetIdentifier: string;
begin
  Result := FIdentifier;
end;

function TDAOLayout.getLayoutInformation(): IModelLayoutName;
var
  qryLayoutName: TFDQuery;
begin
  try
    qryLayoutName := TFDQuery.Create(nil);
    try
      qryLayoutName.Connection := TControlMain.getInstance().database.connection;
      qryLayoutName.SQL.Add('select ln.id');
      qryLayoutName.SQL.Add('      ,ln.name');
      qryLayoutName.SQL.Add('      ,ln.identifier');
      qryLayoutName.SQL.Add('      ,ln.separator');
      qryLayoutName.SQL.Add('      ,ln.owner');
      qryLayoutName.SQL.Add('      ,ln.table');
      qryLayoutName.SQL.Add('      ,ln.registration_date');
      qryLayoutName.SQL.Add('      ,ln.update_date');
      qryLayoutName.SQL.Add('from "FileImporter".layout_name ln');
      qryLayoutName.SQL.Add('where ln.identifier = :identifier');
      qryLayoutName.ParamByName('identifier').AsString := Identifier;
      qryLayoutName.Open();

      if qryLayoutName.Eof then
        raise Exception.Create(Format('Não foi encontrado nenhum layout com o identificador: %s', [Identifier]));

      Result := TModelLayoutName.new();
      Result.name := qryLayoutName.FieldByName('name').AsString;
      Result.identifier := qryLayoutName.FieldByName('identifier').AsString;
      Result.separator := qryLayoutName.FieldByName('separator').AsString;
      Result.owner := qryLayoutName.FieldByName('owner').AsString;
      Result.table := qryLayoutName.FieldByName('table').AsString;
      Result.registration_date := qryLayoutName.FieldByName('registration_date').AsDateTime;
      Result.update_date := qryLayoutName.FieldByName('update_date').AsDateTime;
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    FreeAndNil(qryLayoutName);
  end;
end;

function TDAOLayout.getLayoutTemplate(): TList<IModelLayoutTemplate>;
var
  qryLayout: TFDQuery;
  layout: IModelLayoutTemplate;
begin
  try
    qryLayout := TFDQuery.Create(nil);
    try
      qryLayout.Connection := TControlMain.getInstance().database.connection;
      qryLayout.SQL.Add('select ln.identifier');
      qryLayout.SQL.Add('      ,ln.separator');
      qryLayout.SQL.Add('      ,lt.field');
      qryLayout.SQL.Add('      ,lt.order');
      qryLayout.SQL.Add('      ,lt."size"');
      qryLayout.SQL.Add('from "FileImporter".layout_template lt');
      qryLayout.SQL.Add('    ,"FileImporter".layout_name ln');
      qryLayout.SQL.Add('where ln.id = lt.id_layout');
      qryLayout.SQL.Add('  and ln.identifier = :identifier');
      qryLayout.SQL.Add('order by lt."order"');
      qryLayout.ParamByName('identifier').AsString := Identifier;
      qryLayout.Open();

      if qryLayout.Eof then
        raise Exception.Create(Format('Não foi encontrado nenhum layout com o identificador: %s', [Identifier]));

      Result := TList<IModelLayoutTemplate>.Create;

      while not qryLayout.Eof do
      begin
        layout := TModelLayoutTemplate.new();
        layout.field := qryLayout.FieldByName('field').AsString;
        layout.order := qryLayout.FieldByName('order').AsInteger;
        layout.size := qryLayout.FieldByName('size').AsInteger;
        layout.fieldValue := Null;
        Result.Add(layout);
        qryLayout.Next;
      end;
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    FreeAndNil(qryLayout);
  end;
end;

function TDAOLayout.insertRow(const ALayoutInformation: IModelLayoutName; const ALayoutTemplate: TList<IModelLayoutTemplate>): IDAOLayout;
var
  qryInsert: TFDQuery;
begin
  try
    qryInsert := TFDQuery.Create(nil);
    try
      qryInsert.Connection := TControlMain.getInstance().database.connection;
      qryInsert.SQL.Text := generateSQL(ALayoutInformation, ALayoutTemplate);
      qryInsert.ExecSQL;
      qryInsert.Connection.Commit;
    except
      on E: Exception do
      begin
        qryInsert.Connection.Rollback;
        if (E.Message.contains('Parameter')) and E.Message.contains('not found') then
          raise Exception.Create(Format('Campo não cadastrado no layout. %s', [E.Message]))
        else
          raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(qryInsert);
    Result := Self;
  end;
end;

class function TDAOLayout.new(const AIdentifier: string): IDAOLayout;
begin
  Result := Self.Create;
  Result.Identifier := AIdentifier;
end;

procedure TDAOLayout.SetIdentifier(const Value: string);
begin
  FIdentifier := Value;
end;

end.

