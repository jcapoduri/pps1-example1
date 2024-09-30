unit userlistform;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  users;

type

  { TuserListFrm }

  TuserListFrm = class(TForm)
    exportButton: TButton;
    closeButton: TButton;
    saveDialog: TSaveDialog;
    usersGrid: TStringGrid;
    procedure closeButtonClick(Sender: TObject);
    procedure exportButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  userListFrm: TuserListFrm;

implementation

{$R *.lfm}

{ TuserListFrm }

procedure TuserListFrm.FormShow(Sender: TObject);
var
  totalUsers : integer;
  idx        : integer;
  user       : TUser;
begin
  totalUsers := users.getTotalUsers();
  idx        := 0;
  { setup de la grilla de strings}
  usersGrid.ColCount  := 6;
  usersGrid.RowCount  := totalUsers + 1;
   with usersGrid do
          begin
            Cells[1,0] := 'email';
            Cells[2,0] := 'password';
            Cells[3,0] := 'nombre';
            Cells[4,0] := 'apellido';
            Cells[5,0] := 'activo';
          end;
  while idx < totalUsers do
    begin
      user := users.getUserByPos(idx);
      with usersGrid do
          begin
            Cells[1,idx + 1] := user.email;
            Cells[2,idx + 1] := user.password;
            Cells[3,idx + 1] := user.name;
            Cells[4,idx + 1] := user.lastname;
            if user.active then
                Cells[5,idx + 1] := 'Activo'
            else
                Cells[5, idx + 1] := 'Inactivo';
            idx := idx + 1;
          end;
    end;
  usersGrid.AutoSizeColumns;
end;

procedure TuserListFrm.closeButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TuserListFrm.exportButtonClick(Sender: TObject);
var
  saveOk     : boolean;
  exportFile : TextFile;
  i,j        : Integer;
begin
   saveOk := saveDialog.Execute;
   if saveOk then
       begin
          AssignFile(exportFile, saveDialog.FileName);
          rewrite(exportFile);
          for i := 0 to usersGrid.RowCount - 1 do
              begin
                for j := 1 to usersGrid.ColCount - 1 do
                    begin
                      write(exportFile, usersGrid.Cells[j, i]);
                      if j <  (usersGrid.ColCount - 1) then
                          write(exportFile, ',');
                    end;
                writeln(exportFile)
              end;
          CloseFile(exportFile);
           MessageDlg('Listado exportado exitosamente',mtCustom, [mbOk], 0);
       end;
end;

end.

