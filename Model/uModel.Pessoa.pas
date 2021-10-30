unit uModel.Pessoa;

interface

uses System.SysUtils, System.Classes,
  uModel.Interfaces, uModel.Endereco, uModel.PessoaContato, uModel.PessoaContatoList;

type
  TPessoaModel = class(TInterfacedObject, iPessoaModel)
  private
    FId: Integer;
    FNome: string;
    FEndereco: TEnderecoModel;
    FContatos: iPessoaContatoList;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iPessoaModel;

    function Id: Integer; overload;
    function Id(Value: Integer): iPessoaModel; overload;
    function Nome: string; overload;
    function Nome(Value: string): iPessoaModel; overload;
    function Endereco: TEnderecoModel;
    function Contatos: iPessoaContatoList;
  end;

implementation

{ TPessoaModel }

function TPessoaModel.Contatos: iPessoaContatoList;
begin
  Result := FContatos;
end;

constructor TPessoaModel.Create;
begin
  FEndereco := TEnderecoModel.Create;
  FContatos := TPessoaContatoList.New;
end;

destructor TPessoaModel.Destroy;
begin
  FreeAndNil(FEndereco);
  inherited;
end;

function TPessoaModel.Endereco: TEnderecoModel;
begin
  Result := FEndereco;
end;

class function TPessoaModel.New: iPessoaModel;
begin
  Result := Self.Create;
end;

function TPessoaModel.Id: Integer;
begin
  Result := FId;
end;

function TPessoaModel.Id(Value: Integer): iPessoaModel;
begin
  Result := Self;
  FId := Value;
end;

function TPessoaModel.Nome: string;
begin
  Result := FNome;
end;

function TPessoaModel.Nome(Value: string): iPessoaModel;
begin
  Result := Self;
  FNome := Value;
end;

end.
