SHELL = bash
KEY = PASSWORD

all: encrypted.h load.cpp
	g++ load.cpp -o binary

encrypted.h: encrypted
	@echo -n "char binary[] = \"echo " > encrypted.h
	cat encrypted >> encrypted.h
	echo " | openssl enc -d -aes-256-cbc -md sha1 -k $(KEY) -base64 -A > decrypted && chmod +x decrypted\";" >> encrypted.h

encrypted: hello
	openssl enc -aes-256-cbc -in hello -md sha1 -k $(KEY) -base64 -A > encrypted

hello:
	cc hello.c -o hello

clean:
	rm -rf hello encrypted encrypted.h binary
