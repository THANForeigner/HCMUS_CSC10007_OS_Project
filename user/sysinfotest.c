#include "kernel/types.h"
#include "kernel/sysinfo.h" 
#include "user/user.h"

int main(int argc, char *argv[])
{
  struct sysinfo info;
  if (sysinfo(&info) < 0) {
    printf("ERROR: sysinfo that bai!\n");
    exit(1);
  }
  printf("--- Sysinfo's results ---\n");
  printf("Free memory (bytes) : %d\n", (int)info.freemem);
  printf("Used processes      : %d\n", (int)info.nproc);
  for(int i = 0; i < info.nproc; i++) {
    printf("   - Proc %d: %s\n", i + 1, info.proc_names[i]);
  }
  printf("Open files          : %d\n", (int)info.nopenfiles);
  for(int i = 0; i < info.nopenfiles; i++) {
    printf("   - File %d: %s\n", i + 1, info.file_names[i]);
  }
  printf("--------------------------------\n");

  exit(0);
}