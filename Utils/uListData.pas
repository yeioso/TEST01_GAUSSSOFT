unit uListData;

interface
Uses
  Vcl.Graphics,
  Vcl.ExtCtrls,
  System.Classes,
  System.Generics.Collections;

Type
  TTypeData = (TD_None, TD_Viewport, TD_Rectangle, TD_Elipse);

  TItemData = Class(TObject)
    Private
      FType___ : TTypeData;
      FValue01 : Integer;
      FValue02 : Integer;
      FValue03 : Integer;
      FValue04 : Integer;
    Public
      Property Type___ : TTypeData Read FType___ Write FType___;
      Property Value01 : Integer   Read FValue01 Write FValue01;
      Property Value02 : Integer   Read FValue02 Write FValue02;
      Property Value03 : Integer   Read FValue03 Write FValue03;
      Property Value04 : Integer   Read FValue04 Write FValue04;
  End;
  TItemsData = Class(TObjectList<TItemData>);

  TListData = Class(TObject)
    Private
      FItems : TItemsData;
      FError : TStringList;
    Public
      Const cElipse = 'Elipse';
      Const cViewport = 'Viewport';
      Const cRectangle = 'Rectangle';
      Function SetType(Const pData : String) : TTypeData;
    Public
      Property Items : TItemsData Read FItems Write FItems;
      Property Error : TStringList Read FError;
      procedure Restart;
      Procedure SetData(Const pLine : Integer; Const pData : String);
      Procedure Paint2Canvas(Var pImage : TImage);
      procedure AfterConstruction; override;
      procedure BeforeDestruction; override;
  End;

implementation
Uses
  System.Types,
  Winapi.Windows,
  System.SysUtils;


{ TListData }

procedure TListData.AfterConstruction;
begin
  inherited;
  FItems := TItemsData.Create;
  FError := TStringList.Create;
end;

procedure TListData.Restart;
begin
  FItems.Clear;
  FError.Clear;
end;

Function TListData.SetType(Const pData : String) : TTypeData;
Begin
  Result := TTypeData.TD_None;
  If pData.ToUpper.Contains(cElipse.ToUpper) Then
    Result := TTypeData.TD_Elipse
  Else If pData.ToUpper.Contains(cViewport.ToUpper) Then
    Result := TTypeData.TD_Viewport
  Else If pData.ToUpper.Contains(cRectangle.ToUpper) Then
    Result := TTypeData.TD_Rectangle;
End;

Procedure TListData.SetData(Const pLine : Integer; Const pData : String);
Var
  lItem : TItemData;
  lLine : TStringList;
Begin
  Try
    lLine := TStringList.Create;
    lLine.Delimiter := ';';
    lLine.DelimitedText := pData;
    If lLine.Count > 0 Then
    Begin
      If lLine[0].ToUpper.Contains(cElipse.ToUpper) Or
         lLine[0].ToUpper.Contains(cViewport.ToUpper) Or
         lLine[0].ToUpper.Contains(cRectangle.ToUpper) Then
      Begin
        lItem := TItemData.Create;
        lItem.Type___ := SetType(lLine[0]);
        lItem.Value01 := -1;
        lItem.Value02 := -1;
        lItem.Value03 := -1;
        lItem.Value04 := -1;
        If lLine.Count > 1 Then
          lItem.Value01 := StrToIntDef(lLine[1], -1);
        If lLine.Count > 2 Then
          lItem.Value02 := StrToIntDef(lLine[2], -1);
        If lLine.Count > 3 Then
          lItem.Value03 := StrToIntDef(lLine[3], -1);
        If lLine.Count > 4Then
          lItem.Value04 := StrToIntDef(lLine[4], -1);
        FItems.Add(lItem);
      End;
    End
    Else
    Begin
      FError.Add('Linea ' + pLine.ToString + ', contiene errores ');
    End;
  Finally
    FreeAndNil(lLine);
  End;
End;

Procedure TListData.Paint2Canvas(Var pImage : TImage);
Var
  lI : Integer;
Begin
  pImage.Canvas.Brush.Style := bsSolid;
  pImage.Canvas.Brush.Color := clWhite;
  pImage.Canvas.FillRect(pImage.Canvas.ClipRect);

  pImage.Canvas.Brush.Style := bsClear;
  pImage.Canvas.Pen.Style := psSolid;
  pImage.Canvas.Pen.Color := clGreen;
  For lI := 0 To FItems.Count - 1 Do
  Begin
    Case FItems[lI].FType___ Of
      TTypeData.TD_Viewport  : Begin
                                 pImage.Width := FItems[lI].Value01;
                                 pImage.Height := FItems[lI].Value02;
                               End;
      TTypeData.TD_Elipse    : Begin
                                 pImage.Canvas.Pen.Width := 1;
                                 pImage.Canvas.Pen.Color := clBlue;
                                 pImage.Canvas.Brush.Color := clBlue;
                                 pImage.Canvas.Ellipse(FItems[lI].FValue01, FItems[lI].FValue02, FItems[lI].FValue03, FItems[lI].FValue04);
                               End;
      TTypeData.TD_Rectangle : Begin
                                 pImage.Canvas.Pen.Width := 1;
                                 pImage.Canvas.Pen.Color := clWebOliveDrab;
                                 pImage.Canvas.Brush.Color := clWebOliveDrab;
                                 pImage.Canvas.Rectangle(FItems[lI].FValue01, FItems[lI].FValue02, FItems[lI].FValue03, FItems[lI].FValue04);
                               End;
    End;
  End;
End;

procedure TListData.BeforeDestruction;
begin
  Restart;
  FreeAndNil(FError);
  FreeAndNil(FItems);
  inherited;
end;

end.
