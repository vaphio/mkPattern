object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Character To Bipmap'
  ClientHeight = 254
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  OnCreate = FormCreate
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 473
    Top = 81
    Height = 173
    ExplicitLeft = 416
    ExplicitTop = 144
    ExplicitHeight = 100
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 81
    Width = 473
    Height = 173
    VertScrollBar.Visible = False
    Align = alLeft
    TabOrder = 0
    ExplicitTop = 73
    ExplicitHeight = 181
    object ImageOutput: TImage
      Left = 0
      Top = 0
      Width = 800
      Height = 152
      Align = alLeft
      Proportional = True
      Stretch = True
      ExplicitHeight = 160
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 81
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 707
    object lblBmpSize: TLabel
      Left = 339
      Top = 43
      Width = 23
      Height = 19
      Caption = 'Size'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 473
      Top = 56
      Width = 35
      Height = 19
      Caption = 'Code:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 208
      Top = 43
      Width = 41
      Height = 19
      Caption = 'Pixel H'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object EditInput: TEdit
      Left = 8
      Top = 8
      Width = 354
      Height = 29
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = #12354#12356#12358#12360#12362
    end
    object cbFontList: TComboBox
      Left = 8
      Top = 44
      Width = 169
      Height = 23
      TabOrder = 1
      Text = 'cbFontList'
      OnChange = cbFontListChange
    end
    object cbSize: TComboBox
      Left = 255
      Top = 43
      Width = 42
      Height = 23
      TabOrder = 2
      Text = '16'
      Items.Strings = (
        '8'
        '16'
        '24'
        '32'
        '48'
        '64'
        '128')
    end
    object btnClear: TButton
      Left = 368
      Top = 12
      Width = 57
      Height = 25
      Caption = 'CLEAR'
      TabOrder = 3
      OnClick = btnClearClick
    end
    object btnXferS2B: TButton
      Left = 431
      Top = 13
      Width = 100
      Height = 25
      Action = XferS2B
      TabOrder = 4
    end
    object rgCodeFmt: TRadioGroup
      Left = 656
      Top = 0
      Width = 121
      Height = 75
      Caption = 'Code Format'
      ItemIndex = 0
      Items.Strings = (
        'Normal Text'
        'Hedder File')
      TabOrder = 5
    end
    object Button1: TButton
      Left = 537
      Top = 12
      Width = 100
      Height = 25
      Action = XferB2C
      TabOrder = 6
    end
  end
  object Memo1: TMemo
    Left = 476
    Top = 81
    Width = 308
    Height = 173
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Meiryo UI'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
    ExplicitTop = 73
    ExplicitWidth = 231
    ExplicitHeight = 181
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'bmp'
    Filter = 'BMP'#12501#12449#12452#12523'|*.bmp|TXT'#12501#12449#12452#12523'|*.txt|Hedder'#12501#12449#12452#12523'|*.h'
    Left = 392
    Top = 168
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'bmp'
    Filter = 'bmp'#12501#12449#12452#12523'|*.bmp|text'#12501#12449#12452#12523'|*.txt|'#12504#12483#12480#12540#12501#12449#12452#12523'|*.h'
    Left = 392
    Top = 112
  end
  object MainMenu1: TMainMenu
    Left = 32
    Top = 97
    object files: TMenuItem
      Caption = 'File(&F)'
      object Openbmpfile1: TMenuItem
        Action = openBMP
      end
      object Opencodefile1: TMenuItem
        Action = openCode
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object N2: TMenuItem
        Action = saveBMP
      end
      object Savecodefile1: TMenuItem
        Action = saveCode
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object QuitX1: TMenuItem
        Action = FileExit1
      end
    end
    object Function1: TMenuItem
      Caption = 'Function(&R)'
      object StringtoBMP1: TMenuItem
        Action = XferS2B
      end
      object bmptocode1: TMenuItem
        Action = XferB2C
      end
      object CodetoBMP1: TMenuItem
        Action = XferC2B
      end
    end
    object Settings1: TMenuItem
      Caption = 'Settings(&S)'
      object setnormaltxt1: TMenuItem
        Action = setNormalTxt
        AutoCheck = True
        Default = True
        GroupIndex = 1
      end
      object hedderfile1: TMenuItem
        Action = setHedder
        AutoCheck = True
        GroupIndex = 1
      end
    end
  end
  object ActionList1: TActionList
    Left = 32
    Top = 161
    object openBMP: TAction
      Category = 'Files'
      Caption = 'Open bmp file...'
      OnExecute = openBMPExecute
    end
    object openCode: TAction
      Category = 'Files'
      Caption = 'Open code file...'
      OnExecute = openCodeExecute
    end
    object saveBMP: TAction
      Category = 'Files'
      Caption = 'Save bmp file...'
      OnExecute = saveBMPExecute
    end
    object saveCode: TAction
      Category = 'Files'
      Caption = 'Save code file...'
      OnExecute = saveCodeExecute
    end
    object XferB2C: TAction
      Category = 'Function'
      Caption = 'BMPtoCode'
      OnExecute = XferB2CExecute
    end
    object XferC2B: TAction
      Category = 'Function'
      Caption = 'Code to BMP'
    end
    object setNormalTxt: TAction
      Category = 'Settings'
      Caption = 'set normal txt'
      OnExecute = setNormalTxtExecute
    end
    object setHedder: TAction
      Category = 'Settings'
      Caption = 'hedder file'
      OnExecute = setHedderExecute
    end
    object FileExit1: TFileExit
      Category = 'Files'
      Caption = 'Quit(&X)'
      Hint = #32066#20102'|'#12450#12503#12522#12465#12540#12471#12519#12531#12434#32066#20102#12375#12414#12377
      ImageIndex = 43
    end
    object XferS2B: TAction
      Category = 'Function'
      Caption = 'String to BMP'
      OnExecute = XferS2BExecute
    end
  end
end
