@if "%DEBUG%" == "" @echo off
setlocal
cd src
call moonc -t build\lua .
cd ../
call java -cp egg\lib\bcel.jar;egg\lib\luaj.jar luajc -r -d src\build\classes src\build\lua
endlocal
