unit uDAO.Interfaces;

interface

uses Data.DB, uModel.Interfaces;

type
  iPessoaDAO = interface
    ['{2E4931F4-6F1F-4C15-879D-D7F6BA35CF23}']
    function Get(pId: Integer): TDataSet; overload;
    function Get(pId: Integer; pModel: iPessoaModel): iPessoaDAO; overload;
    function Delete(pId: Integer): Boolean;
    function Save(pModel: iPessoaModel): Boolean;
  end;

  iPessoaContatoDAO = interface
    ['{7DCA099D-4AA5-4588-9322-5ACB2DAD664A}']
    function Get(pIdPessoa: Integer; pList: iPessoaContatoList = nil): TDataSet;
    function Delete(pId, pIdPessoa: Integer): Boolean;
    function Save(pModel: iPessoaContatoModel): Boolean;
  end;

implementation

end.
