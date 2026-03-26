#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

int
main (int argc, char *argv[])
{
  int i;
  char *nargv[argc - 1];

  if (argc < 3)
    {
      fprintf (2, "Usage: trace [syscall_mask] [command]\n");
      exit (1);
    }

  trace (atoi (argv[1]));
  if (fork () == 0)
    { // if this is a child process
      for (i = 2; i < argc; i++)
        {
          nargv[i - 2] = argv[i];
        }
      nargv[argc - 2] = 0;
      exec (nargv[0], nargv);
      exit (1);
    } // this is a parent process
  else
    {
      wait (0);
    }
  exit (0);
}
