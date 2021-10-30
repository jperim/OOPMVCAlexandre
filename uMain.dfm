object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 462
  ClientWidth = 581
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 4
    Top = 8
    Width = 75
    Height = 25
    Action = actInsert
    TabOrder = 0
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 38
    Width = 581
    Height = 424
    ActivePage = TabLista
    Align = alBottom
    TabOrder = 1
    TabPosition = tpBottom
    ExplicitTop = 39
    object TabLista: TTabSheet
      Caption = 'Lista'
      object Grid: TDBGrid
        Left = 0
        Top = 0
        Width = 573
        Height = 398
        Align = alClient
        DataSource = DS
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object TabEdicao: TTabSheet
      Caption = 'Edi'#231#227'o'
      ImageIndex = 1
      object Button6: TButton
        Left = 403
        Top = 364
        Width = 75
        Height = 25
        Action = actSave
        TabOrder = 0
      end
      object Button7: TButton
        Left = 484
        Top = 364
        Width = 75
        Height = 25
        Action = actCancel
        TabOrder = 1
      end
    end
  end
  object Button2: TButton
    Left = 85
    Top = 8
    Width = 75
    Height = 25
    Action = actEdit
    TabOrder = 2
  end
  object Button3: TButton
    Left = 166
    Top = 8
    Width = 75
    Height = 25
    Action = actView
    TabOrder = 3
  end
  object Button4: TButton
    Left = 247
    Top = 8
    Width = 75
    Height = 25
    Action = actDelete
    TabOrder = 4
  end
  object Button5: TButton
    Left = 328
    Top = 8
    Width = 75
    Height = 25
    Action = actClose
    TabOrder = 5
  end
  object edtLocate: TEdit
    Left = 420
    Top = 10
    Width = 149
    Height = 21
    TabOrder = 6
    OnExit = edtLocateExit
  end
  object ActionList1: TActionList
    Left = 252
    Top = 64
    object actInsert: TAction
      Caption = 'actInsert'
      OnExecute = actInsertExecute
    end
    object actEdit: TAction
      Caption = 'actEdit'
      OnExecute = actEditExecute
    end
    object actDelete: TAction
      Caption = 'actDelete'
      OnExecute = actDeleteExecute
    end
    object actLocate: TAction
      Caption = 'actLocate'
      OnExecute = actLocateExecute
    end
    object actView: TAction
      Caption = 'actView'
      OnExecute = actViewExecute
    end
    object actSave: TAction
      Caption = 'actSave'
      OnExecute = actSaveExecute
    end
    object actCancel: TAction
      Caption = 'actCancel'
      OnExecute = actCancelExecute
    end
    object actClose: TAction
      Caption = 'actClose'
      OnExecute = actCloseExecute
    end
  end
  object DS: TDataSource
    Left = 284
    Top = 236
  end
end
