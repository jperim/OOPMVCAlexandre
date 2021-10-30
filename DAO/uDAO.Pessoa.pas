unit uDAO.Pessoa;

interface

uses System.SysUtils, System.Classes,
  FireDAC.Comp.Client, Data.DB,
  uDAO.Interfaces, uDB, uModel.Interfaces, uDAO.PessoaContato;

type
  TPessoaDAO = class(TInterfacedObject, iPessoaDAO)
  private
    FQry: TFDQuery;
    function IsExist(pId: Integer): Boolean;
    procedure Bind(pDataSet: TDataSet; pModel: iPessoaModel);
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iPessoaDAO;

    function Get(pId: Integer): TDataSet; overload;
    function Get(pId: Integer; pModel: iPessoaModel): iPessoaDAO; overload;
    function Delete(pId: Integer): Boolean;
    function Save(pModel: iPessoaModel): Boolean;
  end;

implementation

{ TPessoaDAO }

constructor TPessoaDAO.Create;
begin
  FQry := TFDQuery.Create(nil);
  FQry.Connection := TDB.getInstance.Conexao;
end;

destructor TPessoaDAO.Destroy;
begin
  FQry.Close;
  FreeAndNil(FQry);
  inherited;
end;

class function TPessoaDAO.New: iPessoaDAO;
begin
  Result := Self.Create;
end;

function TPessoaDAO.Delete(pId: Integer): Boolean;
var
  Qry: TFDQuery;
begin
  if (pId = 0) then begin
    Result := False;
    raise Exception.Create('Nenhum ID foi passado como parametro');
  end;
  Result := True;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := TDB.getInstance.Conexao;
    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add('delete from PESSOA');
    Qry.SQL.Add('where ID = :ID');
    Qry.ParamByName('ID').AsInteger := pId;
    try
      Qry.ExecSQL;
    except on E: Exception do
      begin
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(Qry);
  end;
end;

function TPessoaDAO.Get(pId: Integer): TDataSet;
begin
  FQry.Connection := TDB.getInstance.Conexao;
  FQry.Close;
  FQry.SQL.Clear;
  FQry.SQL.Add('select * from PESSOA');
  FQry.SQL.Add('where 1 = 1');
  if pId > 0 then begin
    FQry.SQL.Add('and ID = :ID');
    FQry.ParamByName('ID').AsInteger := pId;
  end;
  try
    FQry.Open;
    Result := FQry;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TPessoaDAO.Get(pId: Integer; pModel: iPessoaModel): iPessoaDAO;
var
  Qry: TFDQuery;
begin
  Result := Self;
  if (pId = 0) then begin
    raise Exception.Create('Nenhum ID foi passado como parametro');
  end;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := TDB.getInstance.Conexao;
    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add('select * from PESSOA');
    Qry.SQL.Add('where ID = :ID');
    Qry.ParamByName('ID').AsInteger := pId;
    try
      Qry.Open;
      Bind(Qry, pModel);
    except on E: Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    Qry.Close;
    FreeAndNil(Qry);
  end;
end;

procedure TPessoaDAO.Bind(pDataSet: TDataSet; pModel: iPessoaModel);
begin
  if not pDataSet.IsEmpty then begin
    pModel.Id(pDataSet.FieldByName('ID').AsInteger);
    pModel.Nome(pDataSet.FieldByName('NOME').AsString);
    pModel.Endereco.Logradouro(pDataSet.FieldByName('LOGRADOURO').AsString);
    pModel.Endereco.Numero(pDataSet.FieldByName('NUMERO').AsString);
    pModel.Endereco.Bairro(pDataSet.FieldByName('BAIRRO').AsString);
    pModel.Endereco.Cep(pDataSet.FieldByName('CEP').AsString);
    pModel.Endereco.Cidade(pDataSet.FieldByName('CIDADE').AsString);
    pModel.Endereco.UF(pDataSet.FieldByName('UF').AsString);

    TPessoaContatoDAO.New.Get(pModel.Id, pModel.Contatos);
  end;
end;

function TPessoaDAO.IsExist(pId: Integer): Boolean;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := TDB.getInstance.Conexao;
    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add('select 1 from PESSOA');
    Qry.SQL.Add('where ID = :ID');
    Qry.ParamByName('ID').AsInteger := pId;
    try
      Qry.Open;
      Result := not Qry.IsEmpty;
    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
    FreeAndNil(Qry);
  end;
end;

function TPessoaDAO.Save(pModel: iPessoaModel): Boolean;
var
  Qry: TFDQuery;
  IsInsert: Boolean;
  I: Integer;
  ItemContato: iPessoaContatoModel;
begin
  if (pModel = nil) then begin
    Result := False;
    raise Exception.Create('Nenhum contato foi passado como parametro');
  end;
  Result := True;

  IsInsert := Self.IsExist(pModel.Id);

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := TDB.getInstance.Conexao;
    Qry.Close;
    Qry.SQL.Clear;
    if not IsInsert then begin
      Qry.SQL.Add('insert into PESSOA (');
      Qry.SQL.Add('   NOME, LOGRADOURO, NUMERO, BAIRRO, CEP, CIDADE, UF) values (');
      Qry.SQL.Add('   :NOME, :LOGRADOURO, :NUMERO, :BAIRRO, :CEP, :CIDADE, :UF)');
      Qry.SQL.Add('returns ID');
    end else begin
      Qry.SQL.Add('update PESSOA set');
      Qry.SQL.Add('   NOME =:NOME, LOGRADOURO =:LOGRADOURO, NUMERO =:NUMERO,');
      Qry.SQL.Add('   BAIRRO =:BAIRRO, CEP =:CEP, CIDADE =:CIDADE, UF =:UF');
      Qry.SQL.Add('where ID =:ID');
      Qry.ParamByName('ID').AsInteger := pModel.Id;
    end;
    Qry.ParamByName('NOME').AsString := pModel.Nome;
    Qry.ParamByName('LOGRADOURO').AsString := pModel.Endereco.Logradouro;
    Qry.ParamByName('NUMERO').AsString := pModel.Endereco.Numero;
    Qry.ParamByName('BAIRRO').AsString := pModel.Endereco.Bairro;
    Qry.ParamByName('CEP').AsString := pModel.Endereco.Cep;
    Qry.ParamByName('CIDADE').AsString := pModel.Endereco.Cidade;
    Qry.ParamByName('UF').AsString := pModel.Endereco.UF;
    try
      if IsInsert then begin
        Qry.Open;
        pModel.Id(Qry.ParamByName('ID').AsInteger);
      end else
        Qry.ExecSQL;

      if pModel.Contatos.Count > 0 then begin
        for I := 0 to pModel.Contatos.Count-1 do begin
          ItemContato := pModel.Contatos.Get(I);
          ItemContato.IdPessoa(pModel.Id);
          TPessoaContatoDAO.New.Save(ItemContato);
        end;
      end;

    except on E: Exception do
      begin
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(Qry);
  end;
end;

end.

