program OOPMVCAlexandre;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Form1},
  uDB in 'Conexao\uDB.pas',
  uModel.Interfaces in 'Model\uModel.Interfaces.pas',
  uModel.Pessoa in 'Model\uModel.Pessoa.pas',
  uModel.Endereco in 'Model\uModel.Endereco.pas',
  uModel.PessoaContato in 'Model\uModel.PessoaContato.pas',
  uDAO.Interfaces in 'DAO\uDAO.Interfaces.pas',
  uModel.PessoaContatoList in 'Model\uModel.PessoaContatoList.pas',
  uDAO.PessoaContato in 'DAO\uDAO.PessoaContato.pas',
  uDAO.Pessoa in 'DAO\uDAO.Pessoa.pas',
  uController.Interfaces in 'Controller\uController.Interfaces.pas',
  uController.Pessoa in 'Controller\uController.Pessoa.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
