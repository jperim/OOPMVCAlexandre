unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDB, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, uController.Interfaces;

type
  TOperacao = (opNone, opInsert, opUpdate, opView);

  TForm1 = class(TForm)
    Button1: TButton;
    ActionList1: TActionList;
    actInsert: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actLocate: TAction;
    actView: TAction;
    actSave: TAction;
    actCancel: TAction;
    actClose: TAction;
    DS: TDataSource;
    PageControl1: TPageControl;
    TabLista: TTabSheet;
    TabEdicao: TTabSheet;
    Grid: TDBGrid;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    edtLocate: TEdit;
    Button6: TButton;
    Button7: TButton;
    procedure FormCreate(Sender: TObject);
    procedure actInsertExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actLocateExecute(Sender: TObject);
    procedure actViewExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure edtLocateExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FCtrl: iPessoaController;
    FOperacao: TOperacao;
    procedure Status;
    function doSave: Boolean;
    procedure TesteConexao;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  uController.Pessoa;

{$R *.dfm}

procedure TForm1.actCancelExecute(Sender: TObject);
begin
  FOperacao := opNone;
  PageControl1.ActivePage := TabLista;
end;

procedure TForm1.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TForm1.actDeleteExecute(Sender: TObject);
begin
//
end;

procedure TForm1.actEditExecute(Sender: TObject);
begin
  FOperacao := opUpdate;
  PageControl1.ActivePage := TabEdicao;
end;

procedure TForm1.actInsertExecute(Sender: TObject);
begin
  FOperacao := opInsert;
  PageControl1.ActivePage := TabEdicao;
end;

procedure TForm1.actLocateExecute(Sender: TObject);
begin
//  FCtrl.Model.Id(1);
  FCtrl.get(StrToIntDef(edtLocate.Text,0));
end;

function TForm1.doSave: Boolean;
begin
  Result := True;
end;

procedure TForm1.edtLocateExit(Sender: TObject);
begin
  actLocateExecute(nil);
end;

procedure TForm1.actSaveExecute(Sender: TObject);
begin
  if doSave then begin
    FOperacao := opNone;
    PageControl1.ActivePage := TabLista;
  end;
end;

procedure TForm1.actViewExecute(Sender: TObject);
begin
  FOperacao := opView;
  PageControl1.ActivePage := TabEdicao;
end;

procedure TForm1.TesteConexao;
begin
  try
    TDB.getInstance.Conexao.Connected := True;
    ShowMessage('Conectado');
    TDB.getInstance.Conexao.Connected := False;
  except on E: Exception do
    ShowMessage(E.Message);
  end;
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
  FOperacao := opNone;
  PageControl1.ActivePage := TabLista;
  FCtrl := TPessoaController.New(DS);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
//  TesteConexao;
  FCtrl.get(0);
end;

procedure TForm1.Status;
begin
  actLocate.Enabled := (FOperacao = opNone);
  actInsert.Enabled := (FOperacao = opNone);
  actEdit.Enabled   := (FOperacao = opNone) and (DS.DataSet <> nil) and (not DS.DataSet.IsEmpty);
  actView.Enabled   := (FOperacao = opNone) and (DS.DataSet <> nil) and (not DS.DataSet.IsEmpty);
  actDelete.Enabled := (FOperacao = opNone) and (DS.DataSet <> nil) and (not DS.DataSet.IsEmpty);
  actSave.Enabled   := (FOperacao in [opInsert, opUpdate]);
  actCancel.Enabled := (FOperacao in [opInsert, opUpdate, opView]);
  actClose.Enabled  := (FOperacao = opNone);
end;

end.
