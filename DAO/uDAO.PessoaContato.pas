unit uDAO.PessoaContato;

interface

uses System.SysUtils, System.Classes,
  FireDAC.Comp.Client, Data.DB,
  uDAO.Interfaces, uDB, uModel.Interfaces;

type
  TPessoaContatoDAO = class(TInterfacedObject, iPessoaContatoDAO)
  private
    FQry: TFDQuery;
    function IsExist(pId: Integer): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iPessoaContatoDAO;

    function Get(pIdPessoa: Integer; pList: iPessoaContatoList = nil): TDataSet;
    function Delete(pId, pIdPessoa: Integer): Boolean;
    function Save(pModel: iPessoaContatoModel): Boolean;
  end;

implementation

uses
  uModel.PessoaContato;

{ TPessoaContatoDAO }

constructor TPessoaContatoDAO.Create;
begin
  FQry := TFDQuery.Create(nil);
  FQry.Connection := TDB.getInstance.Conexao;
end;

destructor TPessoaContatoDAO.Destroy;
begin
  FQry.Close;
  FreeAndNil(FQry);
  inherited;
end;

class function TPessoaContatoDAO.New: iPessoaContatoDAO;
begin
  Result := Self.Create;
end;

function TPessoaContatoDAO.Delete(pId, pIdPessoa: Integer): Boolean;
var
  Qry: TFDQuery;
begin
  if (pIdPessoa = 0) and (pIdPessoa = 0) then begin
    Result := False;
    raise Exception.Create('Nenhum ID foi passado como parametro');
  end;
  Result := True;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := TDB.getInstance.Conexao;
    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add('delete from PESSOACONTATO');
    if pIdPessoa > 0 then begin
      Qry.SQL.Add('where ID = :ID');
      Qry.ParamByName('ID').AsInteger := pIdPessoa;
    end;
    if pId > 0 then begin
      Qry.SQL.Add('where IDPESSOA = :IDPESSOA');
      Qry.ParamByName('IDPESSOA').AsInteger := pId;
    end;
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

function TPessoaContatoDAO.Get(pIdPessoa: Integer; pList: iPessoaContatoList): TDataSet;
begin
  FQry.Close;
  FQry.SQL.Clear;
  FQry.SQL.Add('select * from PESSOACONTATO');
  FQry.SQL.Add('where IDPESSOA = :IDPESSOA');
  FQry.ParamByName('IDPESSOA').AsInteger := pIdPessoa;
  try
    FQry.Open;
    Result := FQry;

    if pList <> nil then begin
      FQry.First;
      while not FQry.Eof do begin
        pList.Add(TPessoaContatoModel.New
                  .Id(FQry.FieldByName('ID').AsInteger)
                  .IdPessoa(FQry.FieldByName('IDPESSOA').AsInteger)
                  .Tipo(FQry.FieldByName('TIPO').AsString)
                  .Contato(FQry.FieldByName('CONTATO').AsString)
                  );
        FQry.Next;
      end;
    end;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TPessoaContatoDAO.IsExist(pId: Integer): Boolean;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := TDB.getInstance.Conexao;
    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add('select 1 from PESSOACONTATO');
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

function TPessoaContatoDAO.Save(pModel: iPessoaContatoModel): Boolean;
var
  Qry: TFDQuery;
  IsInsert: Boolean;
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
      Qry.SQL.Add('insert into PESSOACONTATO (');
      Qry.SQL.Add('IDPESSOA, TIPO, CONTATO) values (');
      Qry.SQL.Add(':IDPESSOA, :TIPO, :CONTATO)');
      Qry.SQL.Add('returns ID');
    end else begin
      Qry.SQL.Add('update PESSOACONTATO set');
      Qry.SQL.Add('  IDPESSOA =:IDPESSOA, TIPO =:TIPO, CONTATO =:CONTATO');
      Qry.SQL.Add('where ID =:ID');
      Qry.ParamByName('ID').AsInteger := pModel.Id;
    end;
    Qry.ParamByName('IDPESSOA').AsInteger := pModel.IdPessoa;
    Qry.ParamByName('TIPO').AsString := pModel.Tipo;
    Qry.ParamByName('CONTATO').AsString := pModel.Contato;
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

end.

