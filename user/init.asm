
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	92250513          	addi	a0,a0,-1758 # 930 <malloc+0xf8>
  16:	372000ef          	jal	388 <open>
  1a:	04054563          	bltz	a0,64 <main+0x64>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  1e:	4501                	li	a0,0
  20:	3a0000ef          	jal	3c0 <dup>
  dup(0);  // stderr
  24:	4501                	li	a0,0
  26:	39a000ef          	jal	3c0 <dup>

  for(;;){
    printf("init: starting sh\n");
  2a:	00001917          	auipc	s2,0x1
  2e:	90e90913          	addi	s2,s2,-1778 # 938 <malloc+0x100>
  32:	854a                	mv	a0,s2
  34:	74c000ef          	jal	780 <printf>
    pid = fork();
  38:	308000ef          	jal	340 <fork>
  3c:	84aa                	mv	s1,a0
    if(pid < 0){
  3e:	04054363          	bltz	a0,84 <main+0x84>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  42:	c931                	beqz	a0,96 <main+0x96>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  44:	4501                	li	a0,0
  46:	30a000ef          	jal	350 <wait>
      if(wpid == pid){
  4a:	fea484e3          	beq	s1,a0,32 <main+0x32>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  4e:	fe055be3          	bgez	a0,44 <main+0x44>
        printf("init: wait returned an error\n");
  52:	00001517          	auipc	a0,0x1
  56:	93650513          	addi	a0,a0,-1738 # 988 <malloc+0x150>
  5a:	726000ef          	jal	780 <printf>
        exit(1);
  5e:	4505                	li	a0,1
  60:	2e8000ef          	jal	348 <exit>
    mknod("console", CONSOLE, 0);
  64:	4601                	li	a2,0
  66:	4585                	li	a1,1
  68:	00001517          	auipc	a0,0x1
  6c:	8c850513          	addi	a0,a0,-1848 # 930 <malloc+0xf8>
  70:	320000ef          	jal	390 <mknod>
    open("console", O_RDWR);
  74:	4589                	li	a1,2
  76:	00001517          	auipc	a0,0x1
  7a:	8ba50513          	addi	a0,a0,-1862 # 930 <malloc+0xf8>
  7e:	30a000ef          	jal	388 <open>
  82:	bf71                	j	1e <main+0x1e>
      printf("init: fork failed\n");
  84:	00001517          	auipc	a0,0x1
  88:	8cc50513          	addi	a0,a0,-1844 # 950 <malloc+0x118>
  8c:	6f4000ef          	jal	780 <printf>
      exit(1);
  90:	4505                	li	a0,1
  92:	2b6000ef          	jal	348 <exit>
      exec("sh", argv);
  96:	00001597          	auipc	a1,0x1
  9a:	f6a58593          	addi	a1,a1,-150 # 1000 <argv>
  9e:	00001517          	auipc	a0,0x1
  a2:	8ca50513          	addi	a0,a0,-1846 # 968 <malloc+0x130>
  a6:	2da000ef          	jal	380 <exec>
      printf("init: exec sh failed\n");
  aa:	00001517          	auipc	a0,0x1
  ae:	8c650513          	addi	a0,a0,-1850 # 970 <malloc+0x138>
  b2:	6ce000ef          	jal	780 <printf>
      exit(1);
  b6:	4505                	li	a0,1
  b8:	290000ef          	jal	348 <exit>

00000000000000bc <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start ()
{
  bc:	1141                	addi	sp,sp,-16
  be:	e406                	sd	ra,8(sp)
  c0:	e022                	sd	s0,0(sp)
  c2:	0800                	addi	s0,sp,16
  extern int main ();
  main ();
  c4:	f3dff0ef          	jal	0 <main>
  exit (0);
  c8:	4501                	li	a0,0
  ca:	27e000ef          	jal	348 <exit>

00000000000000ce <strcpy>:
}

char *
strcpy (char *s, const char *t)
{
  ce:	1141                	addi	sp,sp,-16
  d0:	e406                	sd	ra,8(sp)
  d2:	e022                	sd	s0,0(sp)
  d4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  d6:	87aa                	mv	a5,a0
  d8:	0585                	addi	a1,a1,1
  da:	0785                	addi	a5,a5,1
  dc:	fff5c703          	lbu	a4,-1(a1)
  e0:	fee78fa3          	sb	a4,-1(a5)
  e4:	fb75                	bnez	a4,d8 <strcpy+0xa>
    ;
  return os;
}
  e6:	60a2                	ld	ra,8(sp)
  e8:	6402                	ld	s0,0(sp)
  ea:	0141                	addi	sp,sp,16
  ec:	8082                	ret

00000000000000ee <strcmp>:

int
strcmp (const char *p, const char *q)
{
  ee:	1141                	addi	sp,sp,-16
  f0:	e406                	sd	ra,8(sp)
  f2:	e022                	sd	s0,0(sp)
  f4:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  f6:	00054783          	lbu	a5,0(a0)
  fa:	cb91                	beqz	a5,10e <strcmp+0x20>
  fc:	0005c703          	lbu	a4,0(a1)
 100:	00f71763          	bne	a4,a5,10e <strcmp+0x20>
    p++, q++;
 104:	0505                	addi	a0,a0,1
 106:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 108:	00054783          	lbu	a5,0(a0)
 10c:	fbe5                	bnez	a5,fc <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 10e:	0005c503          	lbu	a0,0(a1)
}
 112:	40a7853b          	subw	a0,a5,a0
 116:	60a2                	ld	ra,8(sp)
 118:	6402                	ld	s0,0(sp)
 11a:	0141                	addi	sp,sp,16
 11c:	8082                	ret

000000000000011e <strlen>:

uint
strlen (const char *s)
{
 11e:	1141                	addi	sp,sp,-16
 120:	e406                	sd	ra,8(sp)
 122:	e022                	sd	s0,0(sp)
 124:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 126:	00054783          	lbu	a5,0(a0)
 12a:	cf91                	beqz	a5,146 <strlen+0x28>
 12c:	00150793          	addi	a5,a0,1
 130:	86be                	mv	a3,a5
 132:	0785                	addi	a5,a5,1
 134:	fff7c703          	lbu	a4,-1(a5)
 138:	ff65                	bnez	a4,130 <strlen+0x12>
 13a:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 13e:	60a2                	ld	ra,8(sp)
 140:	6402                	ld	s0,0(sp)
 142:	0141                	addi	sp,sp,16
 144:	8082                	ret
  for (n = 0; s[n]; n++)
 146:	4501                	li	a0,0
 148:	bfdd                	j	13e <strlen+0x20>

000000000000014a <memset>:

void *
memset (void *dst, int c, uint n)
{
 14a:	1141                	addi	sp,sp,-16
 14c:	e406                	sd	ra,8(sp)
 14e:	e022                	sd	s0,0(sp)
 150:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
 152:	ca19                	beqz	a2,168 <memset+0x1e>
 154:	87aa                	mv	a5,a0
 156:	1602                	slli	a2,a2,0x20
 158:	9201                	srli	a2,a2,0x20
 15a:	00a60733          	add	a4,a2,a0
    {
      cdst[i] = c;
 15e:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 162:	0785                	addi	a5,a5,1
 164:	fee79de3          	bne	a5,a4,15e <memset+0x14>
    }
  return dst;
}
 168:	60a2                	ld	ra,8(sp)
 16a:	6402                	ld	s0,0(sp)
 16c:	0141                	addi	sp,sp,16
 16e:	8082                	ret

0000000000000170 <strchr>:

char *
strchr (const char *s, char c)
{
 170:	1141                	addi	sp,sp,-16
 172:	e406                	sd	ra,8(sp)
 174:	e022                	sd	s0,0(sp)
 176:	0800                	addi	s0,sp,16
  for (; *s; s++)
 178:	00054783          	lbu	a5,0(a0)
 17c:	cf81                	beqz	a5,194 <strchr+0x24>
    if (*s == c)
 17e:	00f58763          	beq	a1,a5,18c <strchr+0x1c>
  for (; *s; s++)
 182:	0505                	addi	a0,a0,1
 184:	00054783          	lbu	a5,0(a0)
 188:	fbfd                	bnez	a5,17e <strchr+0xe>
      return (char *)s;
  return 0;
 18a:	4501                	li	a0,0
}
 18c:	60a2                	ld	ra,8(sp)
 18e:	6402                	ld	s0,0(sp)
 190:	0141                	addi	sp,sp,16
 192:	8082                	ret
  return 0;
 194:	4501                	li	a0,0
 196:	bfdd                	j	18c <strchr+0x1c>

0000000000000198 <gets>:

char *
gets (char *buf, int max)
{
 198:	711d                	addi	sp,sp,-96
 19a:	ec86                	sd	ra,88(sp)
 19c:	e8a2                	sd	s0,80(sp)
 19e:	e4a6                	sd	s1,72(sp)
 1a0:	e0ca                	sd	s2,64(sp)
 1a2:	fc4e                	sd	s3,56(sp)
 1a4:	f852                	sd	s4,48(sp)
 1a6:	f456                	sd	s5,40(sp)
 1a8:	f05a                	sd	s6,32(sp)
 1aa:	ec5e                	sd	s7,24(sp)
 1ac:	e862                	sd	s8,16(sp)
 1ae:	1080                	addi	s0,sp,96
 1b0:	8baa                	mv	s7,a0
 1b2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 1b4:	892a                	mv	s2,a0
 1b6:	4481                	li	s1,0
    {
      cc = read (0, &c, 1);
 1b8:	faf40b13          	addi	s6,s0,-81
 1bc:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;)
 1be:	8c26                	mv	s8,s1
 1c0:	0014899b          	addiw	s3,s1,1
 1c4:	84ce                	mv	s1,s3
 1c6:	0349d463          	bge	s3,s4,1ee <gets+0x56>
      cc = read (0, &c, 1);
 1ca:	8656                	mv	a2,s5
 1cc:	85da                	mv	a1,s6
 1ce:	4501                	li	a0,0
 1d0:	190000ef          	jal	360 <read>
      if (cc < 1)
 1d4:	00a05d63          	blez	a0,1ee <gets+0x56>
        break;
      buf[i++] = c;
 1d8:	faf44783          	lbu	a5,-81(s0)
 1dc:	00f90023          	sb	a5,0(s2)
      if (c == '\n' || c == '\r')
 1e0:	0905                	addi	s2,s2,1
 1e2:	ff678713          	addi	a4,a5,-10
 1e6:	c319                	beqz	a4,1ec <gets+0x54>
 1e8:	17cd                	addi	a5,a5,-13
 1ea:	fbf1                	bnez	a5,1be <gets+0x26>
      buf[i++] = c;
 1ec:	8c4e                	mv	s8,s3
        break;
    }
  buf[i] = '\0';
 1ee:	9c5e                	add	s8,s8,s7
 1f0:	000c0023          	sb	zero,0(s8)
  return buf;
}
 1f4:	855e                	mv	a0,s7
 1f6:	60e6                	ld	ra,88(sp)
 1f8:	6446                	ld	s0,80(sp)
 1fa:	64a6                	ld	s1,72(sp)
 1fc:	6906                	ld	s2,64(sp)
 1fe:	79e2                	ld	s3,56(sp)
 200:	7a42                	ld	s4,48(sp)
 202:	7aa2                	ld	s5,40(sp)
 204:	7b02                	ld	s6,32(sp)
 206:	6be2                	ld	s7,24(sp)
 208:	6c42                	ld	s8,16(sp)
 20a:	6125                	addi	sp,sp,96
 20c:	8082                	ret

000000000000020e <stat>:

int
stat (const char *n, struct stat *st)
{
 20e:	1101                	addi	sp,sp,-32
 210:	ec06                	sd	ra,24(sp)
 212:	e822                	sd	s0,16(sp)
 214:	e04a                	sd	s2,0(sp)
 216:	1000                	addi	s0,sp,32
 218:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open (n, O_RDONLY);
 21a:	4581                	li	a1,0
 21c:	16c000ef          	jal	388 <open>
  if (fd < 0)
 220:	02054263          	bltz	a0,244 <stat+0x36>
 224:	e426                	sd	s1,8(sp)
 226:	84aa                	mv	s1,a0
    return -1;
  r = fstat (fd, st);
 228:	85ca                	mv	a1,s2
 22a:	176000ef          	jal	3a0 <fstat>
 22e:	892a                	mv	s2,a0
  close (fd);
 230:	8526                	mv	a0,s1
 232:	13e000ef          	jal	370 <close>
  return r;
 236:	64a2                	ld	s1,8(sp)
}
 238:	854a                	mv	a0,s2
 23a:	60e2                	ld	ra,24(sp)
 23c:	6442                	ld	s0,16(sp)
 23e:	6902                	ld	s2,0(sp)
 240:	6105                	addi	sp,sp,32
 242:	8082                	ret
    return -1;
 244:	57fd                	li	a5,-1
 246:	893e                	mv	s2,a5
 248:	bfc5                	j	238 <stat+0x2a>

000000000000024a <atoi>:

int
atoi (const char *s)
{
 24a:	1141                	addi	sp,sp,-16
 24c:	e406                	sd	ra,8(sp)
 24e:	e022                	sd	s0,0(sp)
 250:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 252:	00054683          	lbu	a3,0(a0)
 256:	fd06879b          	addiw	a5,a3,-48
 25a:	0ff7f793          	zext.b	a5,a5
 25e:	4625                	li	a2,9
 260:	02f66963          	bltu	a2,a5,292 <atoi+0x48>
 264:	872a                	mv	a4,a0
  n = 0;
 266:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 268:	0705                	addi	a4,a4,1
 26a:	0025179b          	slliw	a5,a0,0x2
 26e:	9fa9                	addw	a5,a5,a0
 270:	0017979b          	slliw	a5,a5,0x1
 274:	9fb5                	addw	a5,a5,a3
 276:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 27a:	00074683          	lbu	a3,0(a4)
 27e:	fd06879b          	addiw	a5,a3,-48
 282:	0ff7f793          	zext.b	a5,a5
 286:	fef671e3          	bgeu	a2,a5,268 <atoi+0x1e>
  return n;
}
 28a:	60a2                	ld	ra,8(sp)
 28c:	6402                	ld	s0,0(sp)
 28e:	0141                	addi	sp,sp,16
 290:	8082                	ret
  n = 0;
 292:	4501                	li	a0,0
 294:	bfdd                	j	28a <atoi+0x40>

0000000000000296 <memmove>:

void *
memmove (void *vdst, const void *vsrc, int n)
{
 296:	1141                	addi	sp,sp,-16
 298:	e406                	sd	ra,8(sp)
 29a:	e022                	sd	s0,0(sp)
 29c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 29e:	02b57563          	bgeu	a0,a1,2c8 <memmove+0x32>
    {
      while (n-- > 0)
 2a2:	00c05f63          	blez	a2,2c0 <memmove+0x2a>
 2a6:	1602                	slli	a2,a2,0x20
 2a8:	9201                	srli	a2,a2,0x20
 2aa:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2ae:	872a                	mv	a4,a0
        *dst++ = *src++;
 2b0:	0585                	addi	a1,a1,1
 2b2:	0705                	addi	a4,a4,1
 2b4:	fff5c683          	lbu	a3,-1(a1)
 2b8:	fed70fa3          	sb	a3,-1(a4)
      while (n-- > 0)
 2bc:	fee79ae3          	bne	a5,a4,2b0 <memmove+0x1a>
      src += n;
      while (n-- > 0)
        *--dst = *--src;
    }
  return vdst;
}
 2c0:	60a2                	ld	ra,8(sp)
 2c2:	6402                	ld	s0,0(sp)
 2c4:	0141                	addi	sp,sp,16
 2c6:	8082                	ret
      while (n-- > 0)
 2c8:	fec05ce3          	blez	a2,2c0 <memmove+0x2a>
      dst += n;
 2cc:	00c50733          	add	a4,a0,a2
      src += n;
 2d0:	95b2                	add	a1,a1,a2
 2d2:	fff6079b          	addiw	a5,a2,-1
 2d6:	1782                	slli	a5,a5,0x20
 2d8:	9381                	srli	a5,a5,0x20
 2da:	fff7c793          	not	a5,a5
 2de:	97ba                	add	a5,a5,a4
        *--dst = *--src;
 2e0:	15fd                	addi	a1,a1,-1
 2e2:	177d                	addi	a4,a4,-1
 2e4:	0005c683          	lbu	a3,0(a1)
 2e8:	00d70023          	sb	a3,0(a4)
      while (n-- > 0)
 2ec:	fef71ae3          	bne	a4,a5,2e0 <memmove+0x4a>
 2f0:	bfc1                	j	2c0 <memmove+0x2a>

00000000000002f2 <memcmp>:

int
memcmp (const void *s1, const void *s2, uint n)
{
 2f2:	1141                	addi	sp,sp,-16
 2f4:	e406                	sd	ra,8(sp)
 2f6:	e022                	sd	s0,0(sp)
 2f8:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 2fa:	c61d                	beqz	a2,328 <memcmp+0x36>
 2fc:	1602                	slli	a2,a2,0x20
 2fe:	9201                	srli	a2,a2,0x20
 300:	00c506b3          	add	a3,a0,a2
    {
      if (*p1 != *p2)
 304:	00054783          	lbu	a5,0(a0)
 308:	0005c703          	lbu	a4,0(a1)
 30c:	00e79863          	bne	a5,a4,31c <memcmp+0x2a>
        {
          return *p1 - *p2;
        }
      p1++;
 310:	0505                	addi	a0,a0,1
      p2++;
 312:	0585                	addi	a1,a1,1
  while (n-- > 0)
 314:	fed518e3          	bne	a0,a3,304 <memcmp+0x12>
    }
  return 0;
 318:	4501                	li	a0,0
 31a:	a019                	j	320 <memcmp+0x2e>
          return *p1 - *p2;
 31c:	40e7853b          	subw	a0,a5,a4
}
 320:	60a2                	ld	ra,8(sp)
 322:	6402                	ld	s0,0(sp)
 324:	0141                	addi	sp,sp,16
 326:	8082                	ret
  return 0;
 328:	4501                	li	a0,0
 32a:	bfdd                	j	320 <memcmp+0x2e>

000000000000032c <memcpy>:

void *
memcpy (void *dst, const void *src, uint n)
{
 32c:	1141                	addi	sp,sp,-16
 32e:	e406                	sd	ra,8(sp)
 330:	e022                	sd	s0,0(sp)
 332:	0800                	addi	s0,sp,16
  return memmove (dst, src, n);
 334:	f63ff0ef          	jal	296 <memmove>
}
 338:	60a2                	ld	ra,8(sp)
 33a:	6402                	ld	s0,0(sp)
 33c:	0141                	addi	sp,sp,16
 33e:	8082                	ret

0000000000000340 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 340:	4885                	li	a7,1
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <exit>:
.global exit
exit:
 li a7, SYS_exit
 348:	4889                	li	a7,2
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <wait>:
.global wait
wait:
 li a7, SYS_wait
 350:	488d                	li	a7,3
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 358:	4891                	li	a7,4
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <read>:
.global read
read:
 li a7, SYS_read
 360:	4895                	li	a7,5
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <write>:
.global write
write:
 li a7, SYS_write
 368:	48c1                	li	a7,16
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <close>:
.global close
close:
 li a7, SYS_close
 370:	48d5                	li	a7,21
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <kill>:
.global kill
kill:
 li a7, SYS_kill
 378:	4899                	li	a7,6
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <exec>:
.global exec
exec:
 li a7, SYS_exec
 380:	489d                	li	a7,7
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <open>:
.global open
open:
 li a7, SYS_open
 388:	48bd                	li	a7,15
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 390:	48c5                	li	a7,17
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 398:	48c9                	li	a7,18
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3a0:	48a1                	li	a7,8
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <link>:
.global link
link:
 li a7, SYS_link
 3a8:	48cd                	li	a7,19
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3b0:	48d1                	li	a7,20
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3b8:	48a5                	li	a7,9
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3c0:	48a9                	li	a7,10
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3c8:	48ad                	li	a7,11
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3d0:	48b1                	li	a7,12
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3d8:	48b5                	li	a7,13
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3e0:	48b9                	li	a7,14
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3e8:	48d9                	li	a7,22
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3f0:	1101                	addi	sp,sp,-32
 3f2:	ec06                	sd	ra,24(sp)
 3f4:	e822                	sd	s0,16(sp)
 3f6:	1000                	addi	s0,sp,32
 3f8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3fc:	4605                	li	a2,1
 3fe:	fef40593          	addi	a1,s0,-17
 402:	f67ff0ef          	jal	368 <write>
}
 406:	60e2                	ld	ra,24(sp)
 408:	6442                	ld	s0,16(sp)
 40a:	6105                	addi	sp,sp,32
 40c:	8082                	ret

000000000000040e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 40e:	7139                	addi	sp,sp,-64
 410:	fc06                	sd	ra,56(sp)
 412:	f822                	sd	s0,48(sp)
 414:	f04a                	sd	s2,32(sp)
 416:	ec4e                	sd	s3,24(sp)
 418:	0080                	addi	s0,sp,64
 41a:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 41c:	cac9                	beqz	a3,4ae <printint+0xa0>
 41e:	01f5d79b          	srliw	a5,a1,0x1f
 422:	c7d1                	beqz	a5,4ae <printint+0xa0>
    neg = 1;
    x = -xx;
 424:	40b005bb          	negw	a1,a1
    neg = 1;
 428:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 42a:	fc040993          	addi	s3,s0,-64
  neg = 0;
 42e:	86ce                	mv	a3,s3
  i = 0;
 430:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 432:	00000817          	auipc	a6,0x0
 436:	57e80813          	addi	a6,a6,1406 # 9b0 <digits>
 43a:	88ba                	mv	a7,a4
 43c:	0017051b          	addiw	a0,a4,1
 440:	872a                	mv	a4,a0
 442:	02c5f7bb          	remuw	a5,a1,a2
 446:	1782                	slli	a5,a5,0x20
 448:	9381                	srli	a5,a5,0x20
 44a:	97c2                	add	a5,a5,a6
 44c:	0007c783          	lbu	a5,0(a5)
 450:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 454:	87ae                	mv	a5,a1
 456:	02c5d5bb          	divuw	a1,a1,a2
 45a:	0685                	addi	a3,a3,1
 45c:	fcc7ffe3          	bgeu	a5,a2,43a <printint+0x2c>
  if(neg)
 460:	00030c63          	beqz	t1,478 <printint+0x6a>
    buf[i++] = '-';
 464:	fd050793          	addi	a5,a0,-48
 468:	00878533          	add	a0,a5,s0
 46c:	02d00793          	li	a5,45
 470:	fef50823          	sb	a5,-16(a0)
 474:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 478:	02e05563          	blez	a4,4a2 <printint+0x94>
 47c:	f426                	sd	s1,40(sp)
 47e:	377d                	addiw	a4,a4,-1
 480:	00e984b3          	add	s1,s3,a4
 484:	19fd                	addi	s3,s3,-1
 486:	99ba                	add	s3,s3,a4
 488:	1702                	slli	a4,a4,0x20
 48a:	9301                	srli	a4,a4,0x20
 48c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 490:	0004c583          	lbu	a1,0(s1)
 494:	854a                	mv	a0,s2
 496:	f5bff0ef          	jal	3f0 <putc>
  while(--i >= 0)
 49a:	14fd                	addi	s1,s1,-1
 49c:	ff349ae3          	bne	s1,s3,490 <printint+0x82>
 4a0:	74a2                	ld	s1,40(sp)
}
 4a2:	70e2                	ld	ra,56(sp)
 4a4:	7442                	ld	s0,48(sp)
 4a6:	7902                	ld	s2,32(sp)
 4a8:	69e2                	ld	s3,24(sp)
 4aa:	6121                	addi	sp,sp,64
 4ac:	8082                	ret
  neg = 0;
 4ae:	4301                	li	t1,0
 4b0:	bfad                	j	42a <printint+0x1c>

00000000000004b2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4b2:	711d                	addi	sp,sp,-96
 4b4:	ec86                	sd	ra,88(sp)
 4b6:	e8a2                	sd	s0,80(sp)
 4b8:	e4a6                	sd	s1,72(sp)
 4ba:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4bc:	0005c483          	lbu	s1,0(a1)
 4c0:	20048963          	beqz	s1,6d2 <vprintf+0x220>
 4c4:	e0ca                	sd	s2,64(sp)
 4c6:	fc4e                	sd	s3,56(sp)
 4c8:	f852                	sd	s4,48(sp)
 4ca:	f456                	sd	s5,40(sp)
 4cc:	f05a                	sd	s6,32(sp)
 4ce:	ec5e                	sd	s7,24(sp)
 4d0:	e862                	sd	s8,16(sp)
 4d2:	8b2a                	mv	s6,a0
 4d4:	8a2e                	mv	s4,a1
 4d6:	8bb2                	mv	s7,a2
  state = 0;
 4d8:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 4da:	4901                	li	s2,0
 4dc:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 4de:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 4e2:	06400c13          	li	s8,100
 4e6:	a00d                	j	508 <vprintf+0x56>
        putc(fd, c0);
 4e8:	85a6                	mv	a1,s1
 4ea:	855a                	mv	a0,s6
 4ec:	f05ff0ef          	jal	3f0 <putc>
 4f0:	a019                	j	4f6 <vprintf+0x44>
    } else if(state == '%'){
 4f2:	03598363          	beq	s3,s5,518 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 4f6:	0019079b          	addiw	a5,s2,1
 4fa:	893e                	mv	s2,a5
 4fc:	873e                	mv	a4,a5
 4fe:	97d2                	add	a5,a5,s4
 500:	0007c483          	lbu	s1,0(a5)
 504:	1c048063          	beqz	s1,6c4 <vprintf+0x212>
    c0 = fmt[i] & 0xff;
 508:	0004879b          	sext.w	a5,s1
    if(state == 0){
 50c:	fe0993e3          	bnez	s3,4f2 <vprintf+0x40>
      if(c0 == '%'){
 510:	fd579ce3          	bne	a5,s5,4e8 <vprintf+0x36>
        state = '%';
 514:	89be                	mv	s3,a5
 516:	b7c5                	j	4f6 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 518:	00ea06b3          	add	a3,s4,a4
 51c:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 520:	1a060e63          	beqz	a2,6dc <vprintf+0x22a>
      if(c0 == 'd'){
 524:	03878763          	beq	a5,s8,552 <vprintf+0xa0>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 528:	f9478693          	addi	a3,a5,-108
 52c:	0016b693          	seqz	a3,a3
 530:	f9c60593          	addi	a1,a2,-100
 534:	e99d                	bnez	a1,56a <vprintf+0xb8>
 536:	ca95                	beqz	a3,56a <vprintf+0xb8>
        printint(fd, va_arg(ap, uint64), 10, 1);
 538:	008b8493          	addi	s1,s7,8
 53c:	4685                	li	a3,1
 53e:	4629                	li	a2,10
 540:	000ba583          	lw	a1,0(s7)
 544:	855a                	mv	a0,s6
 546:	ec9ff0ef          	jal	40e <printint>
        i += 1;
 54a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 54c:	8ba6                	mv	s7,s1
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 54e:	4981                	li	s3,0
 550:	b75d                	j	4f6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 552:	008b8493          	addi	s1,s7,8
 556:	4685                	li	a3,1
 558:	4629                	li	a2,10
 55a:	000ba583          	lw	a1,0(s7)
 55e:	855a                	mv	a0,s6
 560:	eafff0ef          	jal	40e <printint>
 564:	8ba6                	mv	s7,s1
      state = 0;
 566:	4981                	li	s3,0
 568:	b779                	j	4f6 <vprintf+0x44>
      if(c1) c2 = fmt[i+2] & 0xff;
 56a:	9752                	add	a4,a4,s4
 56c:	00274583          	lbu	a1,2(a4)
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 570:	f9460713          	addi	a4,a2,-108
 574:	00173713          	seqz	a4,a4
 578:	8f75                	and	a4,a4,a3
 57a:	f9c58513          	addi	a0,a1,-100
 57e:	16051963          	bnez	a0,6f0 <vprintf+0x23e>
 582:	16070763          	beqz	a4,6f0 <vprintf+0x23e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 586:	008b8493          	addi	s1,s7,8
 58a:	4685                	li	a3,1
 58c:	4629                	li	a2,10
 58e:	000ba583          	lw	a1,0(s7)
 592:	855a                	mv	a0,s6
 594:	e7bff0ef          	jal	40e <printint>
        i += 2;
 598:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 59a:	8ba6                	mv	s7,s1
      state = 0;
 59c:	4981                	li	s3,0
        i += 2;
 59e:	bfa1                	j	4f6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 0);
 5a0:	008b8493          	addi	s1,s7,8
 5a4:	4681                	li	a3,0
 5a6:	4629                	li	a2,10
 5a8:	000ba583          	lw	a1,0(s7)
 5ac:	855a                	mv	a0,s6
 5ae:	e61ff0ef          	jal	40e <printint>
 5b2:	8ba6                	mv	s7,s1
      state = 0;
 5b4:	4981                	li	s3,0
 5b6:	b781                	j	4f6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5b8:	008b8493          	addi	s1,s7,8
 5bc:	4681                	li	a3,0
 5be:	4629                	li	a2,10
 5c0:	000ba583          	lw	a1,0(s7)
 5c4:	855a                	mv	a0,s6
 5c6:	e49ff0ef          	jal	40e <printint>
        i += 1;
 5ca:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 5cc:	8ba6                	mv	s7,s1
      state = 0;
 5ce:	4981                	li	s3,0
 5d0:	b71d                	j	4f6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5d2:	008b8493          	addi	s1,s7,8
 5d6:	4681                	li	a3,0
 5d8:	4629                	li	a2,10
 5da:	000ba583          	lw	a1,0(s7)
 5de:	855a                	mv	a0,s6
 5e0:	e2fff0ef          	jal	40e <printint>
        i += 2;
 5e4:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 5e6:	8ba6                	mv	s7,s1
      state = 0;
 5e8:	4981                	li	s3,0
        i += 2;
 5ea:	b731                	j	4f6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 5ec:	008b8493          	addi	s1,s7,8
 5f0:	4681                	li	a3,0
 5f2:	4641                	li	a2,16
 5f4:	000ba583          	lw	a1,0(s7)
 5f8:	855a                	mv	a0,s6
 5fa:	e15ff0ef          	jal	40e <printint>
 5fe:	8ba6                	mv	s7,s1
      state = 0;
 600:	4981                	li	s3,0
 602:	bdd5                	j	4f6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 604:	008b8493          	addi	s1,s7,8
 608:	4681                	li	a3,0
 60a:	4641                	li	a2,16
 60c:	000ba583          	lw	a1,0(s7)
 610:	855a                	mv	a0,s6
 612:	dfdff0ef          	jal	40e <printint>
        i += 1;
 616:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 618:	8ba6                	mv	s7,s1
      state = 0;
 61a:	4981                	li	s3,0
 61c:	bde9                	j	4f6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 61e:	008b8493          	addi	s1,s7,8
 622:	4681                	li	a3,0
 624:	4641                	li	a2,16
 626:	000ba583          	lw	a1,0(s7)
 62a:	855a                	mv	a0,s6
 62c:	de3ff0ef          	jal	40e <printint>
        i += 2;
 630:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 632:	8ba6                	mv	s7,s1
      state = 0;
 634:	4981                	li	s3,0
        i += 2;
 636:	b5c1                	j	4f6 <vprintf+0x44>
 638:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 63a:	008b8793          	addi	a5,s7,8
 63e:	8cbe                	mv	s9,a5
 640:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 644:	03000593          	li	a1,48
 648:	855a                	mv	a0,s6
 64a:	da7ff0ef          	jal	3f0 <putc>
  putc(fd, 'x');
 64e:	07800593          	li	a1,120
 652:	855a                	mv	a0,s6
 654:	d9dff0ef          	jal	3f0 <putc>
 658:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 65a:	00000b97          	auipc	s7,0x0
 65e:	356b8b93          	addi	s7,s7,854 # 9b0 <digits>
 662:	03c9d793          	srli	a5,s3,0x3c
 666:	97de                	add	a5,a5,s7
 668:	0007c583          	lbu	a1,0(a5)
 66c:	855a                	mv	a0,s6
 66e:	d83ff0ef          	jal	3f0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 672:	0992                	slli	s3,s3,0x4
 674:	34fd                	addiw	s1,s1,-1
 676:	f4f5                	bnez	s1,662 <vprintf+0x1b0>
        printptr(fd, va_arg(ap, uint64));
 678:	8be6                	mv	s7,s9
      state = 0;
 67a:	4981                	li	s3,0
 67c:	6ca2                	ld	s9,8(sp)
 67e:	bda5                	j	4f6 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 680:	008b8993          	addi	s3,s7,8
 684:	000bb483          	ld	s1,0(s7)
 688:	cc91                	beqz	s1,6a4 <vprintf+0x1f2>
        for(; *s; s++)
 68a:	0004c583          	lbu	a1,0(s1)
 68e:	c985                	beqz	a1,6be <vprintf+0x20c>
          putc(fd, *s);
 690:	855a                	mv	a0,s6
 692:	d5fff0ef          	jal	3f0 <putc>
        for(; *s; s++)
 696:	0485                	addi	s1,s1,1
 698:	0004c583          	lbu	a1,0(s1)
 69c:	f9f5                	bnez	a1,690 <vprintf+0x1de>
        if((s = va_arg(ap, char*)) == 0)
 69e:	8bce                	mv	s7,s3
      state = 0;
 6a0:	4981                	li	s3,0
 6a2:	bd91                	j	4f6 <vprintf+0x44>
          s = "(null)";
 6a4:	00000497          	auipc	s1,0x0
 6a8:	30448493          	addi	s1,s1,772 # 9a8 <malloc+0x170>
        for(; *s; s++)
 6ac:	02800593          	li	a1,40
 6b0:	b7c5                	j	690 <vprintf+0x1de>
        putc(fd, '%');
 6b2:	85be                	mv	a1,a5
 6b4:	855a                	mv	a0,s6
 6b6:	d3bff0ef          	jal	3f0 <putc>
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	bd2d                	j	4f6 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 6be:	8bce                	mv	s7,s3
      state = 0;
 6c0:	4981                	li	s3,0
 6c2:	bd15                	j	4f6 <vprintf+0x44>
 6c4:	6906                	ld	s2,64(sp)
 6c6:	79e2                	ld	s3,56(sp)
 6c8:	7a42                	ld	s4,48(sp)
 6ca:	7aa2                	ld	s5,40(sp)
 6cc:	7b02                	ld	s6,32(sp)
 6ce:	6be2                	ld	s7,24(sp)
 6d0:	6c42                	ld	s8,16(sp)
    }
  }
}
 6d2:	60e6                	ld	ra,88(sp)
 6d4:	6446                	ld	s0,80(sp)
 6d6:	64a6                	ld	s1,72(sp)
 6d8:	6125                	addi	sp,sp,96
 6da:	8082                	ret
      if(c0 == 'd'){
 6dc:	06400713          	li	a4,100
 6e0:	e6e789e3          	beq	a5,a4,552 <vprintf+0xa0>
      } else if(c0 == 'l' && c1 == 'd'){
 6e4:	f9478693          	addi	a3,a5,-108
 6e8:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 6ec:	85b2                	mv	a1,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6ee:	4701                	li	a4,0
      } else if(c0 == 'u'){
 6f0:	07500513          	li	a0,117
 6f4:	eaa786e3          	beq	a5,a0,5a0 <vprintf+0xee>
      } else if(c0 == 'l' && c1 == 'u'){
 6f8:	f8b60513          	addi	a0,a2,-117
 6fc:	e119                	bnez	a0,702 <vprintf+0x250>
 6fe:	ea069de3          	bnez	a3,5b8 <vprintf+0x106>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 702:	f8b58513          	addi	a0,a1,-117
 706:	e119                	bnez	a0,70c <vprintf+0x25a>
 708:	ec0715e3          	bnez	a4,5d2 <vprintf+0x120>
      } else if(c0 == 'x'){
 70c:	07800513          	li	a0,120
 710:	eca78ee3          	beq	a5,a0,5ec <vprintf+0x13a>
      } else if(c0 == 'l' && c1 == 'x'){
 714:	f8860613          	addi	a2,a2,-120
 718:	e219                	bnez	a2,71e <vprintf+0x26c>
 71a:	ee0695e3          	bnez	a3,604 <vprintf+0x152>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 71e:	f8858593          	addi	a1,a1,-120
 722:	e199                	bnez	a1,728 <vprintf+0x276>
 724:	ee071de3          	bnez	a4,61e <vprintf+0x16c>
      } else if(c0 == 'p'){
 728:	07000713          	li	a4,112
 72c:	f0e786e3          	beq	a5,a4,638 <vprintf+0x186>
      } else if(c0 == 's'){
 730:	07300713          	li	a4,115
 734:	f4e786e3          	beq	a5,a4,680 <vprintf+0x1ce>
      } else if(c0 == '%'){
 738:	02500713          	li	a4,37
 73c:	f6e78be3          	beq	a5,a4,6b2 <vprintf+0x200>
        putc(fd, '%');
 740:	02500593          	li	a1,37
 744:	855a                	mv	a0,s6
 746:	cabff0ef          	jal	3f0 <putc>
        putc(fd, c0);
 74a:	85a6                	mv	a1,s1
 74c:	855a                	mv	a0,s6
 74e:	ca3ff0ef          	jal	3f0 <putc>
      state = 0;
 752:	4981                	li	s3,0
 754:	b34d                	j	4f6 <vprintf+0x44>

0000000000000756 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 756:	715d                	addi	sp,sp,-80
 758:	ec06                	sd	ra,24(sp)
 75a:	e822                	sd	s0,16(sp)
 75c:	1000                	addi	s0,sp,32
 75e:	e010                	sd	a2,0(s0)
 760:	e414                	sd	a3,8(s0)
 762:	e818                	sd	a4,16(s0)
 764:	ec1c                	sd	a5,24(s0)
 766:	03043023          	sd	a6,32(s0)
 76a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 76e:	8622                	mv	a2,s0
 770:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 774:	d3fff0ef          	jal	4b2 <vprintf>
}
 778:	60e2                	ld	ra,24(sp)
 77a:	6442                	ld	s0,16(sp)
 77c:	6161                	addi	sp,sp,80
 77e:	8082                	ret

0000000000000780 <printf>:

void
printf(const char *fmt, ...)
{
 780:	711d                	addi	sp,sp,-96
 782:	ec06                	sd	ra,24(sp)
 784:	e822                	sd	s0,16(sp)
 786:	1000                	addi	s0,sp,32
 788:	e40c                	sd	a1,8(s0)
 78a:	e810                	sd	a2,16(s0)
 78c:	ec14                	sd	a3,24(s0)
 78e:	f018                	sd	a4,32(s0)
 790:	f41c                	sd	a5,40(s0)
 792:	03043823          	sd	a6,48(s0)
 796:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 79a:	00840613          	addi	a2,s0,8
 79e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7a2:	85aa                	mv	a1,a0
 7a4:	4505                	li	a0,1
 7a6:	d0dff0ef          	jal	4b2 <vprintf>
}
 7aa:	60e2                	ld	ra,24(sp)
 7ac:	6442                	ld	s0,16(sp)
 7ae:	6125                	addi	sp,sp,96
 7b0:	8082                	ret

00000000000007b2 <free>:
static Header base;
static Header *freep;

void
free (void *ap)
{
 7b2:	1141                	addi	sp,sp,-16
 7b4:	e406                	sd	ra,8(sp)
 7b6:	e022                	sd	s0,0(sp)
 7b8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 7ba:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7be:	00001797          	auipc	a5,0x1
 7c2:	8527b783          	ld	a5,-1966(a5) # 1010 <freep>
 7c6:	a039                	j	7d4 <free+0x22>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c8:	6398                	ld	a4,0(a5)
 7ca:	00e7e463          	bltu	a5,a4,7d2 <free+0x20>
 7ce:	00e6ea63          	bltu	a3,a4,7e2 <free+0x30>
{
 7d2:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d4:	fed7fae3          	bgeu	a5,a3,7c8 <free+0x16>
 7d8:	6398                	ld	a4,0(a5)
 7da:	00e6e463          	bltu	a3,a4,7e2 <free+0x30>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7de:	fee7eae3          	bltu	a5,a4,7d2 <free+0x20>
      break;
  if (bp + bp->s.size == p->s.ptr)
 7e2:	ff852583          	lw	a1,-8(a0)
 7e6:	6390                	ld	a2,0(a5)
 7e8:	02059813          	slli	a6,a1,0x20
 7ec:	01c85713          	srli	a4,a6,0x1c
 7f0:	9736                	add	a4,a4,a3
 7f2:	02e60563          	beq	a2,a4,81c <free+0x6a>
    {
      bp->s.size += p->s.ptr->s.size;
      bp->s.ptr = p->s.ptr->s.ptr;
 7f6:	fec53823          	sd	a2,-16(a0)
    }
  else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp)
 7fa:	4790                	lw	a2,8(a5)
 7fc:	02061593          	slli	a1,a2,0x20
 800:	01c5d713          	srli	a4,a1,0x1c
 804:	973e                	add	a4,a4,a5
 806:	02e68263          	beq	a3,a4,82a <free+0x78>
    {
      p->s.size += bp->s.size;
      p->s.ptr = bp->s.ptr;
 80a:	e394                	sd	a3,0(a5)
    }
  else
    p->s.ptr = bp;
  freep = p;
 80c:	00001717          	auipc	a4,0x1
 810:	80f73223          	sd	a5,-2044(a4) # 1010 <freep>
}
 814:	60a2                	ld	ra,8(sp)
 816:	6402                	ld	s0,0(sp)
 818:	0141                	addi	sp,sp,16
 81a:	8082                	ret
      bp->s.size += p->s.ptr->s.size;
 81c:	4618                	lw	a4,8(a2)
 81e:	9f2d                	addw	a4,a4,a1
 820:	fee52c23          	sw	a4,-8(a0)
      bp->s.ptr = p->s.ptr->s.ptr;
 824:	6398                	ld	a4,0(a5)
 826:	6310                	ld	a2,0(a4)
 828:	b7f9                	j	7f6 <free+0x44>
      p->s.size += bp->s.size;
 82a:	ff852703          	lw	a4,-8(a0)
 82e:	9f31                	addw	a4,a4,a2
 830:	c798                	sw	a4,8(a5)
      p->s.ptr = bp->s.ptr;
 832:	ff053683          	ld	a3,-16(a0)
 836:	bfd1                	j	80a <free+0x58>

0000000000000838 <malloc>:
  return freep;
}

void *
malloc (uint nbytes)
{
 838:	7139                	addi	sp,sp,-64
 83a:	fc06                	sd	ra,56(sp)
 83c:	f822                	sd	s0,48(sp)
 83e:	f04a                	sd	s2,32(sp)
 840:	ec4e                	sd	s3,24(sp)
 842:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof (Header) - 1) / sizeof (Header) + 1;
 844:	02051993          	slli	s3,a0,0x20
 848:	0209d993          	srli	s3,s3,0x20
 84c:	09bd                	addi	s3,s3,15
 84e:	0049d993          	srli	s3,s3,0x4
 852:	2985                	addiw	s3,s3,1
 854:	894e                	mv	s2,s3
  if ((prevp = freep) == 0)
 856:	00000517          	auipc	a0,0x0
 85a:	7ba53503          	ld	a0,1978(a0) # 1010 <freep>
 85e:	c905                	beqz	a0,88e <malloc+0x56>
    {
      base.s.ptr = freep = prevp = &base;
      base.s.size = 0;
    }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 860:	611c                	ld	a5,0(a0)
    {
      if (p->s.size >= nunits)
 862:	4798                	lw	a4,8(a5)
 864:	09377663          	bgeu	a4,s3,8f0 <malloc+0xb8>
 868:	f426                	sd	s1,40(sp)
 86a:	e852                	sd	s4,16(sp)
 86c:	e456                	sd	s5,8(sp)
 86e:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 870:	8a4e                	mv	s4,s3
 872:	6705                	lui	a4,0x1
 874:	00e9f363          	bgeu	s3,a4,87a <malloc+0x42>
 878:	6a05                	lui	s4,0x1
 87a:	000a0b1b          	sext.w	s6,s4
  p = sbrk (nu * sizeof (Header));
 87e:	004a1a1b          	slliw	s4,s4,0x4
              p->s.size = nunits;
            }
          freep = prevp;
          return (void *)(p + 1);
        }
      if (p == freep)
 882:	00000497          	auipc	s1,0x0
 886:	78e48493          	addi	s1,s1,1934 # 1010 <freep>
  if (p == (char *)-1)
 88a:	5afd                	li	s5,-1
 88c:	a83d                	j	8ca <malloc+0x92>
 88e:	f426                	sd	s1,40(sp)
 890:	e852                	sd	s4,16(sp)
 892:	e456                	sd	s5,8(sp)
 894:	e05a                	sd	s6,0(sp)
      base.s.ptr = freep = prevp = &base;
 896:	00000797          	auipc	a5,0x0
 89a:	78a78793          	addi	a5,a5,1930 # 1020 <base>
 89e:	00000717          	auipc	a4,0x0
 8a2:	76f73923          	sd	a5,1906(a4) # 1010 <freep>
 8a6:	e39c                	sd	a5,0(a5)
      base.s.size = 0;
 8a8:	0007a423          	sw	zero,8(a5)
      if (p->s.size >= nunits)
 8ac:	b7d1                	j	870 <malloc+0x38>
            prevp->s.ptr = p->s.ptr;
 8ae:	6398                	ld	a4,0(a5)
 8b0:	e118                	sd	a4,0(a0)
 8b2:	a899                	j	908 <malloc+0xd0>
  hp->s.size = nu;
 8b4:	01652423          	sw	s6,8(a0)
  free ((void *)(hp + 1));
 8b8:	0541                	addi	a0,a0,16
 8ba:	ef9ff0ef          	jal	7b2 <free>
  return freep;
 8be:	6088                	ld	a0,0(s1)
        if ((p = morecore (nunits)) == 0)
 8c0:	c125                	beqz	a0,920 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 8c2:	611c                	ld	a5,0(a0)
      if (p->s.size >= nunits)
 8c4:	4798                	lw	a4,8(a5)
 8c6:	03277163          	bgeu	a4,s2,8e8 <malloc+0xb0>
      if (p == freep)
 8ca:	6098                	ld	a4,0(s1)
 8cc:	853e                	mv	a0,a5
 8ce:	fef71ae3          	bne	a4,a5,8c2 <malloc+0x8a>
  p = sbrk (nu * sizeof (Header));
 8d2:	8552                	mv	a0,s4
 8d4:	afdff0ef          	jal	3d0 <sbrk>
  if (p == (char *)-1)
 8d8:	fd551ee3          	bne	a0,s5,8b4 <malloc+0x7c>
          return 0;
 8dc:	4501                	li	a0,0
 8de:	74a2                	ld	s1,40(sp)
 8e0:	6a42                	ld	s4,16(sp)
 8e2:	6aa2                	ld	s5,8(sp)
 8e4:	6b02                	ld	s6,0(sp)
 8e6:	a03d                	j	914 <malloc+0xdc>
 8e8:	74a2                	ld	s1,40(sp)
 8ea:	6a42                	ld	s4,16(sp)
 8ec:	6aa2                	ld	s5,8(sp)
 8ee:	6b02                	ld	s6,0(sp)
          if (p->s.size == nunits)
 8f0:	fae90fe3          	beq	s2,a4,8ae <malloc+0x76>
              p->s.size -= nunits;
 8f4:	4137073b          	subw	a4,a4,s3
 8f8:	c798                	sw	a4,8(a5)
              p += p->s.size;
 8fa:	02071693          	slli	a3,a4,0x20
 8fe:	01c6d713          	srli	a4,a3,0x1c
 902:	97ba                	add	a5,a5,a4
              p->s.size = nunits;
 904:	0137a423          	sw	s3,8(a5)
          freep = prevp;
 908:	00000717          	auipc	a4,0x0
 90c:	70a73423          	sd	a0,1800(a4) # 1010 <freep>
          return (void *)(p + 1);
 910:	01078513          	addi	a0,a5,16
    }
}
 914:	70e2                	ld	ra,56(sp)
 916:	7442                	ld	s0,48(sp)
 918:	7902                	ld	s2,32(sp)
 91a:	69e2                	ld	s3,24(sp)
 91c:	6121                	addi	sp,sp,64
 91e:	8082                	ret
 920:	74a2                	ld	s1,40(sp)
 922:	6a42                	ld	s4,16(sp)
 924:	6aa2                	ld	s5,8(sp)
 926:	6b02                	ld	s6,0(sp)
 928:	b7f5                	j	914 <malloc+0xdc>
