#include "types.h"
struct sysinfo{
    uint64 freemem;
    uint64 nproc;
    uint64 nopenfiles;
    char proc_names[64][16];
    char file_names[100][16];
};
