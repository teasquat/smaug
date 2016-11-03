build:
	moonc -t src/build/lua .
	java -cp core\libs\bcel.jar;core\libs\luaj.jar luajc -r -d src\build\classes src\build\lua
