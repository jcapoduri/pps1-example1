unit userform;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ButtonPanel,
  users in '..\modules\users.pas';

type

  { TuserFrm }

  TuserFrm = class(TForm)
    ButtonPanel1: TButtonPanel;
    lastnameInput: TLabeledEdit;
    statusComboBox: TComboBox;
    emailInput: TLabeledEdit;
    Label1: TLabel;
    passwordInput: TLabeledEdit;
    password2Input: TLabeledEdit;
    nameInput: TLabeledEdit;
    procedure ButtonPanel1Enter(Sender: TObject);
  private

  public

  end;

  procedure showAsNew();
  procedure showAsEdit();

var
  userFrm  : TuserFrm;
  isAdding : boolean;
  idx      : integer;

implementation

{$R *.lfm}

procedure showAsNew();
begin
  isAdding := true;
  userFrm.ShowModal;
end;

procedure showAsEdit();
const
  sampleEmail = 'ejemplo@ejemplo.com';
var
  email    : string;
  pos      : integer;
  user     : TUser;
begin
  isAdding := false;
  pos      := -1;
  repeat
    begin
      email := InputBox('Ingrese email a modificar',
        'Please type in some information', sampleEmail);
      pos := users.search(email);
    end;
  until (pos > 0) or (email = sampleEmail);
  if pos > 0 then
     begin
       user := users.getUserByPos(pos);
       userFrm.ShowModal;
     end
end;

{ TuserFrm }

procedure TuserFrm.ButtonPanel1Enter(Sender: TObject);
var
   errorText : string;
   user      : TUser;
begin
   errorText := '';
   if emailInput.Text = '' then
      errorText := 'el email esta vacio';
   if passwordInput.Text = '' then
      errorText := errorText + '\n' + 'la contraseña es vacia';
   if passwordInput.Text <> password2Input.Text then
      errorText := errorText + '\n' + 'las contraseñas no coinciden';
   if errorText = '' then
      begin
          user.email    := emailInput.Text;
          user.name     := nameInput.Text;
          user.lastname := lastnameInput.Text;
          user.password := passwordInput.Text;
          if statusComboBox.Text = 'Activo' then
             user.active := true
          else
             user.active := false;
          users.addUser(user);
      end
   else
      MessageDlg(errorText, mtCustom, [mbOk], 0);
end;

end.

