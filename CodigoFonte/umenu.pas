unit uMenu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  Buttons, ZDataset;

type

  { TFMenu }

  TFMenu = class(TForm)
    btnCadastroProdutos: TSpeedButton;
    btnPDV: TSpeedButton;
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
uses uCadastroCliente,uCadastroProduto, uDataModule1, uPDV;

{$R *.lfm}

{ TFMenu }

procedure TFMenu.MenuItem2Click(Sender: TObject);  // MENU CADASTRO DE CLIENTES
begin
  FCadastroCliente := TFCadastroCliente.Create(Self); //ABRIR FORMULARIO DE CADASTRO CLIENTE
  FCadastroCliente.ShowModal;
end;

procedure TFMenu.MenuItem3Click(Sender: TObject); //SUBMENU CADSTRO PRODUTO
begin
  FCadastroProduto := TFCadastroProduto.Create(Self);
  FCadastroProduto.ShowModal;

end;

procedure TFMenu.btnCadastroClientesClick(Sender: TObject); //BOTAO CADASTRO CLIENTE
begin
   FCadastroCliente := TFCadastroCliente.Create(Self);
  FCadastroCliente.ShowModal;
end;

procedure TFMenu.btnCadastroProdutosClick(Sender: TObject); //BOTAO CADASTRO PRODUTOS, OnClick
begin
  FCadastroProduto := TFCadastroProduto.Create(Self);
  FCadastroProduto.ShowModal;

end;

procedure TFMenu.btnPDVClick(Sender: TObject); //BOTAO DE Ponto de Vendas PDV, OnClick
begin
  QUltimaChaveVenda.Close;
  QUltimaChaveVenda.Open;
  DataModule1.TVenda.Insert;
  DataModule1.TVendaCHAVE.Value := QUltimaChaveVendaADD.Value;
  DataModule1.TVendaDATA.Value := Date;
  DataModule1.TVendaHORARIO.Value := Time;
  DataModule1.TVendaNUMERO.Value := QUltimaChaveVendaADD.Value;

  FPDV := TFPDV.Create(Self);
  FPDV.ShowModal;

end;

procedure TFMenu.FormCreate(Sender: TObject);  // ON CREATE DO FMenu
begin
  DataModule1 := TDataModule1.Create(Self);
  DataModule1.TCliente.Open;  //Abrir a tabela cliente
  DataModule1.TProduto.Open;  //Abrir a tabela PRODUTOS
  DataModule1.TVenda.Open;   //Abrir a tabela VENDA
  DataModule1.TItemVenda.Open; //Abrir a tabela ItemVenda
  DataModule1.TContaAReceber.Open; //Abrir a tabela ContaAReceber

end;

end.

