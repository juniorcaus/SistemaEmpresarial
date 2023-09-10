unit uSplash;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls;

type

  { TfrmSplash }

  TfrmSplash = class(TForm)
    imgLogo: TImage;
    lblStatus: TLabel;
    lblNomeAplicacao: TLabel;
    pnlPrincipal: TPanel;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.lfm}

{ TfrmSplash }

procedure TfrmSplash.Timer1Timer(Sender: TObject); // EVENTO OnTimer do componente Timer, a cada 50 milesegundos vai executar oque tem aqui
begin
  if ProgressBar1.Position <= 100 then  //se a barra de progresso "ProgressBar1" position for menor ou = 100, vai executar o bloco abaixo
  begin
  ProgressBar1.StepIt; // vai incrementar o valor definido do step em propriedades

  case ProgressBar1.Position  of
  10 : lblStatus.Caption := 'Carregando Depêndencias...';
  25 : lblStatus.Caption := 'Conectando ao Banco de Dados...';
  45 : lblStatus.Caption := 'Carregando as Configurações...';
  75 : lblStatus.Caption := 'Iniciando o Sistema...';
  end;
  end;
  if ProgressBar1.Position = 100 then
  Close;
end;

end.

