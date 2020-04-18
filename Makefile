SHELL = bash

all: encrypted.h load.cpp
	g++ load.cpp -o binary

encrypted.h: encrypted
	@echo -n "char binary[] = \"echo " > encrypted.h
	cat encrypted >> encrypted.h
	echo " | base64 --decode > decrypted && chmod +x decrypted\";" >> encrypted.h

encrypted: hello
	base64 hello > encrypted
	truncate -s -1 encrypted

hello:
	cc hello.c -o hello

clean:
	rm -rf hello encrypted encrypted.h
