unit uEdicaoItemVenda;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Buttons;

type

  { TFEdicaoItemVenda }

  TFEdicaoItemVenda = class(TForm)
    btnCancelar: TSpeedButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnSalvar: TSpeedButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FEdicaoItemVenda: TFEdicaoItemVenda;

implementation
uses uDataModule1;

{$R *.lfm}

{ TFEdicaoItemVenda }

procedure TFEdicaoItemVenda.btnCancelarClick(Sender: TObject); //BOTAO CANCELAR EdicaoItemVenda
begin
  btnCancelar.Enabled := false;
  DataModule1.TItemVenda.Cancel;
  Close;

end;

procedure TFEdicaoItemVenda.btnSalvarClick(Sender: TObject);  //BOTAO SALVAR EdicaoItemVenda
begin
  btnSalvar.Enabled := false;
  DataModule1.TItemVenda.Post;
  DataModule1.TItemVenda.ApplyUpdates;
  Close;

end;

procedure TFEdicaoItemVenda.FormClose(Sender: TObject; //EVENTO OnClose da tela FEdicaoItemVenda
  var CloseAction: TCloseAction);
begin
  if(btnCancelar.Enabled = true) then
  begin
    DataModule1.TItemVenda.Cancel;
  end;

end;

end.

