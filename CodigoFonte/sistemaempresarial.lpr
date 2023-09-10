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
  Forms, datetimectrls, zcomponent, UMenu, uDataModule1, UCadastroCliente,
  uEdicaoCliente, uCadastroProduto, uEdicaoProduto, uPDV, uEdicaoItemVenda,
  uConsultaVendas, uContasAReceber, uRelatorioContasAReceber, uSplash
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='SistemaEmpresarial';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFMenu, FMenu);
  Application.Run;
end.

