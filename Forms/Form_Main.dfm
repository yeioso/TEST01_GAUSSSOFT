object FrMain: TFrMain
  Left = 0
  Top = 0
  Caption = 'FrMain'
  ClientHeight = 451
  ClientWidth = 727
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object PnlHead: TPanel
    Left = 0
    Top = 0
    Width = 727
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 721
    object BtnLoadFile: TSpeedButton
      Left = 1
      Top = 1
      Width = 384
      Height = 39
      Cursor = crHandPoint
      Align = alLeft
      Caption = 'Cargar archivo...'
      OnClick = BtnLoadFileClick
    end
  end
  object sbImages: TScrollBox
    Left = 0
    Top = 41
    Width = 727
    Height = 410
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 721
    ExplicitHeight = 401
    object Image1: TImage
      Left = 3
      Top = 4
      Width = 200
      Height = 250
    end
  end
end
