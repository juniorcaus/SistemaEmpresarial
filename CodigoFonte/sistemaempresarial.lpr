program SistemaEmpresarial;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, uMenu, uDataModule1, uCadastroCliente, uEdicaoCliente,
  uCadastroProduto, uEdicaoProduto, uPDV, uEdicaoItemVenda
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFMenu, FMenu);
  Application.CreateForm(TFEdicaoCliente, FEdicaoCliente);
  Application.CreateForm(TFCadastroProduto, FCadastroProduto);
  Application.CreateForm(TFEdicaoProduto, FEdicaoProduto);
  Application.CreateForm(TFPDV, FPDV);
  Application.CreateForm(TFEdicaoItemVenda, FEdicaoItemVenda);
  Application.Run;
end.

