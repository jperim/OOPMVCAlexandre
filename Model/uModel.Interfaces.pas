unit uModel.Interfaces;

interface

uses System.Classes, uModel.Endereco;

type
  iPessoaContatoModel = interface;
  iPessoaContatoList = interface;

  iPessoaModel = interface
    ['{5CEAF308-2BD1-46B8-A649-1FE6E519CC28}']
    function Id: Integer; overload;
    function Id(Value: Integer): iPessoaModel; overload;
    function Nome: string; overload;
    function Nome(Value: string): iPessoaModel; overload;
    function Endereco: TEnderecoModel;
    function Contatos: iPessoaContatoList;
  end;

  iPessoaContatoModel = interface
    ['{90A4772F-9D3E-4F9C-87CF-04291481AD58}']
    function Id: Integer; overload;
    function Id(Value: Integer): iPessoaContatoModel; overload;
    function IdPessoa: Integer; overload;
    function IdPessoa(Value: Integer): iPessoaContatoModel; overload;
    function Tipo: string; overload;
    function Tipo(Value: string): iPessoaContatoModel; overload;
    function Contato: string; overload;
    function Contato(Value: string): iPessoaContatoModel; overload;
  end;

  iPessoaContatoList = interface
    ['{B2F5491D-17BC-42E5-A6D8-200FA63CBC31}']
    function Add(Value: iPessoaContatoModel): iPessoaContatoList;
    function Get(pIndex: Integer): iPessoaContatoModel;
    function Delete(pIndex: Integer): iPessoaContatoList;
    function Count: Integer;
    function Clear: iPessoaContatoList;
  end;

implementation

end.
