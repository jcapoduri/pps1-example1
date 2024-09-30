unit mainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus,
  loginform in 'loginform.pas',
  userform  in 'userform.pas',
  userlistform,
  users     in '..\modules\users.pas';

type

  { TmainApp }

  TmainApp = class(TForm)
    mainMenu: TMainMenu;
    Archivo: TMenuItem;
    userEditMenuItem: TMenuItem;
    listUserMenuItem: TMenuItem;
    userMenuItem: TMenuItem;
    userAddMenuItem: TMenuItem;
    Salir: TMenuItem;
    procedure ArchivoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure listUserMenuItemClick(Sender: TObject);
    procedure userEditMenuItemClick(Sender: TObject);
    procedure userMenuItemClick(Sender: TObject);
    procedure userAddMenuItemClick(Sender: TObject);
    procedure SalirClick(Sender: TObject);
  private

  public

  end;

var
  mainApp: TmainApp;

implementation

{$R *.lfm}

{ TmainApp }

procedure TmainApp.ArchivoClick(Sender: TObject);
begin

end;

procedure TmainApp.FormCreate(Sender: TObject);
var
    login  : TloginWidget;
begin
    { init dbs}
    users.setupDB('data\', 'users');
    Application.CreateForm(TloginWidget, login);
    login.ShowModal;
end;

procedure TmainApp.listUserMenuItemClick(Sender: TObject);
begin
  userListFrm.ShowModal;
end;

procedure TmainApp.userEditMenuItemClick(Sender: TObject);
begin
    userform.showAsEdit();
end;

procedure TmainApp.userMenuItemClick(Sender: TObject);
begin

end;

procedure TmainApp.userAddMenuItemClick(Sender: TObject);
begin
   userform.showAsNew();
end;

procedure TmainApp.SalirClick(Sender: TObject);
begin
    Application.Terminate;
end;

end.

