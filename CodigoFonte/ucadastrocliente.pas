unit uCadastroCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  StdCtrls, Buttons, ZDataset;

type

  { TFCadastroCliente }

  TFCadastroCliente = class(TForm)
    DBGrid1: TDBGrid;
    EditBusca: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    btnInserir: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    QUltimaChaveCliente: TZQuery;
    QUltimaChaveClienteADD: TLargeintField;
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure EditBuscaChange(Sender: TObject);
  private

  public

  end;

var
  FCadastroCliente: TFCadastroCliente;

implementation

uses uDataModule1, uEdicaoCliente;

{$R *.lfm}

{ TFCadastroCliente }

procedure TFCadastroCliente.btnInserirClick(Sender: TObject);   //BOTAO INSERIR
begin
    DataModule1.TCliente.Filtered := false;
   QUltimaChaveCliente.Close;
   QUltimaChaveCliente.Open;
  DataModule1.TCliente.Insert;//COMANDO PARA  INSERIR UM REGISTRO NOVO NA TABELA DO BANCO DE DADOS
   DataModule1.TClienteCHAVE.VALUE := QUltimaChaveClienteADD.Value; //QUERY PARA CRIAR  A CHAVE"ID" AUTOMATICO PARA N SE REPETIR

  FEdicaoCliente := TFEdicaoCliente.Create(Self);
  FEdicaoCliente.ShowModal;

end;

procedure TFCadastroCliente.EditBuscaChange(Sender: TObject);  //EDIT BUSCA, EVENTO OnChane
begin
  DataModule1.TCliente.Filter := 'NOME LIKE'+QuotedStr('*'+EditBusca.Text+'*'); //comando para filtrar no buscar
  DataModule1.TCliente.Filtered := true;

end;

procedure TFCadastroCliente.btnEditarClick(Sender: TObject);   //BOTAO EDITAR
begin
  DataModule1.TCliente.Filtered := false;
  DataModule1.TCliente.Edit;//COMANDO PARA  EDITAR UM REGISTRO DA TABELA DO BANCO DE DADOS
  FEdicaoCliente := TFEdicaoCliente.Create(Self);
  FEdicaoCliente.ShowModal;

end;

procedure TFCadastroCliente.btnExcluirClick(Sender: TObject); //BOTAO EXCLUIR
begin
  DataModule1.TCliente.Delete; //COMANDO PARA  APAGAR UM REGISTRO DA TABELA DO BANCO DE DADOS
   DataModule1.TCliente.ApplyUpdates;

end;

end.

