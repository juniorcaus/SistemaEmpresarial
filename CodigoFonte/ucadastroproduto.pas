unit uCadastroProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  StdCtrls, Buttons, ZDataset;

type

  { TFCadastroProduto }

  TFCadastroProduto = class(TForm)
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnInserir: TSpeedButton;
    DBGrid1: TDBGrid;
    EditBusca: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    QUltimaChaveProduto: TZQuery;
    QUltimaChaveProdutoADD: TLargeintField;
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure EditBuscaChange(Sender: TObject);
  private

  public

  end;

var
  FCadastroProduto: TFCadastroProduto;

implementation

uses uDataModule1, uEdicaoProduto;

{$R *.lfm}

{ TFCadastroProduto }

procedure TFCadastroProduto.btnInserirClick(Sender: TObject); //BOTAO INSERIR PRODUTO
begin
   DataModule1.TProduto.Filtered := false;
   QUltimaChaveProduto.Close;
   QUltimaChaveProduto.Open;

   DataModule1.TProduto.Insert; //COMANDO PARA  INSERIR UM REGISTRO NOVO NA TABELA PRODUTO DO BANCO DE DADOS
   DataModule1.TProdutoCHAVE.Value:= QUltimaChaveProdutoADD.Value; //QUERY PARA CRIAR  A CHAVE"ID" AUTOMATICO PARA N SE REPETIR

   FEdicaoProduto := TFEdicaoProduto.Create(Self);
   FEdicaoProduto.ShowModal;
end;

procedure TFCadastroProduto.EditBuscaChange(Sender: TObject); //OnChange Campo de Buscar
begin
   DataModule1.TProduto.Filter := 'DESCRICAO LIKE '+QuotedStr('*'+EditBusca.Text+'*'); //comando para filtrar no buscar
   DataModule1.TProduto.Filtered := true;
end;

procedure TFCadastroProduto.btnEditarClick(Sender: TObject); //BOTAO EDITAR PRODUTO
begin
   DataModule1.TProduto.Filtered := false;
   DataModule1.TProduto.Edit; //COMANDO PARA  EDITAR UM REGISTRO DA TABELA DO BANCO DE DADOS
   FEdicaoProduto := TFEdicaoProduto.Create(Self);
   FEdicaoProduto.ShowModal;
end;

procedure TFCadastroProduto.btnExcluirClick(Sender: TObject); //BOTAO EXCLUIR PRODUTO
begin
   DataModule1.TProduto.Delete; //COMANDO PARA  APAGAR UM REGISTRO DA TABELA DE PRODUTOS DO BANCO DE DADOS
   DataModule1.TProduto.ApplyUpdates;
end;

end.

