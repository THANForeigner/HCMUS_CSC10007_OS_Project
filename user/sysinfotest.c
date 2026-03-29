#include "kernel/types.h"
#include "kernel/sysinfo.h" 
#include "user/user.h"

//trace mask sysinfotest hello 

int main(int argc, char *argv[])
{
  struct sysinfo info;
  if (sysinfo(&info) < 0) {
    printf("ERROR: sysinfo failed!\n");
    exit(1);
  }
  printf("--- Sysinfo's results ---\n");
  printf("Free memory (bytes) : %d\n", (int)info.freemem);
  printf("Used processes      : %d\n", (int)info.nproc);
  printf("Open files          : %d\n", (int)info.nopenfiles);
  printf("--------------------------------\n");

  exit(0);
}