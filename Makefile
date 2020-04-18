SHELL = bash
KEY = af642987bd720e5c8d3a3cd5c239464ce8ab92ea7fa20ab091900dea03a7ee89

all: encrypted.h load.cpp
	g++ load.cpp -o binary

encrypted.h: encrypted
	@echo -n "char binary[] = \"echo " > encrypted.h
	cat encrypted >> encrypted.h
	echo " | openssl enc -d -aes-256-cbc -md sha1 -k \`curl -s ifconfig.io | shasum -a 256 | awk '{print \$$1}'\` -base64 -A > decrypted && chmod +x decrypted\";" >> encrypted.h

encrypted: hello
	openssl enc -aes-256-cbc -in hello -md sha1 -k $(KEY) -base64 -A > encrypted

hello:
	cc hello.c -o hello

clean:
	rm -rf hello encrypted encrypted.h binary
