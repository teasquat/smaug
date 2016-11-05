@if "%DEBUG%" == "" @echo off
setlocal
cd build\moon
call moonc -t ..\lua .
cd ..\..\
call java -cp ..\lib\bcel.jar;..\lib\luaj.jar luajc -r -d build\classes\main build\lua\
endlocal
