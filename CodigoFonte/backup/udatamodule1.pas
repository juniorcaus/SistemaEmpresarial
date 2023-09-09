unit uDataModule1;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, ZConnection, ZDataset;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    DSVenda: TDataSource;
    DSItemVenda: TDataSource;
    DSContaAReceber: TDataSource;
    DSProduto: TDataSource;
    DSCliente: TDataSource;
    TClienteATIVO: TStringField;
    TClienteBAIRRO: TStringField;
    TClienteCEP: TStringField;
    TClienteCHAVE: TLongintField;
    TClienteCIDADE: TStringField;
    TClienteCOMPLEMENTO: TStringField;
    TClienteCPF_CNPJ: TStringField;
    TClienteEMAIL: TStringField;
    TClienteLOGRADOURO: TStringField;
    TClienteNOME: TStringField;
    TClienteNUMERO: TStringField;
    TClienteOBSERVACAO: TStringField;
    TClienteRG_IE: TStringField;
    TClienteSEXO: TStringField;
    TClienteTELEFONE_1: TStringField;
    TClienteTELEFONE_2: TStringField;
    TClienteTIPO_PESSOA: TStringField;
    TClienteUF: TStringField;
    TContaAReceberCHAVE: TLongintField;
    TContaAReceberCHAVE_CLIENTE: TLongintField;
    TContaAReceberCHAVE_VENDA: TLongintField;
    TContaAReceberDATA_PAGAMEMTO: TDateField;
    TContaAReceberDATA_VENCIMENTO: TDateField;
    TContaAReceberFORMA_PAGTO: TStringField;
    TContaAReceberSTATUS: TStringField;
    TContaAReceberVALOR: TFloatField;
    TItemVendaCHAVE: TLongintField;
    TItemVendaCHAVE_PRODUTO: TLongintField;
    TItemVendaCHAVE_VENDA: TLongintField;
    TItemVendaPRECO_UNITARIO: TFloatField;
    TItemVendaQUANTIDADE: TFloatField;
    TItemVendaVALOR_TOTAL: TFloatField;
    TProdutoCHAVE: TLongintField;
    TProdutoCODIGOBARRAS: TStringField;
    TProdutoDESCRICAO: TStringField;
    TProdutoESTOQUE: TFloatField;
    TProdutoOBSERVACAO: TStringField;
    TProdutoPRECO_COMPRA: TFloatField;
    TProdutoPRECO_VENDA: TFloatField;
    TProdutoUNIDADE: TStringField;
    TVendaCHAVE: TLongintField;
    TVendaCHAVE_CLIENTE: TLongintField;
    TVendaDATA: TDateField;
    TVendaDIA_DO_MES_PRA_VENCER: TLongintField;
    TVendaHORARIO: TTimeField;
    TVendaNUMERO: TLongintField;
    TVendaQUANTIDADE_PARCELAS: TLongintField;
    TVendaVALOR_PAGO_ENTRADA: TFloatField;
    TVendaVALOR_TOTAL: TFloatField;
    ZConnection1: TZConnection;
    TCliente: TZTable;
    TProduto: TZTable;
    TVenda: TZTable;
    TItemVenda: TZTable;
    TContaAReceber: TZTable;
  private

  public

  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

end.

