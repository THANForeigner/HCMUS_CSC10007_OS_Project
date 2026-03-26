
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	02a7d963          	bge	a5,a0,3c <main+0x3c>
   e:	e426                	sd	s1,8(sp)
  10:	e04a                	sd	s2,0(sp)
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	02091793          	slli	a5,s2,0x20
  1e:	01d7d913          	srli	s2,a5,0x1d
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  26:	6088                	ld	a0,0(s1)
  28:	1ba000ef          	jal	1e2 <atoi>
  2c:	2e4000ef          	jal	310 <kill>
  for(i=1; i<argc; i++)
  30:	04a1                	addi	s1,s1,8
  32:	ff249ae3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  36:	4501                	li	a0,0
  38:	2a8000ef          	jal	2e0 <exit>
  3c:	e426                	sd	s1,8(sp)
  3e:	e04a                	sd	s2,0(sp)
    fprintf(2, "usage: kill pid...\n");
  40:	00001597          	auipc	a1,0x1
  44:	89058593          	addi	a1,a1,-1904 # 8d0 <malloc+0x100>
  48:	4509                	li	a0,2
  4a:	6a4000ef          	jal	6ee <fprintf>
    exit(1);
  4e:	4505                	li	a0,1
  50:	290000ef          	jal	2e0 <exit>

0000000000000054 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start ()
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  extern int main ();
  main ();
  5c:	fa5ff0ef          	jal	0 <main>
  exit (0);
  60:	4501                	li	a0,0
  62:	27e000ef          	jal	2e0 <exit>

0000000000000066 <strcpy>:
}

char *
strcpy (char *s, const char *t)
{
  66:	1141                	addi	sp,sp,-16
  68:	e406                	sd	ra,8(sp)
  6a:	e022                	sd	s0,0(sp)
  6c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  6e:	87aa                	mv	a5,a0
  70:	0585                	addi	a1,a1,1
  72:	0785                	addi	a5,a5,1
  74:	fff5c703          	lbu	a4,-1(a1)
  78:	fee78fa3          	sb	a4,-1(a5)
  7c:	fb75                	bnez	a4,70 <strcpy+0xa>
    ;
  return os;
}
  7e:	60a2                	ld	ra,8(sp)
  80:	6402                	ld	s0,0(sp)
  82:	0141                	addi	sp,sp,16
  84:	8082                	ret

0000000000000086 <strcmp>:

int
strcmp (const char *p, const char *q)
{
  86:	1141                	addi	sp,sp,-16
  88:	e406                	sd	ra,8(sp)
  8a:	e022                	sd	s0,0(sp)
  8c:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  8e:	00054783          	lbu	a5,0(a0)
  92:	cb91                	beqz	a5,a6 <strcmp+0x20>
  94:	0005c703          	lbu	a4,0(a1)
  98:	00f71763          	bne	a4,a5,a6 <strcmp+0x20>
    p++, q++;
  9c:	0505                	addi	a0,a0,1
  9e:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  a0:	00054783          	lbu	a5,0(a0)
  a4:	fbe5                	bnez	a5,94 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  a6:	0005c503          	lbu	a0,0(a1)
}
  aa:	40a7853b          	subw	a0,a5,a0
  ae:	60a2                	ld	ra,8(sp)
  b0:	6402                	ld	s0,0(sp)
  b2:	0141                	addi	sp,sp,16
  b4:	8082                	ret

00000000000000b6 <strlen>:

uint
strlen (const char *s)
{
  b6:	1141                	addi	sp,sp,-16
  b8:	e406                	sd	ra,8(sp)
  ba:	e022                	sd	s0,0(sp)
  bc:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  be:	00054783          	lbu	a5,0(a0)
  c2:	cf91                	beqz	a5,de <strlen+0x28>
  c4:	00150793          	addi	a5,a0,1
  c8:	86be                	mv	a3,a5
  ca:	0785                	addi	a5,a5,1
  cc:	fff7c703          	lbu	a4,-1(a5)
  d0:	ff65                	bnez	a4,c8 <strlen+0x12>
  d2:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  d6:	60a2                	ld	ra,8(sp)
  d8:	6402                	ld	s0,0(sp)
  da:	0141                	addi	sp,sp,16
  dc:	8082                	ret
  for (n = 0; s[n]; n++)
  de:	4501                	li	a0,0
  e0:	bfdd                	j	d6 <strlen+0x20>

00000000000000e2 <memset>:

void *
memset (void *dst, int c, uint n)
{
  e2:	1141                	addi	sp,sp,-16
  e4:	e406                	sd	ra,8(sp)
  e6:	e022                	sd	s0,0(sp)
  e8:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
  ea:	ca19                	beqz	a2,100 <memset+0x1e>
  ec:	87aa                	mv	a5,a0
  ee:	1602                	slli	a2,a2,0x20
  f0:	9201                	srli	a2,a2,0x20
  f2:	00a60733          	add	a4,a2,a0
    {
      cdst[i] = c;
  f6:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
  fa:	0785                	addi	a5,a5,1
  fc:	fee79de3          	bne	a5,a4,f6 <memset+0x14>
    }
  return dst;
}
 100:	60a2                	ld	ra,8(sp)
 102:	6402                	ld	s0,0(sp)
 104:	0141                	addi	sp,sp,16
 106:	8082                	ret

0000000000000108 <strchr>:

char *
strchr (const char *s, char c)
{
 108:	1141                	addi	sp,sp,-16
 10a:	e406                	sd	ra,8(sp)
 10c:	e022                	sd	s0,0(sp)
 10e:	0800                	addi	s0,sp,16
  for (; *s; s++)
 110:	00054783          	lbu	a5,0(a0)
 114:	cf81                	beqz	a5,12c <strchr+0x24>
    if (*s == c)
 116:	00f58763          	beq	a1,a5,124 <strchr+0x1c>
  for (; *s; s++)
 11a:	0505                	addi	a0,a0,1
 11c:	00054783          	lbu	a5,0(a0)
 120:	fbfd                	bnez	a5,116 <strchr+0xe>
      return (char *)s;
  return 0;
 122:	4501                	li	a0,0
}
 124:	60a2                	ld	ra,8(sp)
 126:	6402                	ld	s0,0(sp)
 128:	0141                	addi	sp,sp,16
 12a:	8082                	ret
  return 0;
 12c:	4501                	li	a0,0
 12e:	bfdd                	j	124 <strchr+0x1c>

0000000000000130 <gets>:

char *
gets (char *buf, int max)
{
 130:	711d                	addi	sp,sp,-96
 132:	ec86                	sd	ra,88(sp)
 134:	e8a2                	sd	s0,80(sp)
 136:	e4a6                	sd	s1,72(sp)
 138:	e0ca                	sd	s2,64(sp)
 13a:	fc4e                	sd	s3,56(sp)
 13c:	f852                	sd	s4,48(sp)
 13e:	f456                	sd	s5,40(sp)
 140:	f05a                	sd	s6,32(sp)
 142:	ec5e                	sd	s7,24(sp)
 144:	e862                	sd	s8,16(sp)
 146:	1080                	addi	s0,sp,96
 148:	8baa                	mv	s7,a0
 14a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 14c:	892a                	mv	s2,a0
 14e:	4481                	li	s1,0
    {
      cc = read (0, &c, 1);
 150:	faf40b13          	addi	s6,s0,-81
 154:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;)
 156:	8c26                	mv	s8,s1
 158:	0014899b          	addiw	s3,s1,1
 15c:	84ce                	mv	s1,s3
 15e:	0349d463          	bge	s3,s4,186 <gets+0x56>
      cc = read (0, &c, 1);
 162:	8656                	mv	a2,s5
 164:	85da                	mv	a1,s6
 166:	4501                	li	a0,0
 168:	190000ef          	jal	2f8 <read>
      if (cc < 1)
 16c:	00a05d63          	blez	a0,186 <gets+0x56>
        break;
      buf[i++] = c;
 170:	faf44783          	lbu	a5,-81(s0)
 174:	00f90023          	sb	a5,0(s2)
      if (c == '\n' || c == '\r')
 178:	0905                	addi	s2,s2,1
 17a:	ff678713          	addi	a4,a5,-10
 17e:	c319                	beqz	a4,184 <gets+0x54>
 180:	17cd                	addi	a5,a5,-13
 182:	fbf1                	bnez	a5,156 <gets+0x26>
      buf[i++] = c;
 184:	8c4e                	mv	s8,s3
        break;
    }
  buf[i] = '\0';
 186:	9c5e                	add	s8,s8,s7
 188:	000c0023          	sb	zero,0(s8)
  return buf;
}
 18c:	855e                	mv	a0,s7
 18e:	60e6                	ld	ra,88(sp)
 190:	6446                	ld	s0,80(sp)
 192:	64a6                	ld	s1,72(sp)
 194:	6906                	ld	s2,64(sp)
 196:	79e2                	ld	s3,56(sp)
 198:	7a42                	ld	s4,48(sp)
 19a:	7aa2                	ld	s5,40(sp)
 19c:	7b02                	ld	s6,32(sp)
 19e:	6be2                	ld	s7,24(sp)
 1a0:	6c42                	ld	s8,16(sp)
 1a2:	6125                	addi	sp,sp,96
 1a4:	8082                	ret

00000000000001a6 <stat>:

int
stat (const char *n, struct stat *st)
{
 1a6:	1101                	addi	sp,sp,-32
 1a8:	ec06                	sd	ra,24(sp)
 1aa:	e822                	sd	s0,16(sp)
 1ac:	e04a                	sd	s2,0(sp)
 1ae:	1000                	addi	s0,sp,32
 1b0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open (n, O_RDONLY);
 1b2:	4581                	li	a1,0
 1b4:	16c000ef          	jal	320 <open>
  if (fd < 0)
 1b8:	02054263          	bltz	a0,1dc <stat+0x36>
 1bc:	e426                	sd	s1,8(sp)
 1be:	84aa                	mv	s1,a0
    return -1;
  r = fstat (fd, st);
 1c0:	85ca                	mv	a1,s2
 1c2:	176000ef          	jal	338 <fstat>
 1c6:	892a                	mv	s2,a0
  close (fd);
 1c8:	8526                	mv	a0,s1
 1ca:	13e000ef          	jal	308 <close>
  return r;
 1ce:	64a2                	ld	s1,8(sp)
}
 1d0:	854a                	mv	a0,s2
 1d2:	60e2                	ld	ra,24(sp)
 1d4:	6442                	ld	s0,16(sp)
 1d6:	6902                	ld	s2,0(sp)
 1d8:	6105                	addi	sp,sp,32
 1da:	8082                	ret
    return -1;
 1dc:	57fd                	li	a5,-1
 1de:	893e                	mv	s2,a5
 1e0:	bfc5                	j	1d0 <stat+0x2a>

00000000000001e2 <atoi>:

int
atoi (const char *s)
{
 1e2:	1141                	addi	sp,sp,-16
 1e4:	e406                	sd	ra,8(sp)
 1e6:	e022                	sd	s0,0(sp)
 1e8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 1ea:	00054683          	lbu	a3,0(a0)
 1ee:	fd06879b          	addiw	a5,a3,-48
 1f2:	0ff7f793          	zext.b	a5,a5
 1f6:	4625                	li	a2,9
 1f8:	02f66963          	bltu	a2,a5,22a <atoi+0x48>
 1fc:	872a                	mv	a4,a0
  n = 0;
 1fe:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 200:	0705                	addi	a4,a4,1
 202:	0025179b          	slliw	a5,a0,0x2
 206:	9fa9                	addw	a5,a5,a0
 208:	0017979b          	slliw	a5,a5,0x1
 20c:	9fb5                	addw	a5,a5,a3
 20e:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 212:	00074683          	lbu	a3,0(a4)
 216:	fd06879b          	addiw	a5,a3,-48
 21a:	0ff7f793          	zext.b	a5,a5
 21e:	fef671e3          	bgeu	a2,a5,200 <atoi+0x1e>
  return n;
}
 222:	60a2                	ld	ra,8(sp)
 224:	6402                	ld	s0,0(sp)
 226:	0141                	addi	sp,sp,16
 228:	8082                	ret
  n = 0;
 22a:	4501                	li	a0,0
 22c:	bfdd                	j	222 <atoi+0x40>

000000000000022e <memmove>:

void *
memmove (void *vdst, const void *vsrc, int n)
{
 22e:	1141                	addi	sp,sp,-16
 230:	e406                	sd	ra,8(sp)
 232:	e022                	sd	s0,0(sp)
 234:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 236:	02b57563          	bgeu	a0,a1,260 <memmove+0x32>
    {
      while (n-- > 0)
 23a:	00c05f63          	blez	a2,258 <memmove+0x2a>
 23e:	1602                	slli	a2,a2,0x20
 240:	9201                	srli	a2,a2,0x20
 242:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 246:	872a                	mv	a4,a0
        *dst++ = *src++;
 248:	0585                	addi	a1,a1,1
 24a:	0705                	addi	a4,a4,1
 24c:	fff5c683          	lbu	a3,-1(a1)
 250:	fed70fa3          	sb	a3,-1(a4)
      while (n-- > 0)
 254:	fee79ae3          	bne	a5,a4,248 <memmove+0x1a>
      src += n;
      while (n-- > 0)
        *--dst = *--src;
    }
  return vdst;
}
 258:	60a2                	ld	ra,8(sp)
 25a:	6402                	ld	s0,0(sp)
 25c:	0141                	addi	sp,sp,16
 25e:	8082                	ret
      while (n-- > 0)
 260:	fec05ce3          	blez	a2,258 <memmove+0x2a>
      dst += n;
 264:	00c50733          	add	a4,a0,a2
      src += n;
 268:	95b2                	add	a1,a1,a2
 26a:	fff6079b          	addiw	a5,a2,-1
 26e:	1782                	slli	a5,a5,0x20
 270:	9381                	srli	a5,a5,0x20
 272:	fff7c793          	not	a5,a5
 276:	97ba                	add	a5,a5,a4
        *--dst = *--src;
 278:	15fd                	addi	a1,a1,-1
 27a:	177d                	addi	a4,a4,-1
 27c:	0005c683          	lbu	a3,0(a1)
 280:	00d70023          	sb	a3,0(a4)
      while (n-- > 0)
 284:	fef71ae3          	bne	a4,a5,278 <memmove+0x4a>
 288:	bfc1                	j	258 <memmove+0x2a>

000000000000028a <memcmp>:

int
memcmp (const void *s1, const void *s2, uint n)
{
 28a:	1141                	addi	sp,sp,-16
 28c:	e406                	sd	ra,8(sp)
 28e:	e022                	sd	s0,0(sp)
 290:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 292:	c61d                	beqz	a2,2c0 <memcmp+0x36>
 294:	1602                	slli	a2,a2,0x20
 296:	9201                	srli	a2,a2,0x20
 298:	00c506b3          	add	a3,a0,a2
    {
      if (*p1 != *p2)
 29c:	00054783          	lbu	a5,0(a0)
 2a0:	0005c703          	lbu	a4,0(a1)
 2a4:	00e79863          	bne	a5,a4,2b4 <memcmp+0x2a>
        {
          return *p1 - *p2;
        }
      p1++;
 2a8:	0505                	addi	a0,a0,1
      p2++;
 2aa:	0585                	addi	a1,a1,1
  while (n-- > 0)
 2ac:	fed518e3          	bne	a0,a3,29c <memcmp+0x12>
    }
  return 0;
 2b0:	4501                	li	a0,0
 2b2:	a019                	j	2b8 <memcmp+0x2e>
          return *p1 - *p2;
 2b4:	40e7853b          	subw	a0,a5,a4
}
 2b8:	60a2                	ld	ra,8(sp)
 2ba:	6402                	ld	s0,0(sp)
 2bc:	0141                	addi	sp,sp,16
 2be:	8082                	ret
  return 0;
 2c0:	4501                	li	a0,0
 2c2:	bfdd                	j	2b8 <memcmp+0x2e>

00000000000002c4 <memcpy>:

void *
memcpy (void *dst, const void *src, uint n)
{
 2c4:	1141                	addi	sp,sp,-16
 2c6:	e406                	sd	ra,8(sp)
 2c8:	e022                	sd	s0,0(sp)
 2ca:	0800                	addi	s0,sp,16
  return memmove (dst, src, n);
 2cc:	f63ff0ef          	jal	22e <memmove>
}
 2d0:	60a2                	ld	ra,8(sp)
 2d2:	6402                	ld	s0,0(sp)
 2d4:	0141                	addi	sp,sp,16
 2d6:	8082                	ret

00000000000002d8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2d8:	4885                	li	a7,1
 ecall
 2da:	00000073          	ecall
 ret
 2de:	8082                	ret

00000000000002e0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2e0:	4889                	li	a7,2
 ecall
 2e2:	00000073          	ecall
 ret
 2e6:	8082                	ret

00000000000002e8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2e8:	488d                	li	a7,3
 ecall
 2ea:	00000073          	ecall
 ret
 2ee:	8082                	ret

00000000000002f0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2f0:	4891                	li	a7,4
 ecall
 2f2:	00000073          	ecall
 ret
 2f6:	8082                	ret

00000000000002f8 <read>:
.global read
read:
 li a7, SYS_read
 2f8:	4895                	li	a7,5
 ecall
 2fa:	00000073          	ecall
 ret
 2fe:	8082                	ret

0000000000000300 <write>:
.global write
write:
 li a7, SYS_write
 300:	48c1                	li	a7,16
 ecall
 302:	00000073          	ecall
 ret
 306:	8082                	ret

0000000000000308 <close>:
.global close
close:
 li a7, SYS_close
 308:	48d5                	li	a7,21
 ecall
 30a:	00000073          	ecall
 ret
 30e:	8082                	ret

0000000000000310 <kill>:
.global kill
kill:
 li a7, SYS_kill
 310:	4899                	li	a7,6
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <exec>:
.global exec
exec:
 li a7, SYS_exec
 318:	489d                	li	a7,7
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <open>:
.global open
open:
 li a7, SYS_open
 320:	48bd                	li	a7,15
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 328:	48c5                	li	a7,17
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 330:	48c9                	li	a7,18
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 338:	48a1                	li	a7,8
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <link>:
.global link
link:
 li a7, SYS_link
 340:	48cd                	li	a7,19
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 348:	48d1                	li	a7,20
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 350:	48a5                	li	a7,9
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <dup>:
.global dup
dup:
 li a7, SYS_dup
 358:	48a9                	li	a7,10
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 360:	48ad                	li	a7,11
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 368:	48b1                	li	a7,12
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 370:	48b5                	li	a7,13
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 378:	48b9                	li	a7,14
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <trace>:
.global trace
trace:
 li a7, SYS_trace
 380:	48d9                	li	a7,22
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 388:	1101                	addi	sp,sp,-32
 38a:	ec06                	sd	ra,24(sp)
 38c:	e822                	sd	s0,16(sp)
 38e:	1000                	addi	s0,sp,32
 390:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 394:	4605                	li	a2,1
 396:	fef40593          	addi	a1,s0,-17
 39a:	f67ff0ef          	jal	300 <write>
}
 39e:	60e2                	ld	ra,24(sp)
 3a0:	6442                	ld	s0,16(sp)
 3a2:	6105                	addi	sp,sp,32
 3a4:	8082                	ret

00000000000003a6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3a6:	7139                	addi	sp,sp,-64
 3a8:	fc06                	sd	ra,56(sp)
 3aa:	f822                	sd	s0,48(sp)
 3ac:	f04a                	sd	s2,32(sp)
 3ae:	ec4e                	sd	s3,24(sp)
 3b0:	0080                	addi	s0,sp,64
 3b2:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3b4:	cac9                	beqz	a3,446 <printint+0xa0>
 3b6:	01f5d79b          	srliw	a5,a1,0x1f
 3ba:	c7d1                	beqz	a5,446 <printint+0xa0>
    neg = 1;
    x = -xx;
 3bc:	40b005bb          	negw	a1,a1
    neg = 1;
 3c0:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 3c2:	fc040993          	addi	s3,s0,-64
  neg = 0;
 3c6:	86ce                	mv	a3,s3
  i = 0;
 3c8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3ca:	00000817          	auipc	a6,0x0
 3ce:	52680813          	addi	a6,a6,1318 # 8f0 <digits>
 3d2:	88ba                	mv	a7,a4
 3d4:	0017051b          	addiw	a0,a4,1
 3d8:	872a                	mv	a4,a0
 3da:	02c5f7bb          	remuw	a5,a1,a2
 3de:	1782                	slli	a5,a5,0x20
 3e0:	9381                	srli	a5,a5,0x20
 3e2:	97c2                	add	a5,a5,a6
 3e4:	0007c783          	lbu	a5,0(a5)
 3e8:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3ec:	87ae                	mv	a5,a1
 3ee:	02c5d5bb          	divuw	a1,a1,a2
 3f2:	0685                	addi	a3,a3,1
 3f4:	fcc7ffe3          	bgeu	a5,a2,3d2 <printint+0x2c>
  if(neg)
 3f8:	00030c63          	beqz	t1,410 <printint+0x6a>
    buf[i++] = '-';
 3fc:	fd050793          	addi	a5,a0,-48
 400:	00878533          	add	a0,a5,s0
 404:	02d00793          	li	a5,45
 408:	fef50823          	sb	a5,-16(a0)
 40c:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 410:	02e05563          	blez	a4,43a <printint+0x94>
 414:	f426                	sd	s1,40(sp)
 416:	377d                	addiw	a4,a4,-1
 418:	00e984b3          	add	s1,s3,a4
 41c:	19fd                	addi	s3,s3,-1
 41e:	99ba                	add	s3,s3,a4
 420:	1702                	slli	a4,a4,0x20
 422:	9301                	srli	a4,a4,0x20
 424:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 428:	0004c583          	lbu	a1,0(s1)
 42c:	854a                	mv	a0,s2
 42e:	f5bff0ef          	jal	388 <putc>
  while(--i >= 0)
 432:	14fd                	addi	s1,s1,-1
 434:	ff349ae3          	bne	s1,s3,428 <printint+0x82>
 438:	74a2                	ld	s1,40(sp)
}
 43a:	70e2                	ld	ra,56(sp)
 43c:	7442                	ld	s0,48(sp)
 43e:	7902                	ld	s2,32(sp)
 440:	69e2                	ld	s3,24(sp)
 442:	6121                	addi	sp,sp,64
 444:	8082                	ret
  neg = 0;
 446:	4301                	li	t1,0
 448:	bfad                	j	3c2 <printint+0x1c>

000000000000044a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 44a:	711d                	addi	sp,sp,-96
 44c:	ec86                	sd	ra,88(sp)
 44e:	e8a2                	sd	s0,80(sp)
 450:	e4a6                	sd	s1,72(sp)
 452:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 454:	0005c483          	lbu	s1,0(a1)
 458:	20048963          	beqz	s1,66a <vprintf+0x220>
 45c:	e0ca                	sd	s2,64(sp)
 45e:	fc4e                	sd	s3,56(sp)
 460:	f852                	sd	s4,48(sp)
 462:	f456                	sd	s5,40(sp)
 464:	f05a                	sd	s6,32(sp)
 466:	ec5e                	sd	s7,24(sp)
 468:	e862                	sd	s8,16(sp)
 46a:	8b2a                	mv	s6,a0
 46c:	8a2e                	mv	s4,a1
 46e:	8bb2                	mv	s7,a2
  state = 0;
 470:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 472:	4901                	li	s2,0
 474:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 476:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 47a:	06400c13          	li	s8,100
 47e:	a00d                	j	4a0 <vprintf+0x56>
        putc(fd, c0);
 480:	85a6                	mv	a1,s1
 482:	855a                	mv	a0,s6
 484:	f05ff0ef          	jal	388 <putc>
 488:	a019                	j	48e <vprintf+0x44>
    } else if(state == '%'){
 48a:	03598363          	beq	s3,s5,4b0 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 48e:	0019079b          	addiw	a5,s2,1
 492:	893e                	mv	s2,a5
 494:	873e                	mv	a4,a5
 496:	97d2                	add	a5,a5,s4
 498:	0007c483          	lbu	s1,0(a5)
 49c:	1c048063          	beqz	s1,65c <vprintf+0x212>
    c0 = fmt[i] & 0xff;
 4a0:	0004879b          	sext.w	a5,s1
    if(state == 0){
 4a4:	fe0993e3          	bnez	s3,48a <vprintf+0x40>
      if(c0 == '%'){
 4a8:	fd579ce3          	bne	a5,s5,480 <vprintf+0x36>
        state = '%';
 4ac:	89be                	mv	s3,a5
 4ae:	b7c5                	j	48e <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 4b0:	00ea06b3          	add	a3,s4,a4
 4b4:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 4b8:	1a060e63          	beqz	a2,674 <vprintf+0x22a>
      if(c0 == 'd'){
 4bc:	03878763          	beq	a5,s8,4ea <vprintf+0xa0>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4c0:	f9478693          	addi	a3,a5,-108
 4c4:	0016b693          	seqz	a3,a3
 4c8:	f9c60593          	addi	a1,a2,-100
 4cc:	e99d                	bnez	a1,502 <vprintf+0xb8>
 4ce:	ca95                	beqz	a3,502 <vprintf+0xb8>
        printint(fd, va_arg(ap, uint64), 10, 1);
 4d0:	008b8493          	addi	s1,s7,8
 4d4:	4685                	li	a3,1
 4d6:	4629                	li	a2,10
 4d8:	000ba583          	lw	a1,0(s7)
 4dc:	855a                	mv	a0,s6
 4de:	ec9ff0ef          	jal	3a6 <printint>
        i += 1;
 4e2:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 4e4:	8ba6                	mv	s7,s1
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 4e6:	4981                	li	s3,0
 4e8:	b75d                	j	48e <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 4ea:	008b8493          	addi	s1,s7,8
 4ee:	4685                	li	a3,1
 4f0:	4629                	li	a2,10
 4f2:	000ba583          	lw	a1,0(s7)
 4f6:	855a                	mv	a0,s6
 4f8:	eafff0ef          	jal	3a6 <printint>
 4fc:	8ba6                	mv	s7,s1
      state = 0;
 4fe:	4981                	li	s3,0
 500:	b779                	j	48e <vprintf+0x44>
      if(c1) c2 = fmt[i+2] & 0xff;
 502:	9752                	add	a4,a4,s4
 504:	00274583          	lbu	a1,2(a4)
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 508:	f9460713          	addi	a4,a2,-108
 50c:	00173713          	seqz	a4,a4
 510:	8f75                	and	a4,a4,a3
 512:	f9c58513          	addi	a0,a1,-100
 516:	16051963          	bnez	a0,688 <vprintf+0x23e>
 51a:	16070763          	beqz	a4,688 <vprintf+0x23e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 51e:	008b8493          	addi	s1,s7,8
 522:	4685                	li	a3,1
 524:	4629                	li	a2,10
 526:	000ba583          	lw	a1,0(s7)
 52a:	855a                	mv	a0,s6
 52c:	e7bff0ef          	jal	3a6 <printint>
        i += 2;
 530:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 532:	8ba6                	mv	s7,s1
      state = 0;
 534:	4981                	li	s3,0
        i += 2;
 536:	bfa1                	j	48e <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 0);
 538:	008b8493          	addi	s1,s7,8
 53c:	4681                	li	a3,0
 53e:	4629                	li	a2,10
 540:	000ba583          	lw	a1,0(s7)
 544:	855a                	mv	a0,s6
 546:	e61ff0ef          	jal	3a6 <printint>
 54a:	8ba6                	mv	s7,s1
      state = 0;
 54c:	4981                	li	s3,0
 54e:	b781                	j	48e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 550:	008b8493          	addi	s1,s7,8
 554:	4681                	li	a3,0
 556:	4629                	li	a2,10
 558:	000ba583          	lw	a1,0(s7)
 55c:	855a                	mv	a0,s6
 55e:	e49ff0ef          	jal	3a6 <printint>
        i += 1;
 562:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 564:	8ba6                	mv	s7,s1
      state = 0;
 566:	4981                	li	s3,0
 568:	b71d                	j	48e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 56a:	008b8493          	addi	s1,s7,8
 56e:	4681                	li	a3,0
 570:	4629                	li	a2,10
 572:	000ba583          	lw	a1,0(s7)
 576:	855a                	mv	a0,s6
 578:	e2fff0ef          	jal	3a6 <printint>
        i += 2;
 57c:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 57e:	8ba6                	mv	s7,s1
      state = 0;
 580:	4981                	li	s3,0
        i += 2;
 582:	b731                	j	48e <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 584:	008b8493          	addi	s1,s7,8
 588:	4681                	li	a3,0
 58a:	4641                	li	a2,16
 58c:	000ba583          	lw	a1,0(s7)
 590:	855a                	mv	a0,s6
 592:	e15ff0ef          	jal	3a6 <printint>
 596:	8ba6                	mv	s7,s1
      state = 0;
 598:	4981                	li	s3,0
 59a:	bdd5                	j	48e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 59c:	008b8493          	addi	s1,s7,8
 5a0:	4681                	li	a3,0
 5a2:	4641                	li	a2,16
 5a4:	000ba583          	lw	a1,0(s7)
 5a8:	855a                	mv	a0,s6
 5aa:	dfdff0ef          	jal	3a6 <printint>
        i += 1;
 5ae:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 5b0:	8ba6                	mv	s7,s1
      state = 0;
 5b2:	4981                	li	s3,0
 5b4:	bde9                	j	48e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5b6:	008b8493          	addi	s1,s7,8
 5ba:	4681                	li	a3,0
 5bc:	4641                	li	a2,16
 5be:	000ba583          	lw	a1,0(s7)
 5c2:	855a                	mv	a0,s6
 5c4:	de3ff0ef          	jal	3a6 <printint>
        i += 2;
 5c8:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 5ca:	8ba6                	mv	s7,s1
      state = 0;
 5cc:	4981                	li	s3,0
        i += 2;
 5ce:	b5c1                	j	48e <vprintf+0x44>
 5d0:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 5d2:	008b8793          	addi	a5,s7,8
 5d6:	8cbe                	mv	s9,a5
 5d8:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5dc:	03000593          	li	a1,48
 5e0:	855a                	mv	a0,s6
 5e2:	da7ff0ef          	jal	388 <putc>
  putc(fd, 'x');
 5e6:	07800593          	li	a1,120
 5ea:	855a                	mv	a0,s6
 5ec:	d9dff0ef          	jal	388 <putc>
 5f0:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5f2:	00000b97          	auipc	s7,0x0
 5f6:	2feb8b93          	addi	s7,s7,766 # 8f0 <digits>
 5fa:	03c9d793          	srli	a5,s3,0x3c
 5fe:	97de                	add	a5,a5,s7
 600:	0007c583          	lbu	a1,0(a5)
 604:	855a                	mv	a0,s6
 606:	d83ff0ef          	jal	388 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 60a:	0992                	slli	s3,s3,0x4
 60c:	34fd                	addiw	s1,s1,-1
 60e:	f4f5                	bnez	s1,5fa <vprintf+0x1b0>
        printptr(fd, va_arg(ap, uint64));
 610:	8be6                	mv	s7,s9
      state = 0;
 612:	4981                	li	s3,0
 614:	6ca2                	ld	s9,8(sp)
 616:	bda5                	j	48e <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 618:	008b8993          	addi	s3,s7,8
 61c:	000bb483          	ld	s1,0(s7)
 620:	cc91                	beqz	s1,63c <vprintf+0x1f2>
        for(; *s; s++)
 622:	0004c583          	lbu	a1,0(s1)
 626:	c985                	beqz	a1,656 <vprintf+0x20c>
          putc(fd, *s);
 628:	855a                	mv	a0,s6
 62a:	d5fff0ef          	jal	388 <putc>
        for(; *s; s++)
 62e:	0485                	addi	s1,s1,1
 630:	0004c583          	lbu	a1,0(s1)
 634:	f9f5                	bnez	a1,628 <vprintf+0x1de>
        if((s = va_arg(ap, char*)) == 0)
 636:	8bce                	mv	s7,s3
      state = 0;
 638:	4981                	li	s3,0
 63a:	bd91                	j	48e <vprintf+0x44>
          s = "(null)";
 63c:	00000497          	auipc	s1,0x0
 640:	2ac48493          	addi	s1,s1,684 # 8e8 <malloc+0x118>
        for(; *s; s++)
 644:	02800593          	li	a1,40
 648:	b7c5                	j	628 <vprintf+0x1de>
        putc(fd, '%');
 64a:	85be                	mv	a1,a5
 64c:	855a                	mv	a0,s6
 64e:	d3bff0ef          	jal	388 <putc>
      state = 0;
 652:	4981                	li	s3,0
 654:	bd2d                	j	48e <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 656:	8bce                	mv	s7,s3
      state = 0;
 658:	4981                	li	s3,0
 65a:	bd15                	j	48e <vprintf+0x44>
 65c:	6906                	ld	s2,64(sp)
 65e:	79e2                	ld	s3,56(sp)
 660:	7a42                	ld	s4,48(sp)
 662:	7aa2                	ld	s5,40(sp)
 664:	7b02                	ld	s6,32(sp)
 666:	6be2                	ld	s7,24(sp)
 668:	6c42                	ld	s8,16(sp)
    }
  }
}
 66a:	60e6                	ld	ra,88(sp)
 66c:	6446                	ld	s0,80(sp)
 66e:	64a6                	ld	s1,72(sp)
 670:	6125                	addi	sp,sp,96
 672:	8082                	ret
      if(c0 == 'd'){
 674:	06400713          	li	a4,100
 678:	e6e789e3          	beq	a5,a4,4ea <vprintf+0xa0>
      } else if(c0 == 'l' && c1 == 'd'){
 67c:	f9478693          	addi	a3,a5,-108
 680:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 684:	85b2                	mv	a1,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 686:	4701                	li	a4,0
      } else if(c0 == 'u'){
 688:	07500513          	li	a0,117
 68c:	eaa786e3          	beq	a5,a0,538 <vprintf+0xee>
      } else if(c0 == 'l' && c1 == 'u'){
 690:	f8b60513          	addi	a0,a2,-117
 694:	e119                	bnez	a0,69a <vprintf+0x250>
 696:	ea069de3          	bnez	a3,550 <vprintf+0x106>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 69a:	f8b58513          	addi	a0,a1,-117
 69e:	e119                	bnez	a0,6a4 <vprintf+0x25a>
 6a0:	ec0715e3          	bnez	a4,56a <vprintf+0x120>
      } else if(c0 == 'x'){
 6a4:	07800513          	li	a0,120
 6a8:	eca78ee3          	beq	a5,a0,584 <vprintf+0x13a>
      } else if(c0 == 'l' && c1 == 'x'){
 6ac:	f8860613          	addi	a2,a2,-120
 6b0:	e219                	bnez	a2,6b6 <vprintf+0x26c>
 6b2:	ee0695e3          	bnez	a3,59c <vprintf+0x152>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6b6:	f8858593          	addi	a1,a1,-120
 6ba:	e199                	bnez	a1,6c0 <vprintf+0x276>
 6bc:	ee071de3          	bnez	a4,5b6 <vprintf+0x16c>
      } else if(c0 == 'p'){
 6c0:	07000713          	li	a4,112
 6c4:	f0e786e3          	beq	a5,a4,5d0 <vprintf+0x186>
      } else if(c0 == 's'){
 6c8:	07300713          	li	a4,115
 6cc:	f4e786e3          	beq	a5,a4,618 <vprintf+0x1ce>
      } else if(c0 == '%'){
 6d0:	02500713          	li	a4,37
 6d4:	f6e78be3          	beq	a5,a4,64a <vprintf+0x200>
        putc(fd, '%');
 6d8:	02500593          	li	a1,37
 6dc:	855a                	mv	a0,s6
 6de:	cabff0ef          	jal	388 <putc>
        putc(fd, c0);
 6e2:	85a6                	mv	a1,s1
 6e4:	855a                	mv	a0,s6
 6e6:	ca3ff0ef          	jal	388 <putc>
      state = 0;
 6ea:	4981                	li	s3,0
 6ec:	b34d                	j	48e <vprintf+0x44>

00000000000006ee <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6ee:	715d                	addi	sp,sp,-80
 6f0:	ec06                	sd	ra,24(sp)
 6f2:	e822                	sd	s0,16(sp)
 6f4:	1000                	addi	s0,sp,32
 6f6:	e010                	sd	a2,0(s0)
 6f8:	e414                	sd	a3,8(s0)
 6fa:	e818                	sd	a4,16(s0)
 6fc:	ec1c                	sd	a5,24(s0)
 6fe:	03043023          	sd	a6,32(s0)
 702:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 706:	8622                	mv	a2,s0
 708:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 70c:	d3fff0ef          	jal	44a <vprintf>
}
 710:	60e2                	ld	ra,24(sp)
 712:	6442                	ld	s0,16(sp)
 714:	6161                	addi	sp,sp,80
 716:	8082                	ret

0000000000000718 <printf>:

void
printf(const char *fmt, ...)
{
 718:	711d                	addi	sp,sp,-96
 71a:	ec06                	sd	ra,24(sp)
 71c:	e822                	sd	s0,16(sp)
 71e:	1000                	addi	s0,sp,32
 720:	e40c                	sd	a1,8(s0)
 722:	e810                	sd	a2,16(s0)
 724:	ec14                	sd	a3,24(s0)
 726:	f018                	sd	a4,32(s0)
 728:	f41c                	sd	a5,40(s0)
 72a:	03043823          	sd	a6,48(s0)
 72e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 732:	00840613          	addi	a2,s0,8
 736:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 73a:	85aa                	mv	a1,a0
 73c:	4505                	li	a0,1
 73e:	d0dff0ef          	jal	44a <vprintf>
}
 742:	60e2                	ld	ra,24(sp)
 744:	6442                	ld	s0,16(sp)
 746:	6125                	addi	sp,sp,96
 748:	8082                	ret

000000000000074a <free>:
static Header base;
static Header *freep;

void
free (void *ap)
{
 74a:	1141                	addi	sp,sp,-16
 74c:	e406                	sd	ra,8(sp)
 74e:	e022                	sd	s0,0(sp)
 750:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 752:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 756:	00001797          	auipc	a5,0x1
 75a:	8aa7b783          	ld	a5,-1878(a5) # 1000 <freep>
 75e:	a039                	j	76c <free+0x22>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 760:	6398                	ld	a4,0(a5)
 762:	00e7e463          	bltu	a5,a4,76a <free+0x20>
 766:	00e6ea63          	bltu	a3,a4,77a <free+0x30>
{
 76a:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76c:	fed7fae3          	bgeu	a5,a3,760 <free+0x16>
 770:	6398                	ld	a4,0(a5)
 772:	00e6e463          	bltu	a3,a4,77a <free+0x30>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 776:	fee7eae3          	bltu	a5,a4,76a <free+0x20>
      break;
  if (bp + bp->s.size == p->s.ptr)
 77a:	ff852583          	lw	a1,-8(a0)
 77e:	6390                	ld	a2,0(a5)
 780:	02059813          	slli	a6,a1,0x20
 784:	01c85713          	srli	a4,a6,0x1c
 788:	9736                	add	a4,a4,a3
 78a:	02e60563          	beq	a2,a4,7b4 <free+0x6a>
    {
      bp->s.size += p->s.ptr->s.size;
      bp->s.ptr = p->s.ptr->s.ptr;
 78e:	fec53823          	sd	a2,-16(a0)
    }
  else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp)
 792:	4790                	lw	a2,8(a5)
 794:	02061593          	slli	a1,a2,0x20
 798:	01c5d713          	srli	a4,a1,0x1c
 79c:	973e                	add	a4,a4,a5
 79e:	02e68263          	beq	a3,a4,7c2 <free+0x78>
    {
      p->s.size += bp->s.size;
      p->s.ptr = bp->s.ptr;
 7a2:	e394                	sd	a3,0(a5)
    }
  else
    p->s.ptr = bp;
  freep = p;
 7a4:	00001717          	auipc	a4,0x1
 7a8:	84f73e23          	sd	a5,-1956(a4) # 1000 <freep>
}
 7ac:	60a2                	ld	ra,8(sp)
 7ae:	6402                	ld	s0,0(sp)
 7b0:	0141                	addi	sp,sp,16
 7b2:	8082                	ret
      bp->s.size += p->s.ptr->s.size;
 7b4:	4618                	lw	a4,8(a2)
 7b6:	9f2d                	addw	a4,a4,a1
 7b8:	fee52c23          	sw	a4,-8(a0)
      bp->s.ptr = p->s.ptr->s.ptr;
 7bc:	6398                	ld	a4,0(a5)
 7be:	6310                	ld	a2,0(a4)
 7c0:	b7f9                	j	78e <free+0x44>
      p->s.size += bp->s.size;
 7c2:	ff852703          	lw	a4,-8(a0)
 7c6:	9f31                	addw	a4,a4,a2
 7c8:	c798                	sw	a4,8(a5)
      p->s.ptr = bp->s.ptr;
 7ca:	ff053683          	ld	a3,-16(a0)
 7ce:	bfd1                	j	7a2 <free+0x58>

00000000000007d0 <malloc>:
  return freep;
}

void *
malloc (uint nbytes)
{
 7d0:	7139                	addi	sp,sp,-64
 7d2:	fc06                	sd	ra,56(sp)
 7d4:	f822                	sd	s0,48(sp)
 7d6:	f04a                	sd	s2,32(sp)
 7d8:	ec4e                	sd	s3,24(sp)
 7da:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof (Header) - 1) / sizeof (Header) + 1;
 7dc:	02051993          	slli	s3,a0,0x20
 7e0:	0209d993          	srli	s3,s3,0x20
 7e4:	09bd                	addi	s3,s3,15
 7e6:	0049d993          	srli	s3,s3,0x4
 7ea:	2985                	addiw	s3,s3,1
 7ec:	894e                	mv	s2,s3
  if ((prevp = freep) == 0)
 7ee:	00001517          	auipc	a0,0x1
 7f2:	81253503          	ld	a0,-2030(a0) # 1000 <freep>
 7f6:	c905                	beqz	a0,826 <malloc+0x56>
    {
      base.s.ptr = freep = prevp = &base;
      base.s.size = 0;
    }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 7f8:	611c                	ld	a5,0(a0)
    {
      if (p->s.size >= nunits)
 7fa:	4798                	lw	a4,8(a5)
 7fc:	09377663          	bgeu	a4,s3,888 <malloc+0xb8>
 800:	f426                	sd	s1,40(sp)
 802:	e852                	sd	s4,16(sp)
 804:	e456                	sd	s5,8(sp)
 806:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 808:	8a4e                	mv	s4,s3
 80a:	6705                	lui	a4,0x1
 80c:	00e9f363          	bgeu	s3,a4,812 <malloc+0x42>
 810:	6a05                	lui	s4,0x1
 812:	000a0b1b          	sext.w	s6,s4
  p = sbrk (nu * sizeof (Header));
 816:	004a1a1b          	slliw	s4,s4,0x4
              p->s.size = nunits;
            }
          freep = prevp;
          return (void *)(p + 1);
        }
      if (p == freep)
 81a:	00000497          	auipc	s1,0x0
 81e:	7e648493          	addi	s1,s1,2022 # 1000 <freep>
  if (p == (char *)-1)
 822:	5afd                	li	s5,-1
 824:	a83d                	j	862 <malloc+0x92>
 826:	f426                	sd	s1,40(sp)
 828:	e852                	sd	s4,16(sp)
 82a:	e456                	sd	s5,8(sp)
 82c:	e05a                	sd	s6,0(sp)
      base.s.ptr = freep = prevp = &base;
 82e:	00000797          	auipc	a5,0x0
 832:	7e278793          	addi	a5,a5,2018 # 1010 <base>
 836:	00000717          	auipc	a4,0x0
 83a:	7cf73523          	sd	a5,1994(a4) # 1000 <freep>
 83e:	e39c                	sd	a5,0(a5)
      base.s.size = 0;
 840:	0007a423          	sw	zero,8(a5)
      if (p->s.size >= nunits)
 844:	b7d1                	j	808 <malloc+0x38>
            prevp->s.ptr = p->s.ptr;
 846:	6398                	ld	a4,0(a5)
 848:	e118                	sd	a4,0(a0)
 84a:	a899                	j	8a0 <malloc+0xd0>
  hp->s.size = nu;
 84c:	01652423          	sw	s6,8(a0)
  free ((void *)(hp + 1));
 850:	0541                	addi	a0,a0,16
 852:	ef9ff0ef          	jal	74a <free>
  return freep;
 856:	6088                	ld	a0,0(s1)
        if ((p = morecore (nunits)) == 0)
 858:	c125                	beqz	a0,8b8 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 85a:	611c                	ld	a5,0(a0)
      if (p->s.size >= nunits)
 85c:	4798                	lw	a4,8(a5)
 85e:	03277163          	bgeu	a4,s2,880 <malloc+0xb0>
      if (p == freep)
 862:	6098                	ld	a4,0(s1)
 864:	853e                	mv	a0,a5
 866:	fef71ae3          	bne	a4,a5,85a <malloc+0x8a>
  p = sbrk (nu * sizeof (Header));
 86a:	8552                	mv	a0,s4
 86c:	afdff0ef          	jal	368 <sbrk>
  if (p == (char *)-1)
 870:	fd551ee3          	bne	a0,s5,84c <malloc+0x7c>
          return 0;
 874:	4501                	li	a0,0
 876:	74a2                	ld	s1,40(sp)
 878:	6a42                	ld	s4,16(sp)
 87a:	6aa2                	ld	s5,8(sp)
 87c:	6b02                	ld	s6,0(sp)
 87e:	a03d                	j	8ac <malloc+0xdc>
 880:	74a2                	ld	s1,40(sp)
 882:	6a42                	ld	s4,16(sp)
 884:	6aa2                	ld	s5,8(sp)
 886:	6b02                	ld	s6,0(sp)
          if (p->s.size == nunits)
 888:	fae90fe3          	beq	s2,a4,846 <malloc+0x76>
              p->s.size -= nunits;
 88c:	4137073b          	subw	a4,a4,s3
 890:	c798                	sw	a4,8(a5)
              p += p->s.size;
 892:	02071693          	slli	a3,a4,0x20
 896:	01c6d713          	srli	a4,a3,0x1c
 89a:	97ba                	add	a5,a5,a4
              p->s.size = nunits;
 89c:	0137a423          	sw	s3,8(a5)
          freep = prevp;
 8a0:	00000717          	auipc	a4,0x0
 8a4:	76a73023          	sd	a0,1888(a4) # 1000 <freep>
          return (void *)(p + 1);
 8a8:	01078513          	addi	a0,a5,16
    }
}
 8ac:	70e2                	ld	ra,56(sp)
 8ae:	7442                	ld	s0,48(sp)
 8b0:	7902                	ld	s2,32(sp)
 8b2:	69e2                	ld	s3,24(sp)
 8b4:	6121                	addi	sp,sp,64
 8b6:	8082                	ret
 8b8:	74a2                	ld	s1,40(sp)
 8ba:	6a42                	ld	s4,16(sp)
 8bc:	6aa2                	ld	s5,8(sp)
 8be:	6b02                	ld	s6,0(sp)
 8c0:	b7f5                	j	8ac <malloc+0xdc>
