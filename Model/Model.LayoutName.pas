unit Model.LayoutName;

interface

type
  IModelLayoutName = interface
    ['{69730C7B-CAB2-4CF4-A47F-3EAAD83DC171}']
    function Getname: string;
    procedure Setname(const Value: string);
    function Getregistration_date: TDateTime;
    procedure Setregistration_date(const Value: TDateTime);
    function Getupdate_date: TDateTime;
    procedure Setupdate_date(const Value: TDateTime);
    function Getidentifier: string;
    procedure Setidentifier(const Value: string);
    function Getseparator: string;
    procedure Setseparator(const Value: string);
    function Getowner: string;
    procedure Setowner(const Value: string);
    function Gettable: string;
    procedure Settable(const Value: string);
    property name: string read Getname write Setname;
    property registration_date: TDateTime read Getregistration_date write Setregistration_date;
    property update_date: TDateTime read Getupdate_date write Setupdate_date;
    property identifier: string read Getidentifier write Setidentifier;
    property separator: string read Getseparator write Setseparator;
    property owner: string read Getowner write Setowner;
    property table: string read Gettable write Settable;
  end;

  TModelLayoutName = class(TInterfacedObject, IModelLayoutName)
  private
    Fname: string;
    Fregistration_date: TDateTime;
    Fupdate_date: TDateTime;
    Fidentifier: string;
    Fseparator : string;
    Fowner: string;
    Ftable: string;
    function Getname: string;
    procedure Setname(const Value: string);
    function Getregistration_date: TDateTime;
    procedure Setregistration_date(const Value: TDateTime);
    function Getupdate_date: TDateTime;
    procedure Setupdate_date(const Value: TDateTime);
    function Getidentifier: string;
    procedure Setidentifier(const Value: string);
    function Getseparator: string;
    procedure Setseparator(const Value: string);
    function Getowner: string;
    procedure Setowner(const Value: string);
    function Gettable: string;
    procedure Settable(const Value: string);
  { Private Declarations }
  public
    class function new(): IModelLayoutName;
    property name: string read Getname write Setname;
    property registration_date: TDateTime read Getregistration_date write Setregistration_date;
    property update_date: TDateTime read Getupdate_date write Setupdate_date;
    property identifier: string read Getidentifier write Setidentifier;
    property separator: string read Getseparator write Setseparator;
    property owner: string read Getowner write Setowner;
    property table: string read Gettable write Settable;
  { Public Declarations }
  end;

implementation

{ TModelLayoutName }

function TModelLayoutName.Getregistration_date: TDateTime;
begin
  Result := Fregistration_date;
end;

function TModelLayoutName.Getseparator: string;
begin
  Result := Fseparator;
end;

function TModelLayoutName.Gettable: string;
begin
  Result := Ftable;
end;

function TModelLayoutName.Getupdate_date: TDateTime;
begin
  Result := Fupdate_date;
end;

class function TModelLayoutName.new: IModelLayoutName;
begin
  Result := Self.Create;
end;

function TModelLayoutName.Getidentifier: string;
begin
  Result := Fidentifier;
end;

function TModelLayoutName.Getname: string;
begin
  Result := Fname;
end;

function TModelLayoutName.Getowner: string;
begin
  Result := Fowner;
end;

procedure TModelLayoutName.Setidentifier(const Value: string);
begin
  Fidentifier := Value;
end;

procedure TModelLayoutName.Setname(const Value: string);
begin
  Fname := Value;
end;

procedure TModelLayoutName.Setowner(const Value: string);
begin
  Fowner := Value;
end;

procedure TModelLayoutName.Setregistration_date(const Value: TDateTime);
begin
  Fregistration_date := Value;
end;

procedure TModelLayoutName.Setseparator(const Value: string);
begin
  Fseparator := Value;
end;

procedure TModelLayoutName.Settable(const Value: string);
begin
  Ftable := Value;
end;

procedure TModelLayoutName.Setupdate_date(const Value: TDateTime);
begin
  Fupdate_date := Value;
end;

end.

