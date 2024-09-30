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
    procedure CloseButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
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

procedure TloginWidget.OKButtonClick(Sender: TObject);
var
  pos          : integer;
  user         : TUser;
  messageError : string;
begin
  pos          := users.search(userInput.Text);
  messageError := '';
  if pos > -1  then
     begin
       user := users.getUserByPos(pos);
       if user.password = passwordInput.Text then
            Close
       else
         messageError := 'password invalido';
     end
  else
      messageError := 'email invalido';
  ModalResult := mrNone;
  if messageError = '' then
    ModalResult := mrOK
  else
    MessageDlg(messageError,mtWarning, [mbOk], 0);
end;


end.

