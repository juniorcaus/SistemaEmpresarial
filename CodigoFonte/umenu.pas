unit UMenu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  Buttons, ZDataset;

type

  { TFMenu }

  TFMenu = class(TForm)
    btnCadastroProdutos: TSpeedButton;
    btnContasAReceber: TSpeedButton;
    btnPDV: TSpeedButton;
    btnConsultaVendas: TSpeedButton;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    Panel1: TPanel;
    btnCadastroClientes: TSpeedButton;
    QUltimaChaveVenda: TZQuery;
    QUltimaChaveVendaADD: TLargeintField;
    procedure btnCadastroClientesClick(Sender: TObject);
    procedure btnCadastroProdutosClick(Sender: TObject);
    procedure btnConsultaVendasClick(Sender: TObject);
    procedure btnContasAReceberClick(Sender: TObject);
    procedure btnPDVClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
  private

  public

  end;

var
  FMenu: TFMenu;

implementation

uses UCadastroCliente, UCadastroProduto, UDataModule1, uPDV, uConsultaVendas, uContasAReceber;

{$R *.lfm}

{ TFMenu }

procedure TFMenu.btnCadastroClientesClick(Sender: TObject);   //BOTAO CADASTRO CLIENTES
begin
   FCadastroCliente := TFCadastroCliente.Create(Self);
   FCadastroCliente.ShowModal;
end;

procedure TFMenu.btnCadastroProdutosClick(Sender: TObject); //BOTAO CADASTRO PRODUTOS
begin
   FCadastroProduto := TFCadastroProduto.Create(Self);
   FCadastroProduto.ShowModal;
end;

procedure TFMenu.btnConsultaVendasClick(Sender: TObject); //BOTAO CONSULTA VENDAS
begin
   FConsultaVendas := TFConsultaVendas.Create(Self);
   FConsultaVendas.ShowModal;
end;

procedure TFMenu.btnContasAReceberClick(Sender: TObject); //BOTAO CONTAS A RECEBER
begin
   FContasAReceber := TFContasAReceber.Create(Self);
   FContasAReceber.ShowModal;
end;

procedure TFMenu.btnPDVClick(Sender: TObject);  ////BOTAO DE Ponto de Vendas PDV, OnClick
begin
   QUltimaChaveVenda.Close;
   QUltimaChaveVenda.Open;
   DataModule1.TVenda.Insert;
   DataModule1.TVendaCHAVE.Value := QUltimaChaveVendaADD.Value;
   DataModule1.TVendaDATA.Value := Date;
   DataModule1.TVendaHORARIO.Value := Time;
   DataModule1.TVendaNUMERO.Value := QUltimaChaveVendaADD.Value;

   DataModule1.TItemVenda.Close;
   DataModule1.TItemVenda.Open;

   DataModule1.TContaAReceber.Close;
   DataModule1.TContaAReceber.Open;

   FPDV := TFPDV.Create(Self);
   FPDV.ShowModal;
end;

procedure TFMenu.FormCreate(Sender: TObject); //OnCreate do FMenu
begin
   DataModule1 := TDataModule1.Create(Self);
   DataModule1.TCliente.Open;  //Abrir a tabela Cliente
   DataModule1.TProduto.Open; //Abrir a tabela Produtos
   DataModule1.TVenda.Open;   //Abrir a tabela Venda
   DataModule1.TItemVenda.Open; //Abrir a tabela  ItemVenda
   DataModule1.TContaAReceber.Open; //Abrir a tabela ContaAReceber
end;

procedure TFMenu.MenuItem2Click(Sender: TObject); //MENU CADASTRO DE CLIENTE
begin
   FCadastroCliente := TFCadastroCliente.Create(Self); //ABRIR FORMULARIO DE CADASTRO CLIENTE
   FCadastroCliente.ShowModal;
end;

procedure TFMenu.MenuItem3Click(Sender: TObject); //SUBMENU CADASTRO DE PRODUTO
begin
   FCadastroProduto := TFCadastroProduto.Create(Self);
   FCadastroProduto.ShowModal;
end;

end.

