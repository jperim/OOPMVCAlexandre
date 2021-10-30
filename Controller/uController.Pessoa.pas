unit uController.Pessoa;

interface

uses System.SysUtils, System.Classes,
  uController.Interfaces, uDAO.Interfaces, uModel.Interfaces,
  uDAO.Pessoa, uModel.Pessoa, Data.DB;

type
  TPessoaController = class(TInterfacedObject, iPessoaController)
  private
    FModel: iPessoaModel;
    FDao: iPessoaDAO;
    FDataSource: TDataSource;
  public
    constructor Create(aDataSource: TDataSource);
    destructor Destroy; override;
    class function New(aDataSource: TDataSource = nil): iPessoaController;

    function Model: iPessoaModel;
    function get: iPessoaController; overload;
    function get(pID: Integer): iPessoaController; overload;
    function Delete: Boolean;
    function Save: Boolean;
  end;

implementation

{ TPessoaController }

constructor TPessoaController.Create(aDataSource: TDataSource);
begin
  FDataSource := aDataSource;
  FModel := TPessoaModel.New;
  FDao := TPessoaDAO.New;
end;

destructor TPessoaController.Destroy;
begin
  inherited;
end;

class function TPessoaController.New(aDataSource: TDataSource): iPessoaController;
begin
  Result := Self.Create(aDataSource);
end;

function TPessoaController.get: iPessoaController;
begin
  Result := Self;
  FDao.Get(FModel.Id, FModel);
end;

function TPessoaController.get(pID: Integer): iPessoaController;
begin
  Result := Self;
  if Assigned(FDataSource) then
    FDataSource.DataSet := FDao.Get(pID);
end;

function TPessoaController.Model: iPessoaModel;
begin
  Result := FModel;
end;

function TPessoaController.Save: Boolean;
begin
  Result := FDao.Save(FModel);
end;

function TPessoaController.Delete: Boolean;
begin
  Result := FDao.Delete(FModel.Id);
end;

end.
