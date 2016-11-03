build:
	moonc -t src/build/lua . && java -cp egg/lib/bcel.jar:egg/lib/luaj.jar luajc -r -d src/build/classes src/build/lua
