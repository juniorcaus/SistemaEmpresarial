unit uEdicaoProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, DBCtrls,
  StdCtrls;

type

  { TFEdicaoProduto }

  TFEdicaoProduto = class(TForm)
    btnCancelar: TSpeedButton;
    btnSalvar: TSpeedButton;
    DBComboBox1: TDBComboBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private

  public

  end;

var
  FEdicaoProduto: TFEdicaoProduto;

implementation

uses uDataModule1;

{$R *.lfm}

{ TFEdicaoProduto }

procedure TFEdicaoProduto.btnSalvarClick(Sender: TObject);  //BOTAO SALVAR
begin

  DataModule1.TProduto.Post; //COMANDO PARA POSTAR NA TABELA DO BANCO DE DADOS
  DataModule1.TProduto.ApplyUpdates; //COMANDO PARA SALVAR NA TABELA
  btnCancelar.Enabled := False ;
  Close;
end;

procedure TFEdicaoProduto.btnCancelarClick(Sender: TObject);   //BOTAO CANCELAR
begin
  DataModule1.TProduto.Cancel;
  btnCancelar.Enabled := false;
  Close;
end;

end.

