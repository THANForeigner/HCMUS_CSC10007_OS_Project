
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(fork() > 0)
   8:	29a000ef          	jal	2a2 <fork>
   c:	00a04563          	bgtz	a0,16 <main+0x16>
    sleep(5);  // Let child exit before parent.
  exit(0);
  10:	4501                	li	a0,0
  12:	298000ef          	jal	2aa <exit>
    sleep(5);  // Let child exit before parent.
  16:	4515                	li	a0,5
  18:	322000ef          	jal	33a <sleep>
  1c:	bfd5                	j	10 <main+0x10>

000000000000001e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start ()
{
  1e:	1141                	addi	sp,sp,-16
  20:	e406                	sd	ra,8(sp)
  22:	e022                	sd	s0,0(sp)
  24:	0800                	addi	s0,sp,16
  extern int main ();
  main ();
  26:	fdbff0ef          	jal	0 <main>
  exit (0);
  2a:	4501                	li	a0,0
  2c:	27e000ef          	jal	2aa <exit>

0000000000000030 <strcpy>:
}

char *
strcpy (char *s, const char *t)
{
  30:	1141                	addi	sp,sp,-16
  32:	e406                	sd	ra,8(sp)
  34:	e022                	sd	s0,0(sp)
  36:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  38:	87aa                	mv	a5,a0
  3a:	0585                	addi	a1,a1,1
  3c:	0785                	addi	a5,a5,1
  3e:	fff5c703          	lbu	a4,-1(a1)
  42:	fee78fa3          	sb	a4,-1(a5)
  46:	fb75                	bnez	a4,3a <strcpy+0xa>
    ;
  return os;
}
  48:	60a2                	ld	ra,8(sp)
  4a:	6402                	ld	s0,0(sp)
  4c:	0141                	addi	sp,sp,16
  4e:	8082                	ret

0000000000000050 <strcmp>:

int
strcmp (const char *p, const char *q)
{
  50:	1141                	addi	sp,sp,-16
  52:	e406                	sd	ra,8(sp)
  54:	e022                	sd	s0,0(sp)
  56:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  58:	00054783          	lbu	a5,0(a0)
  5c:	cb91                	beqz	a5,70 <strcmp+0x20>
  5e:	0005c703          	lbu	a4,0(a1)
  62:	00f71763          	bne	a4,a5,70 <strcmp+0x20>
    p++, q++;
  66:	0505                	addi	a0,a0,1
  68:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  6a:	00054783          	lbu	a5,0(a0)
  6e:	fbe5                	bnez	a5,5e <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  70:	0005c503          	lbu	a0,0(a1)
}
  74:	40a7853b          	subw	a0,a5,a0
  78:	60a2                	ld	ra,8(sp)
  7a:	6402                	ld	s0,0(sp)
  7c:	0141                	addi	sp,sp,16
  7e:	8082                	ret

0000000000000080 <strlen>:

uint
strlen (const char *s)
{
  80:	1141                	addi	sp,sp,-16
  82:	e406                	sd	ra,8(sp)
  84:	e022                	sd	s0,0(sp)
  86:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  88:	00054783          	lbu	a5,0(a0)
  8c:	cf91                	beqz	a5,a8 <strlen+0x28>
  8e:	00150793          	addi	a5,a0,1
  92:	86be                	mv	a3,a5
  94:	0785                	addi	a5,a5,1
  96:	fff7c703          	lbu	a4,-1(a5)
  9a:	ff65                	bnez	a4,92 <strlen+0x12>
  9c:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  a0:	60a2                	ld	ra,8(sp)
  a2:	6402                	ld	s0,0(sp)
  a4:	0141                	addi	sp,sp,16
  a6:	8082                	ret
  for (n = 0; s[n]; n++)
  a8:	4501                	li	a0,0
  aa:	bfdd                	j	a0 <strlen+0x20>

00000000000000ac <memset>:

void *
memset (void *dst, int c, uint n)
{
  ac:	1141                	addi	sp,sp,-16
  ae:	e406                	sd	ra,8(sp)
  b0:	e022                	sd	s0,0(sp)
  b2:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
  b4:	ca19                	beqz	a2,ca <memset+0x1e>
  b6:	87aa                	mv	a5,a0
  b8:	1602                	slli	a2,a2,0x20
  ba:	9201                	srli	a2,a2,0x20
  bc:	00a60733          	add	a4,a2,a0
    {
      cdst[i] = c;
  c0:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
  c4:	0785                	addi	a5,a5,1
  c6:	fee79de3          	bne	a5,a4,c0 <memset+0x14>
    }
  return dst;
}
  ca:	60a2                	ld	ra,8(sp)
  cc:	6402                	ld	s0,0(sp)
  ce:	0141                	addi	sp,sp,16
  d0:	8082                	ret

00000000000000d2 <strchr>:

char *
strchr (const char *s, char c)
{
  d2:	1141                	addi	sp,sp,-16
  d4:	e406                	sd	ra,8(sp)
  d6:	e022                	sd	s0,0(sp)
  d8:	0800                	addi	s0,sp,16
  for (; *s; s++)
  da:	00054783          	lbu	a5,0(a0)
  de:	cf81                	beqz	a5,f6 <strchr+0x24>
    if (*s == c)
  e0:	00f58763          	beq	a1,a5,ee <strchr+0x1c>
  for (; *s; s++)
  e4:	0505                	addi	a0,a0,1
  e6:	00054783          	lbu	a5,0(a0)
  ea:	fbfd                	bnez	a5,e0 <strchr+0xe>
      return (char *)s;
  return 0;
  ec:	4501                	li	a0,0
}
  ee:	60a2                	ld	ra,8(sp)
  f0:	6402                	ld	s0,0(sp)
  f2:	0141                	addi	sp,sp,16
  f4:	8082                	ret
  return 0;
  f6:	4501                	li	a0,0
  f8:	bfdd                	j	ee <strchr+0x1c>

00000000000000fa <gets>:

char *
gets (char *buf, int max)
{
  fa:	711d                	addi	sp,sp,-96
  fc:	ec86                	sd	ra,88(sp)
  fe:	e8a2                	sd	s0,80(sp)
 100:	e4a6                	sd	s1,72(sp)
 102:	e0ca                	sd	s2,64(sp)
 104:	fc4e                	sd	s3,56(sp)
 106:	f852                	sd	s4,48(sp)
 108:	f456                	sd	s5,40(sp)
 10a:	f05a                	sd	s6,32(sp)
 10c:	ec5e                	sd	s7,24(sp)
 10e:	e862                	sd	s8,16(sp)
 110:	1080                	addi	s0,sp,96
 112:	8baa                	mv	s7,a0
 114:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 116:	892a                	mv	s2,a0
 118:	4481                	li	s1,0
    {
      cc = read (0, &c, 1);
 11a:	faf40b13          	addi	s6,s0,-81
 11e:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;)
 120:	8c26                	mv	s8,s1
 122:	0014899b          	addiw	s3,s1,1
 126:	84ce                	mv	s1,s3
 128:	0349d463          	bge	s3,s4,150 <gets+0x56>
      cc = read (0, &c, 1);
 12c:	8656                	mv	a2,s5
 12e:	85da                	mv	a1,s6
 130:	4501                	li	a0,0
 132:	190000ef          	jal	2c2 <read>
      if (cc < 1)
 136:	00a05d63          	blez	a0,150 <gets+0x56>
        break;
      buf[i++] = c;
 13a:	faf44783          	lbu	a5,-81(s0)
 13e:	00f90023          	sb	a5,0(s2)
      if (c == '\n' || c == '\r')
 142:	0905                	addi	s2,s2,1
 144:	ff678713          	addi	a4,a5,-10
 148:	c319                	beqz	a4,14e <gets+0x54>
 14a:	17cd                	addi	a5,a5,-13
 14c:	fbf1                	bnez	a5,120 <gets+0x26>
      buf[i++] = c;
 14e:	8c4e                	mv	s8,s3
        break;
    }
  buf[i] = '\0';
 150:	9c5e                	add	s8,s8,s7
 152:	000c0023          	sb	zero,0(s8)
  return buf;
}
 156:	855e                	mv	a0,s7
 158:	60e6                	ld	ra,88(sp)
 15a:	6446                	ld	s0,80(sp)
 15c:	64a6                	ld	s1,72(sp)
 15e:	6906                	ld	s2,64(sp)
 160:	79e2                	ld	s3,56(sp)
 162:	7a42                	ld	s4,48(sp)
 164:	7aa2                	ld	s5,40(sp)
 166:	7b02                	ld	s6,32(sp)
 168:	6be2                	ld	s7,24(sp)
 16a:	6c42                	ld	s8,16(sp)
 16c:	6125                	addi	sp,sp,96
 16e:	8082                	ret

0000000000000170 <stat>:

int
stat (const char *n, struct stat *st)
{
 170:	1101                	addi	sp,sp,-32
 172:	ec06                	sd	ra,24(sp)
 174:	e822                	sd	s0,16(sp)
 176:	e04a                	sd	s2,0(sp)
 178:	1000                	addi	s0,sp,32
 17a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open (n, O_RDONLY);
 17c:	4581                	li	a1,0
 17e:	16c000ef          	jal	2ea <open>
  if (fd < 0)
 182:	02054263          	bltz	a0,1a6 <stat+0x36>
 186:	e426                	sd	s1,8(sp)
 188:	84aa                	mv	s1,a0
    return -1;
  r = fstat (fd, st);
 18a:	85ca                	mv	a1,s2
 18c:	176000ef          	jal	302 <fstat>
 190:	892a                	mv	s2,a0
  close (fd);
 192:	8526                	mv	a0,s1
 194:	13e000ef          	jal	2d2 <close>
  return r;
 198:	64a2                	ld	s1,8(sp)
}
 19a:	854a                	mv	a0,s2
 19c:	60e2                	ld	ra,24(sp)
 19e:	6442                	ld	s0,16(sp)
 1a0:	6902                	ld	s2,0(sp)
 1a2:	6105                	addi	sp,sp,32
 1a4:	8082                	ret
    return -1;
 1a6:	57fd                	li	a5,-1
 1a8:	893e                	mv	s2,a5
 1aa:	bfc5                	j	19a <stat+0x2a>

00000000000001ac <atoi>:

int
atoi (const char *s)
{
 1ac:	1141                	addi	sp,sp,-16
 1ae:	e406                	sd	ra,8(sp)
 1b0:	e022                	sd	s0,0(sp)
 1b2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 1b4:	00054683          	lbu	a3,0(a0)
 1b8:	fd06879b          	addiw	a5,a3,-48
 1bc:	0ff7f793          	zext.b	a5,a5
 1c0:	4625                	li	a2,9
 1c2:	02f66963          	bltu	a2,a5,1f4 <atoi+0x48>
 1c6:	872a                	mv	a4,a0
  n = 0;
 1c8:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 1ca:	0705                	addi	a4,a4,1
 1cc:	0025179b          	slliw	a5,a0,0x2
 1d0:	9fa9                	addw	a5,a5,a0
 1d2:	0017979b          	slliw	a5,a5,0x1
 1d6:	9fb5                	addw	a5,a5,a3
 1d8:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 1dc:	00074683          	lbu	a3,0(a4)
 1e0:	fd06879b          	addiw	a5,a3,-48
 1e4:	0ff7f793          	zext.b	a5,a5
 1e8:	fef671e3          	bgeu	a2,a5,1ca <atoi+0x1e>
  return n;
}
 1ec:	60a2                	ld	ra,8(sp)
 1ee:	6402                	ld	s0,0(sp)
 1f0:	0141                	addi	sp,sp,16
 1f2:	8082                	ret
  n = 0;
 1f4:	4501                	li	a0,0
 1f6:	bfdd                	j	1ec <atoi+0x40>

00000000000001f8 <memmove>:

void *
memmove (void *vdst, const void *vsrc, int n)
{
 1f8:	1141                	addi	sp,sp,-16
 1fa:	e406                	sd	ra,8(sp)
 1fc:	e022                	sd	s0,0(sp)
 1fe:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 200:	02b57563          	bgeu	a0,a1,22a <memmove+0x32>
    {
      while (n-- > 0)
 204:	00c05f63          	blez	a2,222 <memmove+0x2a>
 208:	1602                	slli	a2,a2,0x20
 20a:	9201                	srli	a2,a2,0x20
 20c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 210:	872a                	mv	a4,a0
        *dst++ = *src++;
 212:	0585                	addi	a1,a1,1
 214:	0705                	addi	a4,a4,1
 216:	fff5c683          	lbu	a3,-1(a1)
 21a:	fed70fa3          	sb	a3,-1(a4)
      while (n-- > 0)
 21e:	fee79ae3          	bne	a5,a4,212 <memmove+0x1a>
      src += n;
      while (n-- > 0)
        *--dst = *--src;
    }
  return vdst;
}
 222:	60a2                	ld	ra,8(sp)
 224:	6402                	ld	s0,0(sp)
 226:	0141                	addi	sp,sp,16
 228:	8082                	ret
      while (n-- > 0)
 22a:	fec05ce3          	blez	a2,222 <memmove+0x2a>
      dst += n;
 22e:	00c50733          	add	a4,a0,a2
      src += n;
 232:	95b2                	add	a1,a1,a2
 234:	fff6079b          	addiw	a5,a2,-1
 238:	1782                	slli	a5,a5,0x20
 23a:	9381                	srli	a5,a5,0x20
 23c:	fff7c793          	not	a5,a5
 240:	97ba                	add	a5,a5,a4
        *--dst = *--src;
 242:	15fd                	addi	a1,a1,-1
 244:	177d                	addi	a4,a4,-1
 246:	0005c683          	lbu	a3,0(a1)
 24a:	00d70023          	sb	a3,0(a4)
      while (n-- > 0)
 24e:	fef71ae3          	bne	a4,a5,242 <memmove+0x4a>
 252:	bfc1                	j	222 <memmove+0x2a>

0000000000000254 <memcmp>:

int
memcmp (const void *s1, const void *s2, uint n)
{
 254:	1141                	addi	sp,sp,-16
 256:	e406                	sd	ra,8(sp)
 258:	e022                	sd	s0,0(sp)
 25a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 25c:	c61d                	beqz	a2,28a <memcmp+0x36>
 25e:	1602                	slli	a2,a2,0x20
 260:	9201                	srli	a2,a2,0x20
 262:	00c506b3          	add	a3,a0,a2
    {
      if (*p1 != *p2)
 266:	00054783          	lbu	a5,0(a0)
 26a:	0005c703          	lbu	a4,0(a1)
 26e:	00e79863          	bne	a5,a4,27e <memcmp+0x2a>
        {
          return *p1 - *p2;
        }
      p1++;
 272:	0505                	addi	a0,a0,1
      p2++;
 274:	0585                	addi	a1,a1,1
  while (n-- > 0)
 276:	fed518e3          	bne	a0,a3,266 <memcmp+0x12>
    }
  return 0;
 27a:	4501                	li	a0,0
 27c:	a019                	j	282 <memcmp+0x2e>
          return *p1 - *p2;
 27e:	40e7853b          	subw	a0,a5,a4
}
 282:	60a2                	ld	ra,8(sp)
 284:	6402                	ld	s0,0(sp)
 286:	0141                	addi	sp,sp,16
 288:	8082                	ret
  return 0;
 28a:	4501                	li	a0,0
 28c:	bfdd                	j	282 <memcmp+0x2e>

000000000000028e <memcpy>:

void *
memcpy (void *dst, const void *src, uint n)
{
 28e:	1141                	addi	sp,sp,-16
 290:	e406                	sd	ra,8(sp)
 292:	e022                	sd	s0,0(sp)
 294:	0800                	addi	s0,sp,16
  return memmove (dst, src, n);
 296:	f63ff0ef          	jal	1f8 <memmove>
}
 29a:	60a2                	ld	ra,8(sp)
 29c:	6402                	ld	s0,0(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret

00000000000002a2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2a2:	4885                	li	a7,1
 ecall
 2a4:	00000073          	ecall
 ret
 2a8:	8082                	ret

00000000000002aa <exit>:
.global exit
exit:
 li a7, SYS_exit
 2aa:	4889                	li	a7,2
 ecall
 2ac:	00000073          	ecall
 ret
 2b0:	8082                	ret

00000000000002b2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2b2:	488d                	li	a7,3
 ecall
 2b4:	00000073          	ecall
 ret
 2b8:	8082                	ret

00000000000002ba <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2ba:	4891                	li	a7,4
 ecall
 2bc:	00000073          	ecall
 ret
 2c0:	8082                	ret

00000000000002c2 <read>:
.global read
read:
 li a7, SYS_read
 2c2:	4895                	li	a7,5
 ecall
 2c4:	00000073          	ecall
 ret
 2c8:	8082                	ret

00000000000002ca <write>:
.global write
write:
 li a7, SYS_write
 2ca:	48c1                	li	a7,16
 ecall
 2cc:	00000073          	ecall
 ret
 2d0:	8082                	ret

00000000000002d2 <close>:
.global close
close:
 li a7, SYS_close
 2d2:	48d5                	li	a7,21
 ecall
 2d4:	00000073          	ecall
 ret
 2d8:	8082                	ret

00000000000002da <kill>:
.global kill
kill:
 li a7, SYS_kill
 2da:	4899                	li	a7,6
 ecall
 2dc:	00000073          	ecall
 ret
 2e0:	8082                	ret

00000000000002e2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 2e2:	489d                	li	a7,7
 ecall
 2e4:	00000073          	ecall
 ret
 2e8:	8082                	ret

00000000000002ea <open>:
.global open
open:
 li a7, SYS_open
 2ea:	48bd                	li	a7,15
 ecall
 2ec:	00000073          	ecall
 ret
 2f0:	8082                	ret

00000000000002f2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 2f2:	48c5                	li	a7,17
 ecall
 2f4:	00000073          	ecall
 ret
 2f8:	8082                	ret

00000000000002fa <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 2fa:	48c9                	li	a7,18
 ecall
 2fc:	00000073          	ecall
 ret
 300:	8082                	ret

0000000000000302 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 302:	48a1                	li	a7,8
 ecall
 304:	00000073          	ecall
 ret
 308:	8082                	ret

000000000000030a <link>:
.global link
link:
 li a7, SYS_link
 30a:	48cd                	li	a7,19
 ecall
 30c:	00000073          	ecall
 ret
 310:	8082                	ret

0000000000000312 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 312:	48d1                	li	a7,20
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 31a:	48a5                	li	a7,9
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <dup>:
.global dup
dup:
 li a7, SYS_dup
 322:	48a9                	li	a7,10
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 32a:	48ad                	li	a7,11
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 332:	48b1                	li	a7,12
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 33a:	48b5                	li	a7,13
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 342:	48b9                	li	a7,14
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <trace>:
.global trace
trace:
 li a7, SYS_trace
 34a:	48d9                	li	a7,22
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 352:	1101                	addi	sp,sp,-32
 354:	ec06                	sd	ra,24(sp)
 356:	e822                	sd	s0,16(sp)
 358:	1000                	addi	s0,sp,32
 35a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 35e:	4605                	li	a2,1
 360:	fef40593          	addi	a1,s0,-17
 364:	f67ff0ef          	jal	2ca <write>
}
 368:	60e2                	ld	ra,24(sp)
 36a:	6442                	ld	s0,16(sp)
 36c:	6105                	addi	sp,sp,32
 36e:	8082                	ret

0000000000000370 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 370:	7139                	addi	sp,sp,-64
 372:	fc06                	sd	ra,56(sp)
 374:	f822                	sd	s0,48(sp)
 376:	f04a                	sd	s2,32(sp)
 378:	ec4e                	sd	s3,24(sp)
 37a:	0080                	addi	s0,sp,64
 37c:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 37e:	cac9                	beqz	a3,410 <printint+0xa0>
 380:	01f5d79b          	srliw	a5,a1,0x1f
 384:	c7d1                	beqz	a5,410 <printint+0xa0>
    neg = 1;
    x = -xx;
 386:	40b005bb          	negw	a1,a1
    neg = 1;
 38a:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 38c:	fc040993          	addi	s3,s0,-64
  neg = 0;
 390:	86ce                	mv	a3,s3
  i = 0;
 392:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 394:	00000817          	auipc	a6,0x0
 398:	50480813          	addi	a6,a6,1284 # 898 <digits>
 39c:	88ba                	mv	a7,a4
 39e:	0017051b          	addiw	a0,a4,1
 3a2:	872a                	mv	a4,a0
 3a4:	02c5f7bb          	remuw	a5,a1,a2
 3a8:	1782                	slli	a5,a5,0x20
 3aa:	9381                	srli	a5,a5,0x20
 3ac:	97c2                	add	a5,a5,a6
 3ae:	0007c783          	lbu	a5,0(a5)
 3b2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3b6:	87ae                	mv	a5,a1
 3b8:	02c5d5bb          	divuw	a1,a1,a2
 3bc:	0685                	addi	a3,a3,1
 3be:	fcc7ffe3          	bgeu	a5,a2,39c <printint+0x2c>
  if(neg)
 3c2:	00030c63          	beqz	t1,3da <printint+0x6a>
    buf[i++] = '-';
 3c6:	fd050793          	addi	a5,a0,-48
 3ca:	00878533          	add	a0,a5,s0
 3ce:	02d00793          	li	a5,45
 3d2:	fef50823          	sb	a5,-16(a0)
 3d6:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 3da:	02e05563          	blez	a4,404 <printint+0x94>
 3de:	f426                	sd	s1,40(sp)
 3e0:	377d                	addiw	a4,a4,-1
 3e2:	00e984b3          	add	s1,s3,a4
 3e6:	19fd                	addi	s3,s3,-1
 3e8:	99ba                	add	s3,s3,a4
 3ea:	1702                	slli	a4,a4,0x20
 3ec:	9301                	srli	a4,a4,0x20
 3ee:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 3f2:	0004c583          	lbu	a1,0(s1)
 3f6:	854a                	mv	a0,s2
 3f8:	f5bff0ef          	jal	352 <putc>
  while(--i >= 0)
 3fc:	14fd                	addi	s1,s1,-1
 3fe:	ff349ae3          	bne	s1,s3,3f2 <printint+0x82>
 402:	74a2                	ld	s1,40(sp)
}
 404:	70e2                	ld	ra,56(sp)
 406:	7442                	ld	s0,48(sp)
 408:	7902                	ld	s2,32(sp)
 40a:	69e2                	ld	s3,24(sp)
 40c:	6121                	addi	sp,sp,64
 40e:	8082                	ret
  neg = 0;
 410:	4301                	li	t1,0
 412:	bfad                	j	38c <printint+0x1c>

0000000000000414 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 414:	711d                	addi	sp,sp,-96
 416:	ec86                	sd	ra,88(sp)
 418:	e8a2                	sd	s0,80(sp)
 41a:	e4a6                	sd	s1,72(sp)
 41c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 41e:	0005c483          	lbu	s1,0(a1)
 422:	20048963          	beqz	s1,634 <vprintf+0x220>
 426:	e0ca                	sd	s2,64(sp)
 428:	fc4e                	sd	s3,56(sp)
 42a:	f852                	sd	s4,48(sp)
 42c:	f456                	sd	s5,40(sp)
 42e:	f05a                	sd	s6,32(sp)
 430:	ec5e                	sd	s7,24(sp)
 432:	e862                	sd	s8,16(sp)
 434:	8b2a                	mv	s6,a0
 436:	8a2e                	mv	s4,a1
 438:	8bb2                	mv	s7,a2
  state = 0;
 43a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 43c:	4901                	li	s2,0
 43e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 440:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 444:	06400c13          	li	s8,100
 448:	a00d                	j	46a <vprintf+0x56>
        putc(fd, c0);
 44a:	85a6                	mv	a1,s1
 44c:	855a                	mv	a0,s6
 44e:	f05ff0ef          	jal	352 <putc>
 452:	a019                	j	458 <vprintf+0x44>
    } else if(state == '%'){
 454:	03598363          	beq	s3,s5,47a <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 458:	0019079b          	addiw	a5,s2,1
 45c:	893e                	mv	s2,a5
 45e:	873e                	mv	a4,a5
 460:	97d2                	add	a5,a5,s4
 462:	0007c483          	lbu	s1,0(a5)
 466:	1c048063          	beqz	s1,626 <vprintf+0x212>
    c0 = fmt[i] & 0xff;
 46a:	0004879b          	sext.w	a5,s1
    if(state == 0){
 46e:	fe0993e3          	bnez	s3,454 <vprintf+0x40>
      if(c0 == '%'){
 472:	fd579ce3          	bne	a5,s5,44a <vprintf+0x36>
        state = '%';
 476:	89be                	mv	s3,a5
 478:	b7c5                	j	458 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 47a:	00ea06b3          	add	a3,s4,a4
 47e:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 482:	1a060e63          	beqz	a2,63e <vprintf+0x22a>
      if(c0 == 'd'){
 486:	03878763          	beq	a5,s8,4b4 <vprintf+0xa0>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 48a:	f9478693          	addi	a3,a5,-108
 48e:	0016b693          	seqz	a3,a3
 492:	f9c60593          	addi	a1,a2,-100
 496:	e99d                	bnez	a1,4cc <vprintf+0xb8>
 498:	ca95                	beqz	a3,4cc <vprintf+0xb8>
        printint(fd, va_arg(ap, uint64), 10, 1);
 49a:	008b8493          	addi	s1,s7,8
 49e:	4685                	li	a3,1
 4a0:	4629                	li	a2,10
 4a2:	000ba583          	lw	a1,0(s7)
 4a6:	855a                	mv	a0,s6
 4a8:	ec9ff0ef          	jal	370 <printint>
        i += 1;
 4ac:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 4ae:	8ba6                	mv	s7,s1
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 4b0:	4981                	li	s3,0
 4b2:	b75d                	j	458 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 4b4:	008b8493          	addi	s1,s7,8
 4b8:	4685                	li	a3,1
 4ba:	4629                	li	a2,10
 4bc:	000ba583          	lw	a1,0(s7)
 4c0:	855a                	mv	a0,s6
 4c2:	eafff0ef          	jal	370 <printint>
 4c6:	8ba6                	mv	s7,s1
      state = 0;
 4c8:	4981                	li	s3,0
 4ca:	b779                	j	458 <vprintf+0x44>
      if(c1) c2 = fmt[i+2] & 0xff;
 4cc:	9752                	add	a4,a4,s4
 4ce:	00274583          	lbu	a1,2(a4)
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 4d2:	f9460713          	addi	a4,a2,-108
 4d6:	00173713          	seqz	a4,a4
 4da:	8f75                	and	a4,a4,a3
 4dc:	f9c58513          	addi	a0,a1,-100
 4e0:	16051963          	bnez	a0,652 <vprintf+0x23e>
 4e4:	16070763          	beqz	a4,652 <vprintf+0x23e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 4e8:	008b8493          	addi	s1,s7,8
 4ec:	4685                	li	a3,1
 4ee:	4629                	li	a2,10
 4f0:	000ba583          	lw	a1,0(s7)
 4f4:	855a                	mv	a0,s6
 4f6:	e7bff0ef          	jal	370 <printint>
        i += 2;
 4fa:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 4fc:	8ba6                	mv	s7,s1
      state = 0;
 4fe:	4981                	li	s3,0
        i += 2;
 500:	bfa1                	j	458 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 0);
 502:	008b8493          	addi	s1,s7,8
 506:	4681                	li	a3,0
 508:	4629                	li	a2,10
 50a:	000ba583          	lw	a1,0(s7)
 50e:	855a                	mv	a0,s6
 510:	e61ff0ef          	jal	370 <printint>
 514:	8ba6                	mv	s7,s1
      state = 0;
 516:	4981                	li	s3,0
 518:	b781                	j	458 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 51a:	008b8493          	addi	s1,s7,8
 51e:	4681                	li	a3,0
 520:	4629                	li	a2,10
 522:	000ba583          	lw	a1,0(s7)
 526:	855a                	mv	a0,s6
 528:	e49ff0ef          	jal	370 <printint>
        i += 1;
 52c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 52e:	8ba6                	mv	s7,s1
      state = 0;
 530:	4981                	li	s3,0
 532:	b71d                	j	458 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 534:	008b8493          	addi	s1,s7,8
 538:	4681                	li	a3,0
 53a:	4629                	li	a2,10
 53c:	000ba583          	lw	a1,0(s7)
 540:	855a                	mv	a0,s6
 542:	e2fff0ef          	jal	370 <printint>
        i += 2;
 546:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 548:	8ba6                	mv	s7,s1
      state = 0;
 54a:	4981                	li	s3,0
        i += 2;
 54c:	b731                	j	458 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 54e:	008b8493          	addi	s1,s7,8
 552:	4681                	li	a3,0
 554:	4641                	li	a2,16
 556:	000ba583          	lw	a1,0(s7)
 55a:	855a                	mv	a0,s6
 55c:	e15ff0ef          	jal	370 <printint>
 560:	8ba6                	mv	s7,s1
      state = 0;
 562:	4981                	li	s3,0
 564:	bdd5                	j	458 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 566:	008b8493          	addi	s1,s7,8
 56a:	4681                	li	a3,0
 56c:	4641                	li	a2,16
 56e:	000ba583          	lw	a1,0(s7)
 572:	855a                	mv	a0,s6
 574:	dfdff0ef          	jal	370 <printint>
        i += 1;
 578:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 57a:	8ba6                	mv	s7,s1
      state = 0;
 57c:	4981                	li	s3,0
 57e:	bde9                	j	458 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 580:	008b8493          	addi	s1,s7,8
 584:	4681                	li	a3,0
 586:	4641                	li	a2,16
 588:	000ba583          	lw	a1,0(s7)
 58c:	855a                	mv	a0,s6
 58e:	de3ff0ef          	jal	370 <printint>
        i += 2;
 592:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 594:	8ba6                	mv	s7,s1
      state = 0;
 596:	4981                	li	s3,0
        i += 2;
 598:	b5c1                	j	458 <vprintf+0x44>
 59a:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 59c:	008b8793          	addi	a5,s7,8
 5a0:	8cbe                	mv	s9,a5
 5a2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5a6:	03000593          	li	a1,48
 5aa:	855a                	mv	a0,s6
 5ac:	da7ff0ef          	jal	352 <putc>
  putc(fd, 'x');
 5b0:	07800593          	li	a1,120
 5b4:	855a                	mv	a0,s6
 5b6:	d9dff0ef          	jal	352 <putc>
 5ba:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5bc:	00000b97          	auipc	s7,0x0
 5c0:	2dcb8b93          	addi	s7,s7,732 # 898 <digits>
 5c4:	03c9d793          	srli	a5,s3,0x3c
 5c8:	97de                	add	a5,a5,s7
 5ca:	0007c583          	lbu	a1,0(a5)
 5ce:	855a                	mv	a0,s6
 5d0:	d83ff0ef          	jal	352 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5d4:	0992                	slli	s3,s3,0x4
 5d6:	34fd                	addiw	s1,s1,-1
 5d8:	f4f5                	bnez	s1,5c4 <vprintf+0x1b0>
        printptr(fd, va_arg(ap, uint64));
 5da:	8be6                	mv	s7,s9
      state = 0;
 5dc:	4981                	li	s3,0
 5de:	6ca2                	ld	s9,8(sp)
 5e0:	bda5                	j	458 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 5e2:	008b8993          	addi	s3,s7,8
 5e6:	000bb483          	ld	s1,0(s7)
 5ea:	cc91                	beqz	s1,606 <vprintf+0x1f2>
        for(; *s; s++)
 5ec:	0004c583          	lbu	a1,0(s1)
 5f0:	c985                	beqz	a1,620 <vprintf+0x20c>
          putc(fd, *s);
 5f2:	855a                	mv	a0,s6
 5f4:	d5fff0ef          	jal	352 <putc>
        for(; *s; s++)
 5f8:	0485                	addi	s1,s1,1
 5fa:	0004c583          	lbu	a1,0(s1)
 5fe:	f9f5                	bnez	a1,5f2 <vprintf+0x1de>
        if((s = va_arg(ap, char*)) == 0)
 600:	8bce                	mv	s7,s3
      state = 0;
 602:	4981                	li	s3,0
 604:	bd91                	j	458 <vprintf+0x44>
          s = "(null)";
 606:	00000497          	auipc	s1,0x0
 60a:	28a48493          	addi	s1,s1,650 # 890 <malloc+0xf6>
        for(; *s; s++)
 60e:	02800593          	li	a1,40
 612:	b7c5                	j	5f2 <vprintf+0x1de>
        putc(fd, '%');
 614:	85be                	mv	a1,a5
 616:	855a                	mv	a0,s6
 618:	d3bff0ef          	jal	352 <putc>
      state = 0;
 61c:	4981                	li	s3,0
 61e:	bd2d                	j	458 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 620:	8bce                	mv	s7,s3
      state = 0;
 622:	4981                	li	s3,0
 624:	bd15                	j	458 <vprintf+0x44>
 626:	6906                	ld	s2,64(sp)
 628:	79e2                	ld	s3,56(sp)
 62a:	7a42                	ld	s4,48(sp)
 62c:	7aa2                	ld	s5,40(sp)
 62e:	7b02                	ld	s6,32(sp)
 630:	6be2                	ld	s7,24(sp)
 632:	6c42                	ld	s8,16(sp)
    }
  }
}
 634:	60e6                	ld	ra,88(sp)
 636:	6446                	ld	s0,80(sp)
 638:	64a6                	ld	s1,72(sp)
 63a:	6125                	addi	sp,sp,96
 63c:	8082                	ret
      if(c0 == 'd'){
 63e:	06400713          	li	a4,100
 642:	e6e789e3          	beq	a5,a4,4b4 <vprintf+0xa0>
      } else if(c0 == 'l' && c1 == 'd'){
 646:	f9478693          	addi	a3,a5,-108
 64a:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 64e:	85b2                	mv	a1,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 650:	4701                	li	a4,0
      } else if(c0 == 'u'){
 652:	07500513          	li	a0,117
 656:	eaa786e3          	beq	a5,a0,502 <vprintf+0xee>
      } else if(c0 == 'l' && c1 == 'u'){
 65a:	f8b60513          	addi	a0,a2,-117
 65e:	e119                	bnez	a0,664 <vprintf+0x250>
 660:	ea069de3          	bnez	a3,51a <vprintf+0x106>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 664:	f8b58513          	addi	a0,a1,-117
 668:	e119                	bnez	a0,66e <vprintf+0x25a>
 66a:	ec0715e3          	bnez	a4,534 <vprintf+0x120>
      } else if(c0 == 'x'){
 66e:	07800513          	li	a0,120
 672:	eca78ee3          	beq	a5,a0,54e <vprintf+0x13a>
      } else if(c0 == 'l' && c1 == 'x'){
 676:	f8860613          	addi	a2,a2,-120
 67a:	e219                	bnez	a2,680 <vprintf+0x26c>
 67c:	ee0695e3          	bnez	a3,566 <vprintf+0x152>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 680:	f8858593          	addi	a1,a1,-120
 684:	e199                	bnez	a1,68a <vprintf+0x276>
 686:	ee071de3          	bnez	a4,580 <vprintf+0x16c>
      } else if(c0 == 'p'){
 68a:	07000713          	li	a4,112
 68e:	f0e786e3          	beq	a5,a4,59a <vprintf+0x186>
      } else if(c0 == 's'){
 692:	07300713          	li	a4,115
 696:	f4e786e3          	beq	a5,a4,5e2 <vprintf+0x1ce>
      } else if(c0 == '%'){
 69a:	02500713          	li	a4,37
 69e:	f6e78be3          	beq	a5,a4,614 <vprintf+0x200>
        putc(fd, '%');
 6a2:	02500593          	li	a1,37
 6a6:	855a                	mv	a0,s6
 6a8:	cabff0ef          	jal	352 <putc>
        putc(fd, c0);
 6ac:	85a6                	mv	a1,s1
 6ae:	855a                	mv	a0,s6
 6b0:	ca3ff0ef          	jal	352 <putc>
      state = 0;
 6b4:	4981                	li	s3,0
 6b6:	b34d                	j	458 <vprintf+0x44>

00000000000006b8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6b8:	715d                	addi	sp,sp,-80
 6ba:	ec06                	sd	ra,24(sp)
 6bc:	e822                	sd	s0,16(sp)
 6be:	1000                	addi	s0,sp,32
 6c0:	e010                	sd	a2,0(s0)
 6c2:	e414                	sd	a3,8(s0)
 6c4:	e818                	sd	a4,16(s0)
 6c6:	ec1c                	sd	a5,24(s0)
 6c8:	03043023          	sd	a6,32(s0)
 6cc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6d0:	8622                	mv	a2,s0
 6d2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6d6:	d3fff0ef          	jal	414 <vprintf>
}
 6da:	60e2                	ld	ra,24(sp)
 6dc:	6442                	ld	s0,16(sp)
 6de:	6161                	addi	sp,sp,80
 6e0:	8082                	ret

00000000000006e2 <printf>:

void
printf(const char *fmt, ...)
{
 6e2:	711d                	addi	sp,sp,-96
 6e4:	ec06                	sd	ra,24(sp)
 6e6:	e822                	sd	s0,16(sp)
 6e8:	1000                	addi	s0,sp,32
 6ea:	e40c                	sd	a1,8(s0)
 6ec:	e810                	sd	a2,16(s0)
 6ee:	ec14                	sd	a3,24(s0)
 6f0:	f018                	sd	a4,32(s0)
 6f2:	f41c                	sd	a5,40(s0)
 6f4:	03043823          	sd	a6,48(s0)
 6f8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6fc:	00840613          	addi	a2,s0,8
 700:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 704:	85aa                	mv	a1,a0
 706:	4505                	li	a0,1
 708:	d0dff0ef          	jal	414 <vprintf>
}
 70c:	60e2                	ld	ra,24(sp)
 70e:	6442                	ld	s0,16(sp)
 710:	6125                	addi	sp,sp,96
 712:	8082                	ret

0000000000000714 <free>:
static Header base;
static Header *freep;

void
free (void *ap)
{
 714:	1141                	addi	sp,sp,-16
 716:	e406                	sd	ra,8(sp)
 718:	e022                	sd	s0,0(sp)
 71a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 71c:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 720:	00001797          	auipc	a5,0x1
 724:	8e07b783          	ld	a5,-1824(a5) # 1000 <freep>
 728:	a039                	j	736 <free+0x22>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 72a:	6398                	ld	a4,0(a5)
 72c:	00e7e463          	bltu	a5,a4,734 <free+0x20>
 730:	00e6ea63          	bltu	a3,a4,744 <free+0x30>
{
 734:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 736:	fed7fae3          	bgeu	a5,a3,72a <free+0x16>
 73a:	6398                	ld	a4,0(a5)
 73c:	00e6e463          	bltu	a3,a4,744 <free+0x30>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 740:	fee7eae3          	bltu	a5,a4,734 <free+0x20>
      break;
  if (bp + bp->s.size == p->s.ptr)
 744:	ff852583          	lw	a1,-8(a0)
 748:	6390                	ld	a2,0(a5)
 74a:	02059813          	slli	a6,a1,0x20
 74e:	01c85713          	srli	a4,a6,0x1c
 752:	9736                	add	a4,a4,a3
 754:	02e60563          	beq	a2,a4,77e <free+0x6a>
    {
      bp->s.size += p->s.ptr->s.size;
      bp->s.ptr = p->s.ptr->s.ptr;
 758:	fec53823          	sd	a2,-16(a0)
    }
  else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp)
 75c:	4790                	lw	a2,8(a5)
 75e:	02061593          	slli	a1,a2,0x20
 762:	01c5d713          	srli	a4,a1,0x1c
 766:	973e                	add	a4,a4,a5
 768:	02e68263          	beq	a3,a4,78c <free+0x78>
    {
      p->s.size += bp->s.size;
      p->s.ptr = bp->s.ptr;
 76c:	e394                	sd	a3,0(a5)
    }
  else
    p->s.ptr = bp;
  freep = p;
 76e:	00001717          	auipc	a4,0x1
 772:	88f73923          	sd	a5,-1902(a4) # 1000 <freep>
}
 776:	60a2                	ld	ra,8(sp)
 778:	6402                	ld	s0,0(sp)
 77a:	0141                	addi	sp,sp,16
 77c:	8082                	ret
      bp->s.size += p->s.ptr->s.size;
 77e:	4618                	lw	a4,8(a2)
 780:	9f2d                	addw	a4,a4,a1
 782:	fee52c23          	sw	a4,-8(a0)
      bp->s.ptr = p->s.ptr->s.ptr;
 786:	6398                	ld	a4,0(a5)
 788:	6310                	ld	a2,0(a4)
 78a:	b7f9                	j	758 <free+0x44>
      p->s.size += bp->s.size;
 78c:	ff852703          	lw	a4,-8(a0)
 790:	9f31                	addw	a4,a4,a2
 792:	c798                	sw	a4,8(a5)
      p->s.ptr = bp->s.ptr;
 794:	ff053683          	ld	a3,-16(a0)
 798:	bfd1                	j	76c <free+0x58>

000000000000079a <malloc>:
  return freep;
}

void *
malloc (uint nbytes)
{
 79a:	7139                	addi	sp,sp,-64
 79c:	fc06                	sd	ra,56(sp)
 79e:	f822                	sd	s0,48(sp)
 7a0:	f04a                	sd	s2,32(sp)
 7a2:	ec4e                	sd	s3,24(sp)
 7a4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof (Header) - 1) / sizeof (Header) + 1;
 7a6:	02051993          	slli	s3,a0,0x20
 7aa:	0209d993          	srli	s3,s3,0x20
 7ae:	09bd                	addi	s3,s3,15
 7b0:	0049d993          	srli	s3,s3,0x4
 7b4:	2985                	addiw	s3,s3,1
 7b6:	894e                	mv	s2,s3
  if ((prevp = freep) == 0)
 7b8:	00001517          	auipc	a0,0x1
 7bc:	84853503          	ld	a0,-1976(a0) # 1000 <freep>
 7c0:	c905                	beqz	a0,7f0 <malloc+0x56>
    {
      base.s.ptr = freep = prevp = &base;
      base.s.size = 0;
    }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 7c2:	611c                	ld	a5,0(a0)
    {
      if (p->s.size >= nunits)
 7c4:	4798                	lw	a4,8(a5)
 7c6:	09377663          	bgeu	a4,s3,852 <malloc+0xb8>
 7ca:	f426                	sd	s1,40(sp)
 7cc:	e852                	sd	s4,16(sp)
 7ce:	e456                	sd	s5,8(sp)
 7d0:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 7d2:	8a4e                	mv	s4,s3
 7d4:	6705                	lui	a4,0x1
 7d6:	00e9f363          	bgeu	s3,a4,7dc <malloc+0x42>
 7da:	6a05                	lui	s4,0x1
 7dc:	000a0b1b          	sext.w	s6,s4
  p = sbrk (nu * sizeof (Header));
 7e0:	004a1a1b          	slliw	s4,s4,0x4
              p->s.size = nunits;
            }
          freep = prevp;
          return (void *)(p + 1);
        }
      if (p == freep)
 7e4:	00001497          	auipc	s1,0x1
 7e8:	81c48493          	addi	s1,s1,-2020 # 1000 <freep>
  if (p == (char *)-1)
 7ec:	5afd                	li	s5,-1
 7ee:	a83d                	j	82c <malloc+0x92>
 7f0:	f426                	sd	s1,40(sp)
 7f2:	e852                	sd	s4,16(sp)
 7f4:	e456                	sd	s5,8(sp)
 7f6:	e05a                	sd	s6,0(sp)
      base.s.ptr = freep = prevp = &base;
 7f8:	00001797          	auipc	a5,0x1
 7fc:	81878793          	addi	a5,a5,-2024 # 1010 <base>
 800:	00001717          	auipc	a4,0x1
 804:	80f73023          	sd	a5,-2048(a4) # 1000 <freep>
 808:	e39c                	sd	a5,0(a5)
      base.s.size = 0;
 80a:	0007a423          	sw	zero,8(a5)
      if (p->s.size >= nunits)
 80e:	b7d1                	j	7d2 <malloc+0x38>
            prevp->s.ptr = p->s.ptr;
 810:	6398                	ld	a4,0(a5)
 812:	e118                	sd	a4,0(a0)
 814:	a899                	j	86a <malloc+0xd0>
  hp->s.size = nu;
 816:	01652423          	sw	s6,8(a0)
  free ((void *)(hp + 1));
 81a:	0541                	addi	a0,a0,16
 81c:	ef9ff0ef          	jal	714 <free>
  return freep;
 820:	6088                	ld	a0,0(s1)
        if ((p = morecore (nunits)) == 0)
 822:	c125                	beqz	a0,882 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 824:	611c                	ld	a5,0(a0)
      if (p->s.size >= nunits)
 826:	4798                	lw	a4,8(a5)
 828:	03277163          	bgeu	a4,s2,84a <malloc+0xb0>
      if (p == freep)
 82c:	6098                	ld	a4,0(s1)
 82e:	853e                	mv	a0,a5
 830:	fef71ae3          	bne	a4,a5,824 <malloc+0x8a>
  p = sbrk (nu * sizeof (Header));
 834:	8552                	mv	a0,s4
 836:	afdff0ef          	jal	332 <sbrk>
  if (p == (char *)-1)
 83a:	fd551ee3          	bne	a0,s5,816 <malloc+0x7c>
          return 0;
 83e:	4501                	li	a0,0
 840:	74a2                	ld	s1,40(sp)
 842:	6a42                	ld	s4,16(sp)
 844:	6aa2                	ld	s5,8(sp)
 846:	6b02                	ld	s6,0(sp)
 848:	a03d                	j	876 <malloc+0xdc>
 84a:	74a2                	ld	s1,40(sp)
 84c:	6a42                	ld	s4,16(sp)
 84e:	6aa2                	ld	s5,8(sp)
 850:	6b02                	ld	s6,0(sp)
          if (p->s.size == nunits)
 852:	fae90fe3          	beq	s2,a4,810 <malloc+0x76>
              p->s.size -= nunits;
 856:	4137073b          	subw	a4,a4,s3
 85a:	c798                	sw	a4,8(a5)
              p += p->s.size;
 85c:	02071693          	slli	a3,a4,0x20
 860:	01c6d713          	srli	a4,a3,0x1c
 864:	97ba                	add	a5,a5,a4
              p->s.size = nunits;
 866:	0137a423          	sw	s3,8(a5)
          freep = prevp;
 86a:	00000717          	auipc	a4,0x0
 86e:	78a73b23          	sd	a0,1942(a4) # 1000 <freep>
          return (void *)(p + 1);
 872:	01078513          	addi	a0,a5,16
    }
}
 876:	70e2                	ld	ra,56(sp)
 878:	7442                	ld	s0,48(sp)
 87a:	7902                	ld	s2,32(sp)
 87c:	69e2                	ld	s3,24(sp)
 87e:	6121                	addi	sp,sp,64
 880:	8082                	ret
 882:	74a2                	ld	s1,40(sp)
 884:	6a42                	ld	s4,16(sp)
 886:	6aa2                	ld	s5,8(sp)
 888:	6b02                	ld	s6,0(sp)
 88a:	b7f5                	j	876 <malloc+0xdc>
