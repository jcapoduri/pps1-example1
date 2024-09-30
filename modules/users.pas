unit users;


interface
{$mode ObjFPC}{$H+}

uses
  Classes, SysUtils;

type
    TUser = record
               email: string[255];
               name: string[255];
               lastname: string[255];
               password: string[255];
               active: boolean;
             end;
    TUserDB = file of TUser;

var
    db : TuserDB;

procedure setupDB       (path, filename : string);
function  search        (email: string) : integer;
function  getUserByPos  (pos : integer) : TUser;
function  addUser       (var user : TUser): boolean;
function  getTotalUsers () : integer;


implementation
    { get user from position }
  function  _get (pos : integer) : tUser;
  var
      user : tUser;
  begin
      seek(db, pos);
      read(db, user);
      _get := user;
  end;

  procedure _set(pos : integer; var user : TUser);
  begin
      seek(db, pos);
      write(db, user);
  end;

  procedure setupDB(path, filename : string);
  var
    fullpath    : string;
    dataError   : boolean;
    defaultUser : TUser;
  begin
      fullpath := path + filename;
      {$I-}
      //check if data file exists
      AssignFile(db, fullpath + '.dat');
      reset(db);
      dataError := IOResult <> 0;
      if dataError then
         begin
           rewrite(db);;
           defaultUser.email    := 'jcapoduri@gmail.com';
           defaultUser.name     := 'Jorge';
           defaultUser.lastname := 'Capoduri';
           defaultUser.active   := true;
           defaultUser.password := 'terere123';
           _set(0, defaultUser)
         end;

      {$I+}
      close(db);
  end;

  { return the position on the file or -1 }
  function search(email: string) : integer;
  var
      found  : boolean;
      idx    : integer;
      length : integer;
      user   : TUser;
  begin
      idx    := 0;
      reset(db);
      length := FileSize(db);
      found  := false;
      while (not found) and (idx < length) do
          begin
              user := _get(idx);
              if (user.email = email) then
                  found := true
              else
                  idx := idx + 1;
          end;
      close(db);
      if found then
          search := idx
      else
          search := -1;
  end;

  function getUserByPos(pos : integer) : TUser;
  var
      user: TUser;
  begin
      reset(db);
      user := _get(pos);
      close(db);
      getUserByPos := user;
  end;

  function  addUser(var user : TUser): boolean;
  begin
    reset(db);    
    _set(filesize(db), user);
    close(db);
    addUser := true;
  end;

  function getTotalUsers(): integer;
  var
     count : Integer;
  begin
    reset(db);
    count := FileSize(db);
    close(db);
    getTotalUsers := count;
  end;


end.
