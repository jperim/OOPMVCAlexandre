unit uController.Interfaces;

interface

uses DB, uModel.Interfaces;

type
//  TEventoDS = procedure(pDataSet: TDataSet) of object;

  iPessoaController = interface
    ['{87667612-DA56-41B4-A273-F6CFCED60616}']
    function Model: iPessoaModel;
    function get: iPessoaController; overload;
    function get(pID: Integer): iPessoaController; overload;
    function Delete: Boolean;
    function Save: Boolean;
  end;

implementation

end.
