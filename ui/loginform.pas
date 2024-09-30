unit loginform;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ButtonPanel,
  users in '..\modules\users.pas';

type

  { TloginWidget }

  TloginWidget = class(TForm)
    ButtonPanel1: TButtonPanel;
    userInput: TLabeledEdit;
    passwordInput: TLabeledEdit;
    procedure ButtonPanel1Enter(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
  private

  public

  end;

var
  loginWidget: TloginWidget;

implementation

{$R *.lfm}

{ TloginWidget }

procedure TloginWidget.CloseButtonClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TloginWidget.ButtonPanel1Enter(Sender: TObject);
var
  pos  : integer;
  user : TUser;
begin
  pos := users.search(userInput.Text);
  if pos > -1  then
     begin
       user := users.getUserByPos(pos);
       if user.password = passwordInput.Text then
            Close
       else
         MessageDlg('password invalido',mtCustom, [mbOk], 0);
     end
  else
      MessageDlg('email invalido',mtCustom, [mbOk], 0);
end;


end.

