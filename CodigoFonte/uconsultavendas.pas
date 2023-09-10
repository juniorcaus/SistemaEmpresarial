unit uConsultaVendas;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, DBGrids, DateTimePicker;

type

  { TFConsultaVendas }

  TFConsultaVendas = class(TForm)
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    txtValorTotalListado: TLabel;
    Panel1: TPanel;
    btnBuscar: TSpeedButton;
    procedure btnBuscarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FConsultaVendas: TFConsultaVendas;

implementation

uses uDataModule1;

{$R *.lfm}

{ TFConsultaVendas }

procedure TFConsultaVendas.btnBuscarClick(Sender: TObject);  //BOTAO BUSCAR
var
   valor_total_listado: Double;
begin
   DataModule1.TVenda.Filter:='DATA >= '+QuotedStr(DateTimeToStr(DateTimePicker1.Date))+' AND DATA <= '+QuotedStr(DateTimeToStr(DateTimePicker2.Date));
   DataModule1.TVenda.Filtered := true;

   valor_total_listado := 0;
   DataModule1.TVenda.First;
   while not(DataModule1.TVenda.EOF)do
   begin
      valor_total_listado := valor_total_listado + DataModule1.TVendaVALOR_TOTAL.Value;
      DataModule1.TVenda.Next;
   end;
   txtValorTotalListado.Caption:= 'Valor Total Listado: '+FormatFloat('R$###,###,##0.00',valor_total_listado);
end;

procedure TFConsultaVendas.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
   DataModule1.TVenda.Filtered := false;
end;

procedure TFConsultaVendas.FormShow(Sender: TObject);
begin
   btnBuscar.Click;
end;

end.

