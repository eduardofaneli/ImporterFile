unit Model.LayoutTemplate;

interface

type
  IModelLayoutTemplate = interface
    ['{72114B1E-BDD5-4065-93CF-195651201915}']
    function Getid_layout: Integer;
    procedure Setid_layout(const Value: Integer);
    function Getfield: string;
    procedure Setfield(const Value: string);
    function Getorder: Integer;
    procedure Setorder(const Value: Integer);
    function Getsize: Integer;
    procedure Setsize(const Value: Integer);
    function Getupdate_date: TDateTime;
    procedure Setupdate_date(const Value: TDateTime);
    function GetfieldValue: Variant;
    procedure SetfieldValue(const Value: Variant);
    property id_layout: Integer read Getid_layout write Setid_layout;
    property field: string read Getfield write Setfield;
    property order: Integer read Getorder write Setorder;
    property size: Integer read Getsize write Setsize;
    property update_date: TDateTime read Getupdate_date write Setupdate_date;
    property fieldValue: Variant read GetfieldValue write SetfieldValue;
  end;

  TModelLayoutTemplate = class(TInterfacedObject, IModelLayoutTemplate)
  private
    Fid_layout: Integer;
    Ffield: string;
    Forder: Integer;
    Fsize: Integer;
    Fupdate_date: TDateTime;
    FfieldValue: Variant;
    function Getid_layout: Integer;
    procedure Setid_layout(const Value: Integer);
    function Getfield: string;
    procedure Setfield(const Value: string);
    function Getorder: Integer;
    procedure Setorder(const Value: Integer);
    function Getsize: Integer;
    procedure Setsize(const Value: Integer);
    function Getupdate_date: TDateTime;
    procedure Setupdate_date(const Value: TDateTime);
    function GetfieldValue: Variant;
    procedure SetfieldValue(const Value: Variant);
    { private declarations }
  protected
    { protected declarations }
  public
    class function new(): IModelLayoutTemplate;
    property id_layout: Integer read Getid_layout write Setid_layout;
    property field: string read Getfield write Setfield;
    property order: Integer read Getorder write Setorder;
    property size: Integer read Getsize write Setsize;
    property update_date: TDateTime read Getupdate_date write Setupdate_date;
    property fieldValue: Variant read GetfieldValue write SetfieldValue;
    { public declarations }

  end;

implementation

{ TModelLayoutTemplate }

function TModelLayoutTemplate.Getfield: string;
begin
  Result := Ffield;
end;

function TModelLayoutTemplate.GetfieldValue: Variant;
begin
  Result := FfieldValue;
end;

function TModelLayoutTemplate.Getid_layout: Integer;
begin
  Result := Fid_layout;
end;

function TModelLayoutTemplate.Getorder: Integer;
begin
  Result := Forder;
end;

function TModelLayoutTemplate.Getsize: Integer;
begin
  Result := Fsize;
end;

function TModelLayoutTemplate.Getupdate_date: TDateTime;
begin
  Result := Fupdate_date;
end;

class function TModelLayoutTemplate.new(): IModelLayoutTemplate;
begin
  Result := Self.Create;
end;

procedure TModelLayoutTemplate.Setfield(const Value: string);
begin
  FField := Value;
end;

procedure TModelLayoutTemplate.SetfieldValue(const Value: Variant);
begin
  FfieldValue := Value;
end;

procedure TModelLayoutTemplate.Setid_layout(const Value: Integer);
begin
  Fid_layout := Value;
end;

procedure TModelLayoutTemplate.Setorder(const Value: Integer);
begin
  Forder := Value;
end;

procedure TModelLayoutTemplate.Setsize(const Value: Integer);
begin
  Fsize := Value;
end;

procedure TModelLayoutTemplate.Setupdate_date(const Value: TDateTime);
begin
  Fupdate_date := Value;
end;

end.

