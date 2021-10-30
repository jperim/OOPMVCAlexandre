unit uModel.PessoaContatoList;

interface

uses System.SysUtils, System.Classes, uModel.Interfaces;

type
  TPessoaContatoList = class(TInterfacedObject, iPessoaContatoList)
  private
    FList: TList;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iPessoaContatoList;

    function Add(Value: iPessoaContatoModel): iPessoaContatoList;
    function Get(pIndex: Integer): iPessoaContatoModel;
    function Delete(pIndex: Integer): iPessoaContatoList;
    function Count: Integer;
    function Clear: iPessoaContatoList;
  end;

implementation

{ TPessoaContatoList }

function TPessoaContatoList.Add(Value: iPessoaContatoModel): iPessoaContatoList;
begin
  Result := Self;
  FList.Add(Value);
end;

function TPessoaContatoList.Clear: iPessoaContatoList;
begin
  Result := Self;
  FList.Clear;
end;

function TPessoaContatoList.Count: Integer;
begin
  Result := FList.Count;
end;

constructor TPessoaContatoList.Create;
begin
  FList := TList.Create;
end;

function TPessoaContatoList.Delete(pIndex: Integer): iPessoaContatoList;
begin
  Result := Self;
  FList.Delete(pIndex);
end;

destructor TPessoaContatoList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPessoaContatoList.Get(pIndex: Integer): iPessoaContatoModel;
begin
  Result := iPessoaContatoModel(FList[pIndex]);
end;

class function TPessoaContatoList.New: iPessoaContatoList;
begin
  Result := Self.Create;
end;

end.
