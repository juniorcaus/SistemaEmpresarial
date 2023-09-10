unit uPDV;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  Buttons, DBGrids, StdCtrls, DBCtrls, ZDataset;

type

  { TFPDV }

  TFPDV = class(TForm)
    btnEditarItem: TSpeedButton;
    btnExcluirItem: TSpeedButton;
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
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    btnInserirItem: TSpeedButton;
    Panel4: TPanel;
    Panel5: TPanel;
    btnGerarParcelas: TSpeedButton;
    btnConcluir: TSpeedButton;
    btnCancelar: TSpeedButton;
    QSomaItensSUM: TFloatField;
    QUltimaChaveContaAReceberADD: TLargeintField;
    QUltimaChaveItemVendaADD: TLargeintField;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    QUltimaChaveItemVenda: TZQuery;
    QUltimaChaveContaAReceber: TZQuery;
    QSomaItens: TZQuery;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConcluirClick(Sender: TObject);
    procedure btnEditarItemClick(Sender: TObject);
    procedure btnExcluirItemClick(Sender: TObject);
    procedure btnGerarParcelasClick(Sender: TObject);
    procedure btnInserirItemClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FPDV: TFPDV;
  inserindo_novo_item: Boolean;

implementation

uses uDataModule1, uEdicaoItemVenda;

{$R *.lfm}

{ TFPDV }

procedure TFPDV.btnInserirItemClick(Sender: TObject);  //BOTAO INSERIR ITEM
begin
   inserindo_novo_item := true;
   QUltimaChaveItemVenda.Close;
   QUltimaChaveItemVenda.Open;
   DataModule1.TItemVenda.Insert;
   DataModule1.TItemVendaCHAVE.Value := QUltimaChaveItemVendaADD.Value;
   DataModule1.TItemVendaCHAVE_VENDA.Value := DataModule1.TVendaCHAVE.Value;
   FEdicaoItemVenda := TFEdicaoItemVenda.Create(Self);
   FEdicaoItemVenda.ShowModal;

   QSomaItens.Close;
   QSomaItens.ParamByName('chavevenda').Value := DataModule1.TVendaCHAVE.Value;
   QSomaItens.Open;
   DataModule1.TVendaVALOR_TOTAL.Value := QSomaItensSUM.Value;
end;

procedure TFPDV.FormClose(Sender: TObject; var CloseAction: TCloseAction); //EVEBTO OnClose do FPDV
begin
   if(btnCancelar.Enabled = true)then
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

   QSomaItens.Close;
   QSomaItens.ParamByName('chavevenda').Value := DataModule1.TVendaCHAVE.Value;
   QSomaItens.Open;
   DataModule1.TVendaVALOR_TOTAL.Value := QSomaItensSUM.Value;
end;

procedure TFPDV.btnCancelarClick(Sender: TObject); //BOTAO CANCELAR
begin
   btnCancelar.Enabled := false;
   DataModule1.TVenda.Cancel;
   Close;
end;

procedure TFPDV.btnConcluirClick(Sender: TObject);  //BOTAO CONCLUIR
begin
   btnCancelar.Enabled := false;

   //Baixar Estoque
   DataModule1.TItemVenda.First;
   while not(DataModule1.TItemVenda.EOF)do
   begin
      if(DataModule1.TProduto.Locate('CHAVE',DataModule1.TItemVendaCHAVE_PRODUTO.Value,[]))then
      begin
         DataModule1.TProduto.Locate('CHAVE',DataModule1.TItemVendaCHAVE_PRODUTO.Value,[]);
         DataModule1.TProduto.Edit;
         DataModule1.TProdutoESTOQUE.Value := DataModule1.TProdutoESTOQUE.Value - DataModule1.TItemVendaQUANTIDADE.Value;
         DataModule1.TProduto.Post;
         DataModule1.TProduto.ApplyUpdates;
      end;
      DataModule1.TItemVenda.Next;
   end;

   DataModule1.TVenda.Post;
   DataModule1.TVenda.ApplyUpdates;
   Close;
end;

procedure TFPDV.btnExcluirItemClick(Sender: TObject); //BOTAO EXCLUIR ITEM
begin
   DataModule1.TItemVenda.Delete;
   DataModule1.TItemVenda.ApplyUpdates;

   QSomaItens.Close;
   QSomaItens.ParamByName('chavevenda').Value := DataModule1.TVendaCHAVE.Value;
   QSomaItens.Open;
   DataModule1.TVendaVALOR_TOTAL.Value := QSomaItensSUM.Value;
end;

procedure TFPDV.btnGerarParcelasClick(Sender: TObject); //BOTAO GERAR PARCELAS
var //gerar parcelas para uma venda e registrá-las na tabela
   valor_parcela: Double;
   parcelas_lancadas: Integer;
   data_vencimento: String;
   mes, ano: Integer;
begin
   DataModule1.TContaAReceber.First;
   while not(DataModule1.TContaAReceber.EOF)do
   begin
      DataModule1.TContaAReceber.Delete;
      DataModule1.TContaAReceber.ApplyUpdates;
   end;

   if(DataModule1.TVendaQUANTIDADE_PARCELAS.Value > 0)then
   begin
      valor_parcela := (DataModule1.TVendaVALOR_TOTAL.Value - DataModule1.TVendaVALOR_PAGO_ENTRADA.Value) / DataModule1.TVendaQUANTIDADE_PARCELAS.Value;
   end;

   if(DataModule1.TVendaVALOR_PAGO_ENTRADA.Value > 0)then
   begin
      QUltimaChaveContaAReceber.Close;
      QUltimaChaveContaAReceber.Open;
      DataModule1.TContaAReceber.Insert;
      DataModule1.TContaAReceberCHAVE.Value := QUltimaChaveContaAReceberADD.Value;
      DataModule1.TContaAReceberCHAVE_CLIENTE.Value := DataModule1.TVendaCHAVE_CLIENTE.Value;
      DataModule1.TContaAReceberCHAVE_VENDA.Value := DataModule1.TVendaCHAVE.Value;
      DataModule1.TContaAReceberDATA_PAGAMEMTO.Value := DataModule1.TVendaDATA.Value;
      DataModule1.TContaAReceberDATA_VENCIMENTO.Value := DataModule1.TVendaDATA.Value;
      DataModule1.TContaAReceberSTATUS.Value := 'PAGO';
      DataModule1.TContaAReceberVALOR.Value := DataModule1.TVendaVALOR_PAGO_ENTRADA.Value;
      DataModule1.TContaAReceber.Post;
      DataModule1.TContaAReceber.ApplyUpdates;
   end;

   mes := StrToInt(FormatDateTime('MM',DataModule1.TVendaDATA.Value));
   ano := StrToInt(FormatDateTime('YYYY',DataModule1.TVendaDATA.Value));
   parcelas_lancadas := 0;
   while(parcelas_lancadas < DataModule1.TVendaQUANTIDADE_PARCELAS.Value)do
   begin
      if(mes = 12)then
      begin
         mes := 1;
         ano := ano + 1;
      end else
      begin
         mes := mes + 1;
      end;
      data_vencimento:= DataModule1.TVendaDIA_DO_MES_PRA_VENCER.AsString+'/'+IntToStr(mes)+'/'+IntToStr(ano);

      QUltimaChaveContaAReceber.Close;
      QUltimaChaveContaAReceber.Open;
      DataModule1.TContaAReceber.Insert;
      DataModule1.TContaAReceberCHAVE.Value := QUltimaChaveContaAReceberADD.Value;
      DataModule1.TContaAReceberCHAVE_CLIENTE.Value := DataModule1.TVendaCHAVE_CLIENTE.Value;
      DataModule1.TContaAReceberCHAVE_VENDA.Value := DataModule1.TVendaCHAVE.Value;
      DataModule1.TContaAReceberDATA_VENCIMENTO.Value := StrToDateTime(data_vencimento);
      DataModule1.TContaAReceberSTATUS.Value := 'PENDENTE';
      DataModule1.TContaAReceberVALOR.Value := valor_parcela;
      DataModule1.TContaAReceber.Post;
      DataModule1.TContaAReceber.ApplyUpdates;

      parcelas_lancadas := parcelas_lancadas + 1;
   end;
end;

end.

