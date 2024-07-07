unit Form_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.ExtCtrls, uListData;

type
  TFrMain = class(TForm)
    PnlHead: TPanel;
    BtnLoadFile: TSpeedButton;
    sbImages: TScrollBox;
    Image1: TImage;
    procedure BtnLoadFileClick(Sender: TObject);
  private
    { Private declarations }
    FData : TListData;
    FFile : TStringList;
    Function Validate : Boolean;
  public
    { Public declarations }
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

var
  FrMain: TFrMain;

implementation
{$R *.dfm}


procedure TFrMain.AfterConstruction;
begin
  inherited;
  Self.Caption := 'Prueba Tecnica Parte 01';
  FData := TListData.Create;
  FFile := TStringList.Create;
end;

procedure TFrMain.BeforeDestruction;
begin
  FreeAndNil(FFile);
  FreeAndNil(FData);
  inherited;
end;

Function TFrMain.Validate : Boolean;
Begin
  Result := FFile.Text.ToUpper.Contains(';'                ) And
            FFile.Text.ToUpper.Contains('Viewport'.ToUpper ) And
            FFile.Text.ToUpper.Contains('Rectangle'.ToUpper) And
            FFile.Text.ToUpper.Contains('Elipse'.ToUpper   );
  If Not Result Then
    ShowMessage('La estructura del archivo no esta correcta, por favor verifique su contenido');

End;

procedure TFrMain.BtnLoadFileClick(Sender: TObject);
Var
  lI : Integer;
  lOD : TOpenDialog;
begin
  FFile.Clear;
  FData.Restart;
  lOD := TOpenDialog.Create(Nil);
  lOD.Filter := 'Data Files|*.csv';
  If lOD.Execute Then
  Begin
    BtnLoadFile.Caption := 'Cargar archivo, actual: ' + ExtractFileName(lOD.FileName);
    FFile.LoadFromFile(lOD.FileName);
    If FFile.Count > 0 Then
    Begin
      If Validate Then
      Begin
        For lI := 0 To FFile.Count - 1 Do
          FData.SetData(lI + 1, FFile[lI]);
        FData.Paint2Canvas(Image1);
      End;
    End
    Else
    Begin
      FData.Error.Add('No hay datos');
    End;
  End;
  FreeAndNil(lOD);
  If FData.Error.Count > 0 Then
    ShowMessage(FData.Error.Text);
end;

end.
