unit uModel.Endereco;

interface

uses System.SysUtils, System.Classes;

type
  TEnderecoModel = class
  private
    FLogradouro: string;
    FNumero: string;
    FBairro: string;
    FCep: string;
    FCidade: string;
    FUF: string;
  public
    constructor Create;
    destructor Destroy; override;

    function Logradouro: string; overload;
    function Logradouro(Value: string): TEnderecoModel; overload;
    function Numero: string; overload;
    function Numero(Value: string): TEnderecoModel; overload;
    function Bairro: string; overload;
    function Bairro(Value: string): TEnderecoModel; overload;
    function Cep: string; overload;
    function Cep(Value: string): TEnderecoModel; overload;
    function Cidade: string; overload;
    function Cidade(Value: string): TEnderecoModel; overload;
    function UF: string; overload;
    function UF(Value: string): TEnderecoModel; overload;
  end;

implementation

{ TEnderecoModel }

function TEnderecoModel.Bairro: string;
begin
  Result := FBairro;
end;

function TEnderecoModel.Bairro(Value: string): TEnderecoModel;
begin
  Result := Self;
  FBairro := Value;
end;

function TEnderecoModel.Cep(Value: string): TEnderecoModel;
begin
  Result := Self;
  FCep := Value;
end;

function TEnderecoModel.Cep: string;
begin
  Result := FCep;
end;

function TEnderecoModel.Cidade: string;
begin
  Result := FCidade;
end;

function TEnderecoModel.Cidade(Value: string): TEnderecoModel;
begin
  Result := Self;
  FCidade := Value;
end;

constructor TEnderecoModel.Create;
begin

end;

destructor TEnderecoModel.Destroy;
begin

  inherited;
end;

function TEnderecoModel.Logradouro(Value: string): TEnderecoModel;
begin
  Result := Self;
  FLogradouro := Value;
end;

function TEnderecoModel.Logradouro: string;
begin
  Result := FLogradouro;
end;

function TEnderecoModel.Numero: string;
begin
  Result := FNumero;
end;

function TEnderecoModel.Numero(Value: string): TEnderecoModel;
begin
  Result := Self;
  FNumero := Value;
end;

function TEnderecoModel.UF: string;
begin
  Result := FUF;
end;

function TEnderecoModel.UF(Value: string): TEnderecoModel;
begin
  Result := Self;
  FUF := Value;
end;

end.

