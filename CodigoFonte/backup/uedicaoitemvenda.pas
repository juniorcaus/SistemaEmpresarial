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
    procedure DBEdit1Exit(Sender: TObject);
    procedure DBEdit2Exit(Sender: TObject);
    procedure DBEdit3Exit(Sender: TObject);
    procedure DBLookupComboBox1Exit(Sender: TObject);
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

procedure TFEdicaoItemVenda.btnCancelarClick(Sender: TObject); //BOTAO CANCELAR DO EDICAO ITEM VENDA
begin
   btnCancelar.Enabled := false;
   DataModule1.TItemVenda.Cancel;
   Close;
end;

procedure TFEdicaoItemVenda.btnSalvarClick(Sender: TObject); //BOTAO SALVAR DO EDICAO ITEM VENDA
begin
   btnCancelar.Enabled := false;
   DataModule1.TItemVenda.Post;
   DataModule1.TItemVenda.ApplyUpdates;
   Close;
end;

procedure TFEdicaoItemVenda.DBEdit1Exit(Sender: TObject); // EVENTO OnExit do DBEdit
begin
   if(DataModule1.TProduto.Locate('CHAVE',DataModule1.TItemVendaCHAVE_PRODUTO.Value,[]))then  //comando Locate, permetie fazer uma busca na tabela atráves da Coluna
   begin
      DataModule1.TProduto.Locate('CHAVE',DataModule1.TItemVendaCHAVE_PRODUTO.Value,[]);
      DataModule1.TItemVendaPRECO_UNITARIO.Value := DataModule1.TProdutoPRECO_VENDA.Value;
      DataModule1.TItemVendaVALOR_TOTAL.Value := DataModule1.TItemVendaPRECO_UNITARIO.Value * DataModule1.TItemVendaQUANTIDADE.Value;
   end;
end;

procedure TFEdicaoItemVenda.DBEdit2Exit(Sender: TObject); //EVENTO OnExit do DBEdit2 Preço Unitário
begin
   DataModule1.TItemVendaVALOR_TOTAL.Value := DataModule1.TItemVendaPRECO_UNITARIO.Value * DataModule1.TItemVendaQUANTIDADE.Value;
end;

procedure TFEdicaoItemVenda.DBEdit3Exit(Sender: TObject);
begin
   DataModule1.TItemVendaVALOR_TOTAL.Value := DataModule1.TItemVendaPRECO_UNITARIO.Value * DataModule1.TItemVendaQUANTIDADE.Value;
end;

procedure TFEdicaoItemVenda.DBLookupComboBox1Exit(Sender: TObject);  // EVENTO OnExit do DBLookupCombox1Exit
begin
   if(DataModule1.TProduto.Locate('CHAVE',DataModule1.TItemVendaCHAVE_PRODUTO.Value,[]))then  //comando Locate, permetie fazer uma busca na tabela atráves da Coluna
   begin
      DataModule1.TProduto.Locate('CHAVE',DataModule1.TItemVendaCHAVE_PRODUTO.Value,[]);
      DataModule1.TItemVendaPRECO_UNITARIO.Value := DataModule1.TProdutoPRECO_VENDA.Value;
      DataModule1.TItemVendaVALOR_TOTAL.Value := DataModule1.TItemVendaPRECO_UNITARIO.Value * DataModule1.TItemVendaQUANTIDADE.Value;
   end;
end;

procedure TFEdicaoItemVenda.FormClose(Sender: TObject; //Evento do OnClose da tela FEdicaoItemVendas
  var CloseAction: TCloseAction);
begin
   if(btnCancelar.Enabled = true)then
   begin
      DataModule1.TItemVenda.Cancel;
   end;
end;

end.

