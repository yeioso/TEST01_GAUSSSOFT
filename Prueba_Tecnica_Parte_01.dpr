program Prueba_Tecnica_Parte_01;

uses
  Vcl.Forms,
  Form_Main in 'Forms\Form_Main.pas' {FrMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrMain, FrMain);
  Application.Run;
end.
