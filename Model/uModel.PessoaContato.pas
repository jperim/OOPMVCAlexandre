unit uModel.PessoaContato;

interface

uses System.SysUtils, System.Classes,
  uModel.Interfaces;

type
  TPessoaContatoModel = class(TInterfacedObject, iPessoaContatoModel)
  private
    FId: Integer;
    FIdPessoa: Integer;
    FTipo: string;
    FContato: string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iPessoaContatoModel;

    function Id: Integer; overload;
    function Id(Value: Integer): iPessoaContatoModel; overload;
    function IdPessoa: Integer; overload;
    function IdPessoa(Value: Integer): iPessoaContatoModel; overload;
    function Tipo: string; overload;
    function Tipo(Value: string): iPessoaContatoModel; overload;
    function Contato: string; overload;
    function Contato(Value: string): iPessoaContatoModel; overload;
  end;

implementation

{ TPessoaContatoModel }

constructor TPessoaContatoModel.Create;
begin

end;

destructor TPessoaContatoModel.Destroy;
begin
  inherited;
end;

class function TPessoaContatoModel.New: iPessoaContatoModel;
begin
  Result := Self.Create;
end;

function TPessoaContatoModel.Id: Integer;
begin
  Result := FId;
end;

function TPessoaContatoModel.Id(Value: Integer): iPessoaContatoModel;
begin
  Result := Self;
  FId := Value;
end;

function TPessoaContatoModel.IdPessoa(Value: Integer): iPessoaContatoModel;
begin
  Result := Self;
  FIdPessoa := Value;
end;

function TPessoaContatoModel.IdPessoa: Integer;
begin
  Result := FIdPessoa;
end;

function TPessoaContatoModel.Tipo: string;
begin
  Result := FTipo;
end;

function TPessoaContatoModel.Tipo(Value: string): iPessoaContatoModel;
begin
  Result := Self;
  FTipo := Value;
end;

function TPessoaContatoModel.Contato(Value: string): iPessoaContatoModel;
begin
  Result := Self;
  FContato := Value;
end;

function TPessoaContatoModel.Contato: string;
begin
  Result := FContato;
end;

end.

