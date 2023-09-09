unit uEdicaoCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls,
  DBCtrls;

type

  { TFEdicaoCliente }

  TFEdicaoCliente = class(TForm)
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    DBComboBox1: TDBComboBox;
    DBComboBox2: TDBComboBox;
    DBEdit1: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit9: TDBEdit;
    DBMemo1: TDBMemo;
    DBRadioGroup1: TDBRadioGroup;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FEdicaoCliente: TFEdicaoCliente;

implementation

uses uDataModule1, uCadastroCliente;

{$R *.lfm}

{ TFEdicaoCliente }

procedure TFEdicaoCliente.btnSalvarClick(Sender: TObject); //BOTAO SALVAR
begin
  DataModule1.TCliente.Post; //COMANDO PARA POSTAR NA TABELA DO BANCO DE DADOS
  DataModule1.TCliente.ApplyUpdates; //COMANDO PARA SALVAR NA TABELA
  btnCancelar.Enabled := False ;
  Close;

end;

procedure TFEdicaoCliente.FormClose(Sender: TObject; //EVENTO FedicaoCliente OnClose
  var CloseAction: TCloseAction);
begin
     if(btnCancelar.Enabled) then
     begin
      DataModule1.TCliente.Cancel;
     end;

end;

procedure TFEdicaoCliente.btnCancelarClick(Sender: TObject);  //BOTAO CANCELAR
begin
  DataModule1.TCliente.Cancel;
  btnCancelar.Enabled := false;
  Close;

end;

end.

