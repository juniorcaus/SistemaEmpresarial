unit uMenu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  Buttons;

type

  { TFMenu }

  TFMenu = class(TForm)
    btnCadastroProdutos: TSpeedButton;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    Panel1: TPanel;
    btnCadastroClientes: TSpeedButton;
    procedure btnCadastroClientesClick(Sender: TObject);
    procedure btnCadastroProdutosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
  private

  public

  end;

var
  FMenu: TFMenu;

implementation
uses uCadastroCliente,uCadastroProduto, uDataModule1;

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

procedure TFMenu.FormCreate(Sender: TObject);  // ON CREATE DO FMenu
begin
  DataModule1 := TDataModule1.Create(Self);
  DataModule1.TCliente.Open;  //Abrir a tabela cliente
  DataModule1.TProduto.Open;  //Abrir a tabela PRODUTOS

end;

end.

