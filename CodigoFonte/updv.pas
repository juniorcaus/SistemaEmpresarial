unit uPDV;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  Buttons, DBGrids, StdCtrls, DBCtrls, ZDataset;

type

  { TFPDV }

  TFPDV = class(TForm)
    DBComboBox1: TDBComboBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    DBText1: TDBText;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    btnInserirItem: TSpeedButton;
    btnEditarItem: TSpeedButton;
    btnExcluirItem: TSpeedButton;
    Panel4: TPanel;
    BtnConcluir: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnGerarParcelas: TSpeedButton;
    QUltimaChaveContaAReceberADD: TLargeintField;
    QUltimaChaveItemVendaADD: TLargeintField;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    QUltimaChaveItemVenda: TZQuery;
    QUltimaChaveContaAReceber: TZQuery;
    procedure btnCancelarClick(Sender: TObject);
    procedure BtnConcluirClick(Sender: TObject);
    procedure btnEditarItemClick(Sender: TObject);
    procedure btnExcluirItemClick(Sender: TObject);
    procedure btnInserirItemClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FPDV: TFPDV;
  inserindo_novo_item : Boolean;

implementation
uses uDataModule1, uEdicaoItemVenda;

{$R *.lfm}

{ TFPDV }

procedure TFPDV.btnInserirItemClick(Sender: TObject);   //BOTAO INSERIR ITEM
begin
    inserindo_novo_item := true;
    QUltimaChaveItemVenda.Close;
    QUltimaChaveItemVenda.Open;
    DataModule1.TItemVenda.Insert;
    DataModule1.TItemVendaCHAVE.Value := QUltimaChaveItemVendaADD.Value;
    DataModule1.TItemVendaCHAVE_VENDA.Value := DataModule1.TVendaCHAVE.Value;

    FEdicaoItemVenda := TFEdicaoItemVenda.Create(Self);
    FEdicaoItemVenda.ShowModal;


end;

procedure TFPDV.FormClose(Sender: TObject; var CloseAction: TCloseAction); // FPDV EVENTO OnClose
begin
    if(btnCancelar.Enabled) then
     begin
      DataModule1.TVenda.Cancel;
     end;

end;

procedure TFPDV.btnEditarItemClick(Sender: TObject); //BOTAO EDITAR ITEM
begin
    inserindo_novo_item := false;
    DataModule1.TItemVenda.Edit;

    FEdicaoItemVenda := TFEdicaoItemVenda.Create(Self);
    FEdicaoItemVenda.ShowModal;

end;

procedure TFPDV.btnCancelarClick(Sender: TObject); //BOTAO CANCELAR ITEM
begin
    DataModule1.TVenda.Cancel;
    btnCancelar.Enabled := False;
    Close;

end;

procedure TFPDV.BtnConcluirClick(Sender: TObject); //BOTAO CONCLUIR
begin
  btnCancelar.Enabled := False ;
  DataModule1.TVenda.Post; //COMANDO PARA POSTAR NA TABELA DO BANCO DE DADOS
  DataModule1.TVenda.ApplyUpdates; //COMANDO PARA SALVAR NA TABELA
  Close;
end;

procedure TFPDV.btnExcluirItemClick(Sender: TObject);    //BOTAO EXCLUIR ITEM
begin
    DataModule1.TItemVenda.Delete;
    DataModule1.TItemVenda.ApplyUpdates;


end;

end.

