unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  System.Actions, Vcl.ActnList, Vcl.StdActns, System.IniFiles;

type
  TForm1 = class(TForm)
    EditInput: TEdit;
    ImageOutput: TImage;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ScrollBox1: TScrollBox;
    Panel1: TPanel;
    Memo1: TMemo;
    Splitter1: TSplitter;
    cbFontList: TComboBox;
    cbSize: TComboBox;
    lblBmpSize: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    files: TMenuItem;
    Openbmpfile1: TMenuItem;
    Opencodefile1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Savecodefile1: TMenuItem;
    Function1: TMenuItem;
    bmptocode1: TMenuItem;
    ActionList1: TActionList;
    openBMP: TAction;
    openCode: TAction;
    saveBMP: TAction;
    saveCode: TAction;
    XferB2C: TAction;
    XferC2B: TAction;
    CodetoBMP1: TMenuItem;
    N3: TMenuItem;
    FileExit1: TFileExit;
    QuitX1: TMenuItem;
    XferS2B: TAction;
    StringtoBMP1: TMenuItem;
    btnClear: TButton;
    btnXferS2B: TButton;
    rgCodeFmt: TRadioGroup;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure mkCode(w,h: Integer; dlst: TStrings);
    procedure mkHedder(w,h: Integer; dlst: TStrings);
    procedure cbFontListChange(Sender: TObject);
    procedure dspSize();
    function mkTitle(fname: string): string;
    procedure openBMPExecute(Sender: TObject);
    procedure resizeBMP(bmp: TBitmap);
    procedure openCodeExecute(Sender: TObject);
    procedure XferS2BExecute(Sender: TObject);
    procedure saveBMPExecute(Sender: TObject);
    procedure saveAttr(fname: TFilename);
    procedure loadAttr(fname: TFilename);
    procedure XferB2CExecute(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure saveCodeExecute(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  Form1: TForm1;

const
  progname = 'Bitmap Pattern maker';
  version = '2.0';
  attrExt = '.ini';
  sec = 'BMP';
  keyTxt = 'TEXT';
  keyFnt = 'FONT';
  keyPix = 'HEIGHT';

implementation

{$R *.dfm}

procedure TForm1.btnClearClick(Sender: TObject);
begin
  EditInput.Text := '';
  Memo1.Lines.Clear;
  ImageOutput.Picture := nil;
end;

procedure TForm1.cbFontListChange(Sender: TObject);
var
  FontName: String;
begin
  FontName := cbFontList.Text;
  EditInput.Font.Name := FontName;
end;

procedure TForm1.dspSize;
var
  w,h: Integer;
begin
  w := ImageOutput.Picture.Bitmap.Width;
  h := ImageOutput.Picture.Bitmap.Height;
  lblBmpSize.Caption := IntToStr(w) + ' x ' + IntToStr(h);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.Caption := mkTitle('Untitled');
  Memo1.Lines.Clear;
  cbFontList.Items.Assign(Screen.Fonts);
  cbFontList.ItemIndex := cbFontList.Items.IndexOf(EditInput.Font.Name);
end;

procedure TForm1.mkCode(w,h: Integer; dlst: TStrings);
var
  i,j: Integer;
  buf, sc: string;
  cl: TColor;
begin
  for i := 0 to w-1 do begin
    buf := '';
    for j := 0 to h-1 do
      begin
        cl := ImageOutput.Canvas.Pixels[i, j];
        if cl=0 then
          sc := '0'
        else
          sc := '1';
        if j < h-1 then
          buf := buf + sc + ','
        else
          buf := buf + sc;
      end;
    dlst.Add(buf)
  end;
end;

procedure TForm1.mkHedder(w: Integer; h: Integer; dlst: TStrings);
var
  i,j: Integer;
  buf, sc: string;
  cl: TColor;
begin
  sc := '// This file is made by ' + progname + ' (Ver.' + version + ')';
  dlst.Add(sc);
  sc := '// based string from "' + EditInput.Text + '"';
  dlst.Add(sc);
  sc := '// used font is "' + cbFontList.Text + '"';
  dlst.Add(sc);
  dlst.Add('');
  sc := 'int codeHeight = ' + IntToStr(h) + ';';
  dlst.Add(sc);
  sc := 'int codeWidth = ' + IntToStr(w) + ';';
  dlst.Add(sc);
  sc := 'uint16_t ptnCode[' + IntToStr(w) + '] = {';
  dlst.Add(sc);
  for i := 0 to w-1 do begin
    buf := '  0b';
    for j := 0 to h-1 do begin
      cl := ImageOutput.Canvas.Pixels[i, j];
      if cl=0 then buf := buf + '0'
      else buf := buf + '1';
    end;
    if i<w-1 then buf := buf + ',';
    dlst.Add(buf);
  end;
  dlst.Add('};');
end;

function TForm1.mkTitle(fname: string): string;
begin
  result := progname + ' (ver ' + version + ') - ' + fname;
end;

procedure TForm1.openBMPExecute(Sender: TObject);
var
  FileName: TFileName;
  bmp: TBitmap;
begin
  bmp := TBitmap.Create;
  OpenDialog1.FilterIndex := 1;
  try
    if OpenDialog1.Execute() then begin
      FileName := OpenDialog1.FileName;
      bmp.LoadFromFile(FileName);
      resizeBMP(bmp);
      Form1.Caption := mkTitle(ExtractFileName(FileName));
      Memo1.Lines.Clear;
      loadAttr(Filename);
    end;
  finally
    bmp.Free;
  end;
end;

procedure TForm1.openCodeExecute(Sender: TObject);
var
  FileName: TFileName;
begin
  OpenDialog1.FilterIndex := 2;
  if OpenDialog1.Execute() then begin
    FileName := OpenDialog1.FileName;
    Memo1.Lines.LoadFromFile(FileName);
    Form1.Caption := mkTitle(ExtractFileName(FileName));
  end;
end;

procedure TForm1.saveAttr(fname: TFileName);
var
  ini: TMemIniFile;
  attrFName: TFilename;
begin
  attrFName := ChangeFileExt(fname, attrExt);
  ini := TMemIniFile.Create(attrFName, TEncoding.UTF8);
  ini.WriteString(sec, keyTxt, EditInput.Text);
  ini.WriteString(sec, keyFnt, cbFontList.Text);
  ini.WriteInteger(sec, keyPix, StrToInt(cbSize.Text));
  ini.UpdateFile;
  ini.Free;
end;

procedure TForm1.loadAttr(fname: TFileName);
var
  ini: TMemIniFile;
  attrFName: TFilename;
begin
  attrFName := ChangeFileExt(fname, attrExt);
  ini := TMemIniFile.Create(attrFName);
  if FileExists(attrFName) then begin
    EditInput.Text := ini.ReadString(sec, keyTxt, '');
    cbFontList.Text := ini.ReadString(sec, keyFnt, 'MSゴシック');
    cbSize.Text := IntToStr(ini.ReadInteger(sec, keyPix, 16));
    EditInput.Font.Name := cbFontList.Text;
  end;
  ini.Free;
end;

procedure TForm1.saveBMPExecute(Sender: TObject);
var
  filename: TFileName;
begin
  SaveDialog1.Title := 'Save bmp file';
  SaveDialog1.DefaultExt := 'bmp';
  SaveDialog1.Filter := 'bmpファイル|*.bmp';
  if SaveDialog1.Execute() then begin
    FileName := SaveDialog1.FileName;
    ImageOutput.Picture.Bitmap.SaveToFile(FileName);
    saveAttr(Filename);
    Form1.Caption := mkTitle(ExtractFileName(FileName));
  end;
end;

procedure TForm1.saveCodeExecute(Sender: TObject);
var
  FileName: TFileName;
begin
  SaveDialog1.Title := 'Save data file';
  SaveDialog1.FilterIndex := rgCodeFmt.ItemIndex + 3;
  if SaveDialog1.Execute() then begin
    FileName := SaveDialog1.FileName;
    Memo1.Lines.SaveToFile(FileName, TEncoding.UTF8);
    Form1.Caption := mkTitle(ExtractFileName(FileName));
  end;
end;

procedure TForm1.resizeBMP(bmp: TBitmap);
var
  scale: Integer;
begin
  scale := ImageOutput.Height div bmp.Height + 1;
  ImageOutput.Width := bmp.Width * scale;
  ImageOutput.Picture.Bitmap.Assign(bmp);
  dspSize;
end;

procedure TForm1.XferB2CExecute(Sender: TObject);
var
  h,w: Integer;
begin
  Memo1.Lines.Clear;
  h := ImageOutput.Picture.Bitmap.Height;
  w := ImageOutput.Picture.Bitmap.Width;
  case rgCodeFmt.ItemIndex of
    0: mkCode(w,h,Memo1.Lines);
    1: mkHedder(w, h, Memo1.Lines);
  end;
end;

procedure TForm1.XferS2BExecute(Sender: TObject);
var
  Bitmap: TBitmap;
  TextToDraw: string;
  TextWidth, TextHeight, scale: Integer;
  Canvas: TCanvas;
begin
  TextToDraw := EditInput.Text;
  if TextToDraw = '' then Exit;
  Bitmap := TBitmap.Create;
  try
    Canvas := Bitmap.Canvas;

    // フォントの設定（TEditのフォントを流用するなど）
    Canvas.Font.Assign(EditInput.Font);
    Canvas.Font.Color := clWhite;
    Canvas.Font.Height := StrToInt(cbSize.Text);
    // 背景を透明に設定
    Canvas.Brush.Style := bsClear;

    // 描画に必要なテキストのサイズを計算します
    // GetTextExtentPoint32関数を使うと正確な幅と高さを取得できます
    // まずは概算でサイズを決め、後で調整しても良い
    TextWidth := Canvas.TextWidth(TextToDraw);
    TextHeight := Canvas.TextHeight(TextToDraw);

    // ビットマップのサイズを設定します
    Bitmap.Width := TextWidth; // 余白を少し追加
    Bitmap.Height := TextHeight; // 余白を少し追加
    Bitmap.Monochrome := True;

    // テキストを描画します
    // TextOut(X座標, Y座標, 文字列)
    Canvas.TextOut(0, 0, TextToDraw);
    Memo1.Lines.Clear;

    // 結果を TImage に表示 (任意)
    resizeBmp(Bitmap);
  finally
    // オブジェクトを解放します
    Bitmap.Free;
  end;

end;

end.
