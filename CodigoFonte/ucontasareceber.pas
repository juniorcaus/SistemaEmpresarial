unit uContasAReceber;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  StdCtrls, Buttons, Menus, ZDataset, DateTimePicker;

type

  { TFContasAReceber }

  TFContasAReceber = class(TForm)
    btnBuscar: TSpeedButton;
    ComboBox1: TComboBox;
    DSContasAReceber: TDataSource;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    btnRelatorio: TSpeedButton;
    TContasAReceberCHAVE: TLongintField;
    TContasAReceberCHAVE_CLIENTE: TLongintField;
    TContasAReceberCHAVE_VENDA: TLongintField;
    TContasAReceberDATA_PAGAMEMTO: TDateField;
    TContasAReceberDATA_VENCIMENTO: TDateField;
    TContasAReceberFORMA_PAGTO: TStringField;
    TContasAReceberSTATUS: TStringField;
    TContasAReceberVALOR: TFloatField;
    txtValorTotalListado: TLabel;
    TContasAReceber: TZTable;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
  private

  public

  end;

var
  FContasAReceber: TFContasAReceber;

implementation

uses uDataModule1, uRelatorioContasAReceber;

{$R *.lfm}

{ TFContasAReceber }

procedure TFContasAReceber.btnBuscarClick(Sender: TObject); //BOTAO ContasAReceber
var
   valor_total: Double;
begin
   TContasAReceber.Open;
   TContasAReceber.Filter := 'DATA_VENCIMENTO >= '+QuotedStr(DateTimeToStr(DateTimePicker1.Date))+' AND DATA_VENCIMENTO <= '+QuotedStr(DateTimeToStr(DateTimePicker2.Date));
   if(ComboBox1.ItemIndex = 1)then
   begin
      TContasAReceber.Filter := TContasAReceber.Filter + ' AND STATUS = '+QuotedStr('PAGO');
   end else
   if(ComboBox1.ItemIndex = 2)then
   begin
      TContasAReceber.Filter := TContasAReceber.Filter + ' AND STATUS = '+QuotedStr('PENDENTE');
   end;
   TContasAReceber.Filtered := true;

   valor_total := 0;
   TContasAReceber.First;
   while not(TContasAReceber.EOF)do
   begin
      valor_total := valor_total + TContasAReceberVALOR.Value;
      TContasAReceber.Next;
   end;

   txtValorTotalListado.Caption := 'Valor Total Listado: '+FormatFloat('R$###,###,##0.00',valor_total);
end;

procedure TFContasAReceber.btnRelatorioClick(Sender: TObject); //BOTAO Relatorios
begin
   FRelatorioContasAReceber := TFRelatorioContasAReceber.Create(Self);
   FRelatorioContasAReceber.QRelatorio.Close;
   FRelatorioContasAReceber.QRelatorio.SQL.Clear;
   FRelatorioContasAReceber.QRelatorio.SQL.Add('SELECT * FROM CONTA_A_RECEBER');
   FRelatorioContasAReceber.QRelatorio.SQL.Add('WHERE DATA_VENCIMENTO >= :datainicio ');
   FRelatorioContasAReceber.QRelatorio.SQL.Add('AND DATA_VENCIMENTO <= :datafim ');
   FRelatorioContasAReceber.QRelatorio.ParamByName('datainicio').AsDate:= DateTimePicker1.Date;
   FRelatorioContasAReceber.QRelatorio.ParamByName('datafim').AsDate:= DateTimePicker2.Date;
   if(ComboBox1.ItemIndex = 1)then
   begin
      FRelatorioContasAReceber.QRelatorio.SQL.Add(' AND STATUS = :status ');
      FRelatorioContasAReceber.QRelatorio.ParamByName('status').AsString:= 'PAGO';
   end else
   if(ComboBox1.ItemIndex = 2)then
   begin
      FRelatorioContasAReceber.QRelatorio.SQL.Add(' AND STATUS = :status ');
      FRelatorioContasAReceber.QRelatorio.ParamByName('status').AsString:= 'PENDENTE';
   end;
   FRelatorioContasAReceber.QRelatorio.Open;
   FRelatorioContasAReceber.RLReport1.Preview;
end;

procedure TFContasAReceber.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
   TContasAReceber.Filtered := false;
end;

procedure TFContasAReceber.FormShow(Sender: TObject);
begin
   btnBuscar.Click;
end;

procedure TFContasAReceber.MenuItem1Click(Sender: TObject);
begin
   TContasAReceber.Edit;
   TContasAReceberSTATUS.Value := 'PAGO';
   TContasAReceber.Post;
   TContasAReceber.ApplyUpdates;

   DataModule1.TContaAReceber.Close;
   DataModule1.TContaAReceber.Open;
end;

procedure TFContasAReceber.MenuItem2Click(Sender: TObject);
begin
   TContasAReceber.Edit;
   TContasAReceberSTATUS.Value := 'PENDENTE';
   TContasAReceber.Post;
   TContasAReceber.ApplyUpdates;

   DataModule1.TContaAReceber.Close;
   DataModule1.TContaAReceber.Open;
end;

end.

