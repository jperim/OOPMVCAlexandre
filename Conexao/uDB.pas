unit uDB;

interface

uses
  System.SysUtils, System.Classes, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, FireDAC.Comp.Client, FireDAC.DApt;

type
  TDB = class
  private
    class var FDBInstance: TDB;
    FConexao: TFDConnection;
    FDriverLink: TFDPhysFBDriverLink;
    FWaitCursor: TFDGUIxWaitCursor;
    constructor CreatePrivate;
    procedure DestroyPrivate;
    procedure onBeforeConnect(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;

    function Conexao: TFDConnection;
    class function getInstance: TDB;
  end;

implementation

{ TDB }

function TDB.Conexao: TFDConnection;
begin
  Result := FConexao;
end;

constructor TDB.Create;
begin
  raise Exception.Create('Deve ser usado o getInstance()');
end;

constructor TDB.CreatePrivate;
begin
  FConexao := TFDConnection.Create(nil);
  FConexao.BeforeConnect := onBeforeConnect;
  FDriverLink := TFDPhysFBDriverLink.Create(nil);
  FWaitCursor := TFDGUIxWaitCursor.Create(nil);
end;

destructor TDB.Destroy;
begin
  FConexao.Close;
  FreeAndNil(FConexao);
  FreeAndNil(FDriverLink);
  FreeAndNil(FWaitCursor);
  inherited;
end;

procedure TDB.DestroyPrivate;
begin
  if Assigned(FDBInstance) then
    FreeAndNil(FDBInstance);
end;

class function TDB.getInstance: TDB;
begin
  if not Assigned(FDBInstance) then
    FDBInstance := TDB.CreatePrivate;

  Result := FDBInstance;
end;

procedure TDB.onBeforeConnect(Sender: TObject);
const
  Servidor_BD = '127.0.0.1';
  Porta_BD = '3050';
  DataBaseName = 'D:\Users\jperi\Documents\Embarcadero\Studio\Projects\OOPMVCAlexandre\DB\BANCO.fdb';
  Usuario_BD = 'SYSDBA';
  Senha_BD = 'masterkey';
begin
  FConexao.Params.Clear;
  FConexao.Params.Add('DriverID=FB');
  FConexao.Params.Add('Server=' + Servidor_BD);
  FConexao.Params.Add('Port=' + Porta_BD);
  FConexao.Params.Add('Database=' + DataBaseName);
  FConexao.Params.Add('User_Name=' + Usuario_BD);
  FConexao.Params.Add('Password=' + Senha_BD);
  FConexao.Params.Add('Protocol=TCPIP');
  FConexao.DriverName  := 'FB';
  FConexao.LoginPrompt := False;
  FConexao.UpdateOptions.CountUpdatedRecords := False;
end;

initialization

finalization
  TDB.getInstance.DestroyPrivate;

end.
