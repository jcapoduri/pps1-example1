program pps1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, mainForm, loginform, users, userform, userlistform
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TmainApp, mainApp);
  Application.CreateForm(TloginWidget, loginWidget);
  Application.CreateForm(TuserFrm, userFrm);
  Application.CreateForm(TuserListFrm, userListFrm);
  Application.Run;
end.

