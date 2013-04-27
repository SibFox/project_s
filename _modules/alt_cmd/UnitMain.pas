unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TFormMain = class(TForm)
    PanelCmd: TPanel;
    ImgCmd: TImage;
    Panel1: TPanel;
    Timer_FormMove: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Timer_FormMoveTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;
  //+ View params
    delta_pixw : integer = 8;
    color_bg : array[0..0] of TColor = (ClBlack);
    windowposdef_x : integer = 10;
    windowposdef_y : integer = 10;
  //-
  //+ Moving form
    windowpos_mdx : integer;
    windowpos_mdy : integer;
  //-


implementation

{$R *.dfm}

//+ Moving form
  procedure MoveForm_Start;
  begin
    windowpos_mdx := FormMain.Left - Mouse.CursorPos.X;
    windowpos_mdy := FormMain.Top - Mouse.CursorPos.Y;
    FormMain.Timer_FormMove.Enabled := true;
  end;

  procedure MoveForm_Do;
  begin
    FormMain.Left := Mouse.CursorPos.X + windowpos_mdx;
    FormMain.Top := Mouse.CursorPos.Y + windowpos_mdy;
  end;

  procedure MoveForm_Stop;
  begin
    FormMain.Timer_FormMove.Enabled := false;
  end;
//-

procedure PrepareForm_1;
begin
  FormMain.Left := windowposdef_x;
  FormMain.Top := windowposdef_y;
  FormMain.ImgCmd.Left := delta_pixw;
  FormMain.ImgCmd.Top := delta_pixw;
  FormMain.ImgCmd.Width := FormMain.PanelCmd.Width - delta_pixw * 2;
  FormMain.ImgCmd.Height := FormMain.PanelCmd.Height - delta_pixw * 2;
  //+ Color set
    FormMain.ImgCmd.Canvas.Brush.Color := color_bg[0];
    FormMain.ImgCmd.Canvas.Pen.Color := color_bg[0];
    FormMain.ImgCmd.Canvas.Rectangle(0, 0, FormMain.ImgCmd.Width, FormMain.ImgCmd.Height);
  //-
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  PrepareForm_1;
end;

procedure TFormMain.Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MoveForm_Start;
end;

procedure TFormMain.Panel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MoveForm_Stop;
end;

procedure TFormMain.Timer_FormMoveTimer(Sender: TObject);
begin
  MoveForm_Do;
end;

end.
