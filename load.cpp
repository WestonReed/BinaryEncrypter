#include <iostream>
#include <cstring>
#include <unistd.h>
#include <sys/wait.h>

#include "encrypted.h"

int run(){
	int pid, status;

	if(pid = fork())
		waitpid(pid, &status, 0);
	
	else
		execl("./decrypted", "./decrypted", NULL);

	return status;
}

int main(){
	system(binary);	
	run();
	system("rm -rf decrypted");
	return 0;
}
