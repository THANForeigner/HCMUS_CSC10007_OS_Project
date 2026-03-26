
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  if(argc != 3){
   8:	478d                	li	a5,3
   a:	00f50d63          	beq	a0,a5,24 <main+0x24>
   e:	e426                	sd	s1,8(sp)
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	8b058593          	addi	a1,a1,-1872 # 8c0 <malloc+0xf6>
  18:	4509                	li	a0,2
  1a:	6ce000ef          	jal	6e8 <fprintf>
    exit(1);
  1e:	4505                	li	a0,1
  20:	2ba000ef          	jal	2da <exit>
  24:	e426                	sd	s1,8(sp)
  26:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  28:	698c                	ld	a1,16(a1)
  2a:	6488                	ld	a0,8(s1)
  2c:	30e000ef          	jal	33a <link>
  30:	00054563          	bltz	a0,3a <main+0x3a>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  34:	4501                	li	a0,0
  36:	2a4000ef          	jal	2da <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  3a:	6894                	ld	a3,16(s1)
  3c:	6490                	ld	a2,8(s1)
  3e:	00001597          	auipc	a1,0x1
  42:	89a58593          	addi	a1,a1,-1894 # 8d8 <malloc+0x10e>
  46:	4509                	li	a0,2
  48:	6a0000ef          	jal	6e8 <fprintf>
  4c:	b7e5                	j	34 <main+0x34>

000000000000004e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start ()
{
  4e:	1141                	addi	sp,sp,-16
  50:	e406                	sd	ra,8(sp)
  52:	e022                	sd	s0,0(sp)
  54:	0800                	addi	s0,sp,16
  extern int main ();
  main ();
  56:	fabff0ef          	jal	0 <main>
  exit (0);
  5a:	4501                	li	a0,0
  5c:	27e000ef          	jal	2da <exit>

0000000000000060 <strcpy>:
}

char *
strcpy (char *s, const char *t)
{
  60:	1141                	addi	sp,sp,-16
  62:	e406                	sd	ra,8(sp)
  64:	e022                	sd	s0,0(sp)
  66:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  68:	87aa                	mv	a5,a0
  6a:	0585                	addi	a1,a1,1
  6c:	0785                	addi	a5,a5,1
  6e:	fff5c703          	lbu	a4,-1(a1)
  72:	fee78fa3          	sb	a4,-1(a5)
  76:	fb75                	bnez	a4,6a <strcpy+0xa>
    ;
  return os;
}
  78:	60a2                	ld	ra,8(sp)
  7a:	6402                	ld	s0,0(sp)
  7c:	0141                	addi	sp,sp,16
  7e:	8082                	ret

0000000000000080 <strcmp>:

int
strcmp (const char *p, const char *q)
{
  80:	1141                	addi	sp,sp,-16
  82:	e406                	sd	ra,8(sp)
  84:	e022                	sd	s0,0(sp)
  86:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  88:	00054783          	lbu	a5,0(a0)
  8c:	cb91                	beqz	a5,a0 <strcmp+0x20>
  8e:	0005c703          	lbu	a4,0(a1)
  92:	00f71763          	bne	a4,a5,a0 <strcmp+0x20>
    p++, q++;
  96:	0505                	addi	a0,a0,1
  98:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  9a:	00054783          	lbu	a5,0(a0)
  9e:	fbe5                	bnez	a5,8e <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  a0:	0005c503          	lbu	a0,0(a1)
}
  a4:	40a7853b          	subw	a0,a5,a0
  a8:	60a2                	ld	ra,8(sp)
  aa:	6402                	ld	s0,0(sp)
  ac:	0141                	addi	sp,sp,16
  ae:	8082                	ret

00000000000000b0 <strlen>:

uint
strlen (const char *s)
{
  b0:	1141                	addi	sp,sp,-16
  b2:	e406                	sd	ra,8(sp)
  b4:	e022                	sd	s0,0(sp)
  b6:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  b8:	00054783          	lbu	a5,0(a0)
  bc:	cf91                	beqz	a5,d8 <strlen+0x28>
  be:	00150793          	addi	a5,a0,1
  c2:	86be                	mv	a3,a5
  c4:	0785                	addi	a5,a5,1
  c6:	fff7c703          	lbu	a4,-1(a5)
  ca:	ff65                	bnez	a4,c2 <strlen+0x12>
  cc:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  d0:	60a2                	ld	ra,8(sp)
  d2:	6402                	ld	s0,0(sp)
  d4:	0141                	addi	sp,sp,16
  d6:	8082                	ret
  for (n = 0; s[n]; n++)
  d8:	4501                	li	a0,0
  da:	bfdd                	j	d0 <strlen+0x20>

00000000000000dc <memset>:

void *
memset (void *dst, int c, uint n)
{
  dc:	1141                	addi	sp,sp,-16
  de:	e406                	sd	ra,8(sp)
  e0:	e022                	sd	s0,0(sp)
  e2:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
  e4:	ca19                	beqz	a2,fa <memset+0x1e>
  e6:	87aa                	mv	a5,a0
  e8:	1602                	slli	a2,a2,0x20
  ea:	9201                	srli	a2,a2,0x20
  ec:	00a60733          	add	a4,a2,a0
    {
      cdst[i] = c;
  f0:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
  f4:	0785                	addi	a5,a5,1
  f6:	fee79de3          	bne	a5,a4,f0 <memset+0x14>
    }
  return dst;
}
  fa:	60a2                	ld	ra,8(sp)
  fc:	6402                	ld	s0,0(sp)
  fe:	0141                	addi	sp,sp,16
 100:	8082                	ret

0000000000000102 <strchr>:

char *
strchr (const char *s, char c)
{
 102:	1141                	addi	sp,sp,-16
 104:	e406                	sd	ra,8(sp)
 106:	e022                	sd	s0,0(sp)
 108:	0800                	addi	s0,sp,16
  for (; *s; s++)
 10a:	00054783          	lbu	a5,0(a0)
 10e:	cf81                	beqz	a5,126 <strchr+0x24>
    if (*s == c)
 110:	00f58763          	beq	a1,a5,11e <strchr+0x1c>
  for (; *s; s++)
 114:	0505                	addi	a0,a0,1
 116:	00054783          	lbu	a5,0(a0)
 11a:	fbfd                	bnez	a5,110 <strchr+0xe>
      return (char *)s;
  return 0;
 11c:	4501                	li	a0,0
}
 11e:	60a2                	ld	ra,8(sp)
 120:	6402                	ld	s0,0(sp)
 122:	0141                	addi	sp,sp,16
 124:	8082                	ret
  return 0;
 126:	4501                	li	a0,0
 128:	bfdd                	j	11e <strchr+0x1c>

000000000000012a <gets>:

char *
gets (char *buf, int max)
{
 12a:	711d                	addi	sp,sp,-96
 12c:	ec86                	sd	ra,88(sp)
 12e:	e8a2                	sd	s0,80(sp)
 130:	e4a6                	sd	s1,72(sp)
 132:	e0ca                	sd	s2,64(sp)
 134:	fc4e                	sd	s3,56(sp)
 136:	f852                	sd	s4,48(sp)
 138:	f456                	sd	s5,40(sp)
 13a:	f05a                	sd	s6,32(sp)
 13c:	ec5e                	sd	s7,24(sp)
 13e:	e862                	sd	s8,16(sp)
 140:	1080                	addi	s0,sp,96
 142:	8baa                	mv	s7,a0
 144:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 146:	892a                	mv	s2,a0
 148:	4481                	li	s1,0
    {
      cc = read (0, &c, 1);
 14a:	faf40b13          	addi	s6,s0,-81
 14e:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;)
 150:	8c26                	mv	s8,s1
 152:	0014899b          	addiw	s3,s1,1
 156:	84ce                	mv	s1,s3
 158:	0349d463          	bge	s3,s4,180 <gets+0x56>
      cc = read (0, &c, 1);
 15c:	8656                	mv	a2,s5
 15e:	85da                	mv	a1,s6
 160:	4501                	li	a0,0
 162:	190000ef          	jal	2f2 <read>
      if (cc < 1)
 166:	00a05d63          	blez	a0,180 <gets+0x56>
        break;
      buf[i++] = c;
 16a:	faf44783          	lbu	a5,-81(s0)
 16e:	00f90023          	sb	a5,0(s2)
      if (c == '\n' || c == '\r')
 172:	0905                	addi	s2,s2,1
 174:	ff678713          	addi	a4,a5,-10
 178:	c319                	beqz	a4,17e <gets+0x54>
 17a:	17cd                	addi	a5,a5,-13
 17c:	fbf1                	bnez	a5,150 <gets+0x26>
      buf[i++] = c;
 17e:	8c4e                	mv	s8,s3
        break;
    }
  buf[i] = '\0';
 180:	9c5e                	add	s8,s8,s7
 182:	000c0023          	sb	zero,0(s8)
  return buf;
}
 186:	855e                	mv	a0,s7
 188:	60e6                	ld	ra,88(sp)
 18a:	6446                	ld	s0,80(sp)
 18c:	64a6                	ld	s1,72(sp)
 18e:	6906                	ld	s2,64(sp)
 190:	79e2                	ld	s3,56(sp)
 192:	7a42                	ld	s4,48(sp)
 194:	7aa2                	ld	s5,40(sp)
 196:	7b02                	ld	s6,32(sp)
 198:	6be2                	ld	s7,24(sp)
 19a:	6c42                	ld	s8,16(sp)
 19c:	6125                	addi	sp,sp,96
 19e:	8082                	ret

00000000000001a0 <stat>:

int
stat (const char *n, struct stat *st)
{
 1a0:	1101                	addi	sp,sp,-32
 1a2:	ec06                	sd	ra,24(sp)
 1a4:	e822                	sd	s0,16(sp)
 1a6:	e04a                	sd	s2,0(sp)
 1a8:	1000                	addi	s0,sp,32
 1aa:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open (n, O_RDONLY);
 1ac:	4581                	li	a1,0
 1ae:	16c000ef          	jal	31a <open>
  if (fd < 0)
 1b2:	02054263          	bltz	a0,1d6 <stat+0x36>
 1b6:	e426                	sd	s1,8(sp)
 1b8:	84aa                	mv	s1,a0
    return -1;
  r = fstat (fd, st);
 1ba:	85ca                	mv	a1,s2
 1bc:	176000ef          	jal	332 <fstat>
 1c0:	892a                	mv	s2,a0
  close (fd);
 1c2:	8526                	mv	a0,s1
 1c4:	13e000ef          	jal	302 <close>
  return r;
 1c8:	64a2                	ld	s1,8(sp)
}
 1ca:	854a                	mv	a0,s2
 1cc:	60e2                	ld	ra,24(sp)
 1ce:	6442                	ld	s0,16(sp)
 1d0:	6902                	ld	s2,0(sp)
 1d2:	6105                	addi	sp,sp,32
 1d4:	8082                	ret
    return -1;
 1d6:	57fd                	li	a5,-1
 1d8:	893e                	mv	s2,a5
 1da:	bfc5                	j	1ca <stat+0x2a>

00000000000001dc <atoi>:

int
atoi (const char *s)
{
 1dc:	1141                	addi	sp,sp,-16
 1de:	e406                	sd	ra,8(sp)
 1e0:	e022                	sd	s0,0(sp)
 1e2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 1e4:	00054683          	lbu	a3,0(a0)
 1e8:	fd06879b          	addiw	a5,a3,-48
 1ec:	0ff7f793          	zext.b	a5,a5
 1f0:	4625                	li	a2,9
 1f2:	02f66963          	bltu	a2,a5,224 <atoi+0x48>
 1f6:	872a                	mv	a4,a0
  n = 0;
 1f8:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 1fa:	0705                	addi	a4,a4,1
 1fc:	0025179b          	slliw	a5,a0,0x2
 200:	9fa9                	addw	a5,a5,a0
 202:	0017979b          	slliw	a5,a5,0x1
 206:	9fb5                	addw	a5,a5,a3
 208:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 20c:	00074683          	lbu	a3,0(a4)
 210:	fd06879b          	addiw	a5,a3,-48
 214:	0ff7f793          	zext.b	a5,a5
 218:	fef671e3          	bgeu	a2,a5,1fa <atoi+0x1e>
  return n;
}
 21c:	60a2                	ld	ra,8(sp)
 21e:	6402                	ld	s0,0(sp)
 220:	0141                	addi	sp,sp,16
 222:	8082                	ret
  n = 0;
 224:	4501                	li	a0,0
 226:	bfdd                	j	21c <atoi+0x40>

0000000000000228 <memmove>:

void *
memmove (void *vdst, const void *vsrc, int n)
{
 228:	1141                	addi	sp,sp,-16
 22a:	e406                	sd	ra,8(sp)
 22c:	e022                	sd	s0,0(sp)
 22e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 230:	02b57563          	bgeu	a0,a1,25a <memmove+0x32>
    {
      while (n-- > 0)
 234:	00c05f63          	blez	a2,252 <memmove+0x2a>
 238:	1602                	slli	a2,a2,0x20
 23a:	9201                	srli	a2,a2,0x20
 23c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 240:	872a                	mv	a4,a0
        *dst++ = *src++;
 242:	0585                	addi	a1,a1,1
 244:	0705                	addi	a4,a4,1
 246:	fff5c683          	lbu	a3,-1(a1)
 24a:	fed70fa3          	sb	a3,-1(a4)
      while (n-- > 0)
 24e:	fee79ae3          	bne	a5,a4,242 <memmove+0x1a>
      src += n;
      while (n-- > 0)
        *--dst = *--src;
    }
  return vdst;
}
 252:	60a2                	ld	ra,8(sp)
 254:	6402                	ld	s0,0(sp)
 256:	0141                	addi	sp,sp,16
 258:	8082                	ret
      while (n-- > 0)
 25a:	fec05ce3          	blez	a2,252 <memmove+0x2a>
      dst += n;
 25e:	00c50733          	add	a4,a0,a2
      src += n;
 262:	95b2                	add	a1,a1,a2
 264:	fff6079b          	addiw	a5,a2,-1
 268:	1782                	slli	a5,a5,0x20
 26a:	9381                	srli	a5,a5,0x20
 26c:	fff7c793          	not	a5,a5
 270:	97ba                	add	a5,a5,a4
        *--dst = *--src;
 272:	15fd                	addi	a1,a1,-1
 274:	177d                	addi	a4,a4,-1
 276:	0005c683          	lbu	a3,0(a1)
 27a:	00d70023          	sb	a3,0(a4)
      while (n-- > 0)
 27e:	fef71ae3          	bne	a4,a5,272 <memmove+0x4a>
 282:	bfc1                	j	252 <memmove+0x2a>

0000000000000284 <memcmp>:

int
memcmp (const void *s1, const void *s2, uint n)
{
 284:	1141                	addi	sp,sp,-16
 286:	e406                	sd	ra,8(sp)
 288:	e022                	sd	s0,0(sp)
 28a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 28c:	c61d                	beqz	a2,2ba <memcmp+0x36>
 28e:	1602                	slli	a2,a2,0x20
 290:	9201                	srli	a2,a2,0x20
 292:	00c506b3          	add	a3,a0,a2
    {
      if (*p1 != *p2)
 296:	00054783          	lbu	a5,0(a0)
 29a:	0005c703          	lbu	a4,0(a1)
 29e:	00e79863          	bne	a5,a4,2ae <memcmp+0x2a>
        {
          return *p1 - *p2;
        }
      p1++;
 2a2:	0505                	addi	a0,a0,1
      p2++;
 2a4:	0585                	addi	a1,a1,1
  while (n-- > 0)
 2a6:	fed518e3          	bne	a0,a3,296 <memcmp+0x12>
    }
  return 0;
 2aa:	4501                	li	a0,0
 2ac:	a019                	j	2b2 <memcmp+0x2e>
          return *p1 - *p2;
 2ae:	40e7853b          	subw	a0,a5,a4
}
 2b2:	60a2                	ld	ra,8(sp)
 2b4:	6402                	ld	s0,0(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret
  return 0;
 2ba:	4501                	li	a0,0
 2bc:	bfdd                	j	2b2 <memcmp+0x2e>

00000000000002be <memcpy>:

void *
memcpy (void *dst, const void *src, uint n)
{
 2be:	1141                	addi	sp,sp,-16
 2c0:	e406                	sd	ra,8(sp)
 2c2:	e022                	sd	s0,0(sp)
 2c4:	0800                	addi	s0,sp,16
  return memmove (dst, src, n);
 2c6:	f63ff0ef          	jal	228 <memmove>
}
 2ca:	60a2                	ld	ra,8(sp)
 2cc:	6402                	ld	s0,0(sp)
 2ce:	0141                	addi	sp,sp,16
 2d0:	8082                	ret

00000000000002d2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2d2:	4885                	li	a7,1
 ecall
 2d4:	00000073          	ecall
 ret
 2d8:	8082                	ret

00000000000002da <exit>:
.global exit
exit:
 li a7, SYS_exit
 2da:	4889                	li	a7,2
 ecall
 2dc:	00000073          	ecall
 ret
 2e0:	8082                	ret

00000000000002e2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2e2:	488d                	li	a7,3
 ecall
 2e4:	00000073          	ecall
 ret
 2e8:	8082                	ret

00000000000002ea <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2ea:	4891                	li	a7,4
 ecall
 2ec:	00000073          	ecall
 ret
 2f0:	8082                	ret

00000000000002f2 <read>:
.global read
read:
 li a7, SYS_read
 2f2:	4895                	li	a7,5
 ecall
 2f4:	00000073          	ecall
 ret
 2f8:	8082                	ret

00000000000002fa <write>:
.global write
write:
 li a7, SYS_write
 2fa:	48c1                	li	a7,16
 ecall
 2fc:	00000073          	ecall
 ret
 300:	8082                	ret

0000000000000302 <close>:
.global close
close:
 li a7, SYS_close
 302:	48d5                	li	a7,21
 ecall
 304:	00000073          	ecall
 ret
 308:	8082                	ret

000000000000030a <kill>:
.global kill
kill:
 li a7, SYS_kill
 30a:	4899                	li	a7,6
 ecall
 30c:	00000073          	ecall
 ret
 310:	8082                	ret

0000000000000312 <exec>:
.global exec
exec:
 li a7, SYS_exec
 312:	489d                	li	a7,7
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <open>:
.global open
open:
 li a7, SYS_open
 31a:	48bd                	li	a7,15
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 322:	48c5                	li	a7,17
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 32a:	48c9                	li	a7,18
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 332:	48a1                	li	a7,8
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <link>:
.global link
link:
 li a7, SYS_link
 33a:	48cd                	li	a7,19
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 342:	48d1                	li	a7,20
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 34a:	48a5                	li	a7,9
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <dup>:
.global dup
dup:
 li a7, SYS_dup
 352:	48a9                	li	a7,10
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 35a:	48ad                	li	a7,11
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 362:	48b1                	li	a7,12
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 36a:	48b5                	li	a7,13
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 372:	48b9                	li	a7,14
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <trace>:
.global trace
trace:
 li a7, SYS_trace
 37a:	48d9                	li	a7,22
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 382:	1101                	addi	sp,sp,-32
 384:	ec06                	sd	ra,24(sp)
 386:	e822                	sd	s0,16(sp)
 388:	1000                	addi	s0,sp,32
 38a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 38e:	4605                	li	a2,1
 390:	fef40593          	addi	a1,s0,-17
 394:	f67ff0ef          	jal	2fa <write>
}
 398:	60e2                	ld	ra,24(sp)
 39a:	6442                	ld	s0,16(sp)
 39c:	6105                	addi	sp,sp,32
 39e:	8082                	ret

00000000000003a0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3a0:	7139                	addi	sp,sp,-64
 3a2:	fc06                	sd	ra,56(sp)
 3a4:	f822                	sd	s0,48(sp)
 3a6:	f04a                	sd	s2,32(sp)
 3a8:	ec4e                	sd	s3,24(sp)
 3aa:	0080                	addi	s0,sp,64
 3ac:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3ae:	cac9                	beqz	a3,440 <printint+0xa0>
 3b0:	01f5d79b          	srliw	a5,a1,0x1f
 3b4:	c7d1                	beqz	a5,440 <printint+0xa0>
    neg = 1;
    x = -xx;
 3b6:	40b005bb          	negw	a1,a1
    neg = 1;
 3ba:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 3bc:	fc040993          	addi	s3,s0,-64
  neg = 0;
 3c0:	86ce                	mv	a3,s3
  i = 0;
 3c2:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3c4:	00000817          	auipc	a6,0x0
 3c8:	53480813          	addi	a6,a6,1332 # 8f8 <digits>
 3cc:	88ba                	mv	a7,a4
 3ce:	0017051b          	addiw	a0,a4,1
 3d2:	872a                	mv	a4,a0
 3d4:	02c5f7bb          	remuw	a5,a1,a2
 3d8:	1782                	slli	a5,a5,0x20
 3da:	9381                	srli	a5,a5,0x20
 3dc:	97c2                	add	a5,a5,a6
 3de:	0007c783          	lbu	a5,0(a5)
 3e2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3e6:	87ae                	mv	a5,a1
 3e8:	02c5d5bb          	divuw	a1,a1,a2
 3ec:	0685                	addi	a3,a3,1
 3ee:	fcc7ffe3          	bgeu	a5,a2,3cc <printint+0x2c>
  if(neg)
 3f2:	00030c63          	beqz	t1,40a <printint+0x6a>
    buf[i++] = '-';
 3f6:	fd050793          	addi	a5,a0,-48
 3fa:	00878533          	add	a0,a5,s0
 3fe:	02d00793          	li	a5,45
 402:	fef50823          	sb	a5,-16(a0)
 406:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 40a:	02e05563          	blez	a4,434 <printint+0x94>
 40e:	f426                	sd	s1,40(sp)
 410:	377d                	addiw	a4,a4,-1
 412:	00e984b3          	add	s1,s3,a4
 416:	19fd                	addi	s3,s3,-1
 418:	99ba                	add	s3,s3,a4
 41a:	1702                	slli	a4,a4,0x20
 41c:	9301                	srli	a4,a4,0x20
 41e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 422:	0004c583          	lbu	a1,0(s1)
 426:	854a                	mv	a0,s2
 428:	f5bff0ef          	jal	382 <putc>
  while(--i >= 0)
 42c:	14fd                	addi	s1,s1,-1
 42e:	ff349ae3          	bne	s1,s3,422 <printint+0x82>
 432:	74a2                	ld	s1,40(sp)
}
 434:	70e2                	ld	ra,56(sp)
 436:	7442                	ld	s0,48(sp)
 438:	7902                	ld	s2,32(sp)
 43a:	69e2                	ld	s3,24(sp)
 43c:	6121                	addi	sp,sp,64
 43e:	8082                	ret
  neg = 0;
 440:	4301                	li	t1,0
 442:	bfad                	j	3bc <printint+0x1c>

0000000000000444 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 444:	711d                	addi	sp,sp,-96
 446:	ec86                	sd	ra,88(sp)
 448:	e8a2                	sd	s0,80(sp)
 44a:	e4a6                	sd	s1,72(sp)
 44c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 44e:	0005c483          	lbu	s1,0(a1)
 452:	20048963          	beqz	s1,664 <vprintf+0x220>
 456:	e0ca                	sd	s2,64(sp)
 458:	fc4e                	sd	s3,56(sp)
 45a:	f852                	sd	s4,48(sp)
 45c:	f456                	sd	s5,40(sp)
 45e:	f05a                	sd	s6,32(sp)
 460:	ec5e                	sd	s7,24(sp)
 462:	e862                	sd	s8,16(sp)
 464:	8b2a                	mv	s6,a0
 466:	8a2e                	mv	s4,a1
 468:	8bb2                	mv	s7,a2
  state = 0;
 46a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 46c:	4901                	li	s2,0
 46e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 470:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 474:	06400c13          	li	s8,100
 478:	a00d                	j	49a <vprintf+0x56>
        putc(fd, c0);
 47a:	85a6                	mv	a1,s1
 47c:	855a                	mv	a0,s6
 47e:	f05ff0ef          	jal	382 <putc>
 482:	a019                	j	488 <vprintf+0x44>
    } else if(state == '%'){
 484:	03598363          	beq	s3,s5,4aa <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 488:	0019079b          	addiw	a5,s2,1
 48c:	893e                	mv	s2,a5
 48e:	873e                	mv	a4,a5
 490:	97d2                	add	a5,a5,s4
 492:	0007c483          	lbu	s1,0(a5)
 496:	1c048063          	beqz	s1,656 <vprintf+0x212>
    c0 = fmt[i] & 0xff;
 49a:	0004879b          	sext.w	a5,s1
    if(state == 0){
 49e:	fe0993e3          	bnez	s3,484 <vprintf+0x40>
      if(c0 == '%'){
 4a2:	fd579ce3          	bne	a5,s5,47a <vprintf+0x36>
        state = '%';
 4a6:	89be                	mv	s3,a5
 4a8:	b7c5                	j	488 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 4aa:	00ea06b3          	add	a3,s4,a4
 4ae:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 4b2:	1a060e63          	beqz	a2,66e <vprintf+0x22a>
      if(c0 == 'd'){
 4b6:	03878763          	beq	a5,s8,4e4 <vprintf+0xa0>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4ba:	f9478693          	addi	a3,a5,-108
 4be:	0016b693          	seqz	a3,a3
 4c2:	f9c60593          	addi	a1,a2,-100
 4c6:	e99d                	bnez	a1,4fc <vprintf+0xb8>
 4c8:	ca95                	beqz	a3,4fc <vprintf+0xb8>
        printint(fd, va_arg(ap, uint64), 10, 1);
 4ca:	008b8493          	addi	s1,s7,8
 4ce:	4685                	li	a3,1
 4d0:	4629                	li	a2,10
 4d2:	000ba583          	lw	a1,0(s7)
 4d6:	855a                	mv	a0,s6
 4d8:	ec9ff0ef          	jal	3a0 <printint>
        i += 1;
 4dc:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 4de:	8ba6                	mv	s7,s1
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 4e0:	4981                	li	s3,0
 4e2:	b75d                	j	488 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 4e4:	008b8493          	addi	s1,s7,8
 4e8:	4685                	li	a3,1
 4ea:	4629                	li	a2,10
 4ec:	000ba583          	lw	a1,0(s7)
 4f0:	855a                	mv	a0,s6
 4f2:	eafff0ef          	jal	3a0 <printint>
 4f6:	8ba6                	mv	s7,s1
      state = 0;
 4f8:	4981                	li	s3,0
 4fa:	b779                	j	488 <vprintf+0x44>
      if(c1) c2 = fmt[i+2] & 0xff;
 4fc:	9752                	add	a4,a4,s4
 4fe:	00274583          	lbu	a1,2(a4)
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 502:	f9460713          	addi	a4,a2,-108
 506:	00173713          	seqz	a4,a4
 50a:	8f75                	and	a4,a4,a3
 50c:	f9c58513          	addi	a0,a1,-100
 510:	16051963          	bnez	a0,682 <vprintf+0x23e>
 514:	16070763          	beqz	a4,682 <vprintf+0x23e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 518:	008b8493          	addi	s1,s7,8
 51c:	4685                	li	a3,1
 51e:	4629                	li	a2,10
 520:	000ba583          	lw	a1,0(s7)
 524:	855a                	mv	a0,s6
 526:	e7bff0ef          	jal	3a0 <printint>
        i += 2;
 52a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 52c:	8ba6                	mv	s7,s1
      state = 0;
 52e:	4981                	li	s3,0
        i += 2;
 530:	bfa1                	j	488 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 0);
 532:	008b8493          	addi	s1,s7,8
 536:	4681                	li	a3,0
 538:	4629                	li	a2,10
 53a:	000ba583          	lw	a1,0(s7)
 53e:	855a                	mv	a0,s6
 540:	e61ff0ef          	jal	3a0 <printint>
 544:	8ba6                	mv	s7,s1
      state = 0;
 546:	4981                	li	s3,0
 548:	b781                	j	488 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 54a:	008b8493          	addi	s1,s7,8
 54e:	4681                	li	a3,0
 550:	4629                	li	a2,10
 552:	000ba583          	lw	a1,0(s7)
 556:	855a                	mv	a0,s6
 558:	e49ff0ef          	jal	3a0 <printint>
        i += 1;
 55c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 55e:	8ba6                	mv	s7,s1
      state = 0;
 560:	4981                	li	s3,0
 562:	b71d                	j	488 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 564:	008b8493          	addi	s1,s7,8
 568:	4681                	li	a3,0
 56a:	4629                	li	a2,10
 56c:	000ba583          	lw	a1,0(s7)
 570:	855a                	mv	a0,s6
 572:	e2fff0ef          	jal	3a0 <printint>
        i += 2;
 576:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 578:	8ba6                	mv	s7,s1
      state = 0;
 57a:	4981                	li	s3,0
        i += 2;
 57c:	b731                	j	488 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 57e:	008b8493          	addi	s1,s7,8
 582:	4681                	li	a3,0
 584:	4641                	li	a2,16
 586:	000ba583          	lw	a1,0(s7)
 58a:	855a                	mv	a0,s6
 58c:	e15ff0ef          	jal	3a0 <printint>
 590:	8ba6                	mv	s7,s1
      state = 0;
 592:	4981                	li	s3,0
 594:	bdd5                	j	488 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 596:	008b8493          	addi	s1,s7,8
 59a:	4681                	li	a3,0
 59c:	4641                	li	a2,16
 59e:	000ba583          	lw	a1,0(s7)
 5a2:	855a                	mv	a0,s6
 5a4:	dfdff0ef          	jal	3a0 <printint>
        i += 1;
 5a8:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 5aa:	8ba6                	mv	s7,s1
      state = 0;
 5ac:	4981                	li	s3,0
 5ae:	bde9                	j	488 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5b0:	008b8493          	addi	s1,s7,8
 5b4:	4681                	li	a3,0
 5b6:	4641                	li	a2,16
 5b8:	000ba583          	lw	a1,0(s7)
 5bc:	855a                	mv	a0,s6
 5be:	de3ff0ef          	jal	3a0 <printint>
        i += 2;
 5c2:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 5c4:	8ba6                	mv	s7,s1
      state = 0;
 5c6:	4981                	li	s3,0
        i += 2;
 5c8:	b5c1                	j	488 <vprintf+0x44>
 5ca:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 5cc:	008b8793          	addi	a5,s7,8
 5d0:	8cbe                	mv	s9,a5
 5d2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5d6:	03000593          	li	a1,48
 5da:	855a                	mv	a0,s6
 5dc:	da7ff0ef          	jal	382 <putc>
  putc(fd, 'x');
 5e0:	07800593          	li	a1,120
 5e4:	855a                	mv	a0,s6
 5e6:	d9dff0ef          	jal	382 <putc>
 5ea:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ec:	00000b97          	auipc	s7,0x0
 5f0:	30cb8b93          	addi	s7,s7,780 # 8f8 <digits>
 5f4:	03c9d793          	srli	a5,s3,0x3c
 5f8:	97de                	add	a5,a5,s7
 5fa:	0007c583          	lbu	a1,0(a5)
 5fe:	855a                	mv	a0,s6
 600:	d83ff0ef          	jal	382 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 604:	0992                	slli	s3,s3,0x4
 606:	34fd                	addiw	s1,s1,-1
 608:	f4f5                	bnez	s1,5f4 <vprintf+0x1b0>
        printptr(fd, va_arg(ap, uint64));
 60a:	8be6                	mv	s7,s9
      state = 0;
 60c:	4981                	li	s3,0
 60e:	6ca2                	ld	s9,8(sp)
 610:	bda5                	j	488 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 612:	008b8993          	addi	s3,s7,8
 616:	000bb483          	ld	s1,0(s7)
 61a:	cc91                	beqz	s1,636 <vprintf+0x1f2>
        for(; *s; s++)
 61c:	0004c583          	lbu	a1,0(s1)
 620:	c985                	beqz	a1,650 <vprintf+0x20c>
          putc(fd, *s);
 622:	855a                	mv	a0,s6
 624:	d5fff0ef          	jal	382 <putc>
        for(; *s; s++)
 628:	0485                	addi	s1,s1,1
 62a:	0004c583          	lbu	a1,0(s1)
 62e:	f9f5                	bnez	a1,622 <vprintf+0x1de>
        if((s = va_arg(ap, char*)) == 0)
 630:	8bce                	mv	s7,s3
      state = 0;
 632:	4981                	li	s3,0
 634:	bd91                	j	488 <vprintf+0x44>
          s = "(null)";
 636:	00000497          	auipc	s1,0x0
 63a:	2ba48493          	addi	s1,s1,698 # 8f0 <malloc+0x126>
        for(; *s; s++)
 63e:	02800593          	li	a1,40
 642:	b7c5                	j	622 <vprintf+0x1de>
        putc(fd, '%');
 644:	85be                	mv	a1,a5
 646:	855a                	mv	a0,s6
 648:	d3bff0ef          	jal	382 <putc>
      state = 0;
 64c:	4981                	li	s3,0
 64e:	bd2d                	j	488 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 650:	8bce                	mv	s7,s3
      state = 0;
 652:	4981                	li	s3,0
 654:	bd15                	j	488 <vprintf+0x44>
 656:	6906                	ld	s2,64(sp)
 658:	79e2                	ld	s3,56(sp)
 65a:	7a42                	ld	s4,48(sp)
 65c:	7aa2                	ld	s5,40(sp)
 65e:	7b02                	ld	s6,32(sp)
 660:	6be2                	ld	s7,24(sp)
 662:	6c42                	ld	s8,16(sp)
    }
  }
}
 664:	60e6                	ld	ra,88(sp)
 666:	6446                	ld	s0,80(sp)
 668:	64a6                	ld	s1,72(sp)
 66a:	6125                	addi	sp,sp,96
 66c:	8082                	ret
      if(c0 == 'd'){
 66e:	06400713          	li	a4,100
 672:	e6e789e3          	beq	a5,a4,4e4 <vprintf+0xa0>
      } else if(c0 == 'l' && c1 == 'd'){
 676:	f9478693          	addi	a3,a5,-108
 67a:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 67e:	85b2                	mv	a1,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 680:	4701                	li	a4,0
      } else if(c0 == 'u'){
 682:	07500513          	li	a0,117
 686:	eaa786e3          	beq	a5,a0,532 <vprintf+0xee>
      } else if(c0 == 'l' && c1 == 'u'){
 68a:	f8b60513          	addi	a0,a2,-117
 68e:	e119                	bnez	a0,694 <vprintf+0x250>
 690:	ea069de3          	bnez	a3,54a <vprintf+0x106>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 694:	f8b58513          	addi	a0,a1,-117
 698:	e119                	bnez	a0,69e <vprintf+0x25a>
 69a:	ec0715e3          	bnez	a4,564 <vprintf+0x120>
      } else if(c0 == 'x'){
 69e:	07800513          	li	a0,120
 6a2:	eca78ee3          	beq	a5,a0,57e <vprintf+0x13a>
      } else if(c0 == 'l' && c1 == 'x'){
 6a6:	f8860613          	addi	a2,a2,-120
 6aa:	e219                	bnez	a2,6b0 <vprintf+0x26c>
 6ac:	ee0695e3          	bnez	a3,596 <vprintf+0x152>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6b0:	f8858593          	addi	a1,a1,-120
 6b4:	e199                	bnez	a1,6ba <vprintf+0x276>
 6b6:	ee071de3          	bnez	a4,5b0 <vprintf+0x16c>
      } else if(c0 == 'p'){
 6ba:	07000713          	li	a4,112
 6be:	f0e786e3          	beq	a5,a4,5ca <vprintf+0x186>
      } else if(c0 == 's'){
 6c2:	07300713          	li	a4,115
 6c6:	f4e786e3          	beq	a5,a4,612 <vprintf+0x1ce>
      } else if(c0 == '%'){
 6ca:	02500713          	li	a4,37
 6ce:	f6e78be3          	beq	a5,a4,644 <vprintf+0x200>
        putc(fd, '%');
 6d2:	02500593          	li	a1,37
 6d6:	855a                	mv	a0,s6
 6d8:	cabff0ef          	jal	382 <putc>
        putc(fd, c0);
 6dc:	85a6                	mv	a1,s1
 6de:	855a                	mv	a0,s6
 6e0:	ca3ff0ef          	jal	382 <putc>
      state = 0;
 6e4:	4981                	li	s3,0
 6e6:	b34d                	j	488 <vprintf+0x44>

00000000000006e8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6e8:	715d                	addi	sp,sp,-80
 6ea:	ec06                	sd	ra,24(sp)
 6ec:	e822                	sd	s0,16(sp)
 6ee:	1000                	addi	s0,sp,32
 6f0:	e010                	sd	a2,0(s0)
 6f2:	e414                	sd	a3,8(s0)
 6f4:	e818                	sd	a4,16(s0)
 6f6:	ec1c                	sd	a5,24(s0)
 6f8:	03043023          	sd	a6,32(s0)
 6fc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 700:	8622                	mv	a2,s0
 702:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 706:	d3fff0ef          	jal	444 <vprintf>
}
 70a:	60e2                	ld	ra,24(sp)
 70c:	6442                	ld	s0,16(sp)
 70e:	6161                	addi	sp,sp,80
 710:	8082                	ret

0000000000000712 <printf>:

void
printf(const char *fmt, ...)
{
 712:	711d                	addi	sp,sp,-96
 714:	ec06                	sd	ra,24(sp)
 716:	e822                	sd	s0,16(sp)
 718:	1000                	addi	s0,sp,32
 71a:	e40c                	sd	a1,8(s0)
 71c:	e810                	sd	a2,16(s0)
 71e:	ec14                	sd	a3,24(s0)
 720:	f018                	sd	a4,32(s0)
 722:	f41c                	sd	a5,40(s0)
 724:	03043823          	sd	a6,48(s0)
 728:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 72c:	00840613          	addi	a2,s0,8
 730:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 734:	85aa                	mv	a1,a0
 736:	4505                	li	a0,1
 738:	d0dff0ef          	jal	444 <vprintf>
}
 73c:	60e2                	ld	ra,24(sp)
 73e:	6442                	ld	s0,16(sp)
 740:	6125                	addi	sp,sp,96
 742:	8082                	ret

0000000000000744 <free>:
static Header base;
static Header *freep;

void
free (void *ap)
{
 744:	1141                	addi	sp,sp,-16
 746:	e406                	sd	ra,8(sp)
 748:	e022                	sd	s0,0(sp)
 74a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 74c:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 750:	00001797          	auipc	a5,0x1
 754:	8b07b783          	ld	a5,-1872(a5) # 1000 <freep>
 758:	a039                	j	766 <free+0x22>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 75a:	6398                	ld	a4,0(a5)
 75c:	00e7e463          	bltu	a5,a4,764 <free+0x20>
 760:	00e6ea63          	bltu	a3,a4,774 <free+0x30>
{
 764:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 766:	fed7fae3          	bgeu	a5,a3,75a <free+0x16>
 76a:	6398                	ld	a4,0(a5)
 76c:	00e6e463          	bltu	a3,a4,774 <free+0x30>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 770:	fee7eae3          	bltu	a5,a4,764 <free+0x20>
      break;
  if (bp + bp->s.size == p->s.ptr)
 774:	ff852583          	lw	a1,-8(a0)
 778:	6390                	ld	a2,0(a5)
 77a:	02059813          	slli	a6,a1,0x20
 77e:	01c85713          	srli	a4,a6,0x1c
 782:	9736                	add	a4,a4,a3
 784:	02e60563          	beq	a2,a4,7ae <free+0x6a>
    {
      bp->s.size += p->s.ptr->s.size;
      bp->s.ptr = p->s.ptr->s.ptr;
 788:	fec53823          	sd	a2,-16(a0)
    }
  else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp)
 78c:	4790                	lw	a2,8(a5)
 78e:	02061593          	slli	a1,a2,0x20
 792:	01c5d713          	srli	a4,a1,0x1c
 796:	973e                	add	a4,a4,a5
 798:	02e68263          	beq	a3,a4,7bc <free+0x78>
    {
      p->s.size += bp->s.size;
      p->s.ptr = bp->s.ptr;
 79c:	e394                	sd	a3,0(a5)
    }
  else
    p->s.ptr = bp;
  freep = p;
 79e:	00001717          	auipc	a4,0x1
 7a2:	86f73123          	sd	a5,-1950(a4) # 1000 <freep>
}
 7a6:	60a2                	ld	ra,8(sp)
 7a8:	6402                	ld	s0,0(sp)
 7aa:	0141                	addi	sp,sp,16
 7ac:	8082                	ret
      bp->s.size += p->s.ptr->s.size;
 7ae:	4618                	lw	a4,8(a2)
 7b0:	9f2d                	addw	a4,a4,a1
 7b2:	fee52c23          	sw	a4,-8(a0)
      bp->s.ptr = p->s.ptr->s.ptr;
 7b6:	6398                	ld	a4,0(a5)
 7b8:	6310                	ld	a2,0(a4)
 7ba:	b7f9                	j	788 <free+0x44>
      p->s.size += bp->s.size;
 7bc:	ff852703          	lw	a4,-8(a0)
 7c0:	9f31                	addw	a4,a4,a2
 7c2:	c798                	sw	a4,8(a5)
      p->s.ptr = bp->s.ptr;
 7c4:	ff053683          	ld	a3,-16(a0)
 7c8:	bfd1                	j	79c <free+0x58>

00000000000007ca <malloc>:
  return freep;
}

void *
malloc (uint nbytes)
{
 7ca:	7139                	addi	sp,sp,-64
 7cc:	fc06                	sd	ra,56(sp)
 7ce:	f822                	sd	s0,48(sp)
 7d0:	f04a                	sd	s2,32(sp)
 7d2:	ec4e                	sd	s3,24(sp)
 7d4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof (Header) - 1) / sizeof (Header) + 1;
 7d6:	02051993          	slli	s3,a0,0x20
 7da:	0209d993          	srli	s3,s3,0x20
 7de:	09bd                	addi	s3,s3,15
 7e0:	0049d993          	srli	s3,s3,0x4
 7e4:	2985                	addiw	s3,s3,1
 7e6:	894e                	mv	s2,s3
  if ((prevp = freep) == 0)
 7e8:	00001517          	auipc	a0,0x1
 7ec:	81853503          	ld	a0,-2024(a0) # 1000 <freep>
 7f0:	c905                	beqz	a0,820 <malloc+0x56>
    {
      base.s.ptr = freep = prevp = &base;
      base.s.size = 0;
    }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 7f2:	611c                	ld	a5,0(a0)
    {
      if (p->s.size >= nunits)
 7f4:	4798                	lw	a4,8(a5)
 7f6:	09377663          	bgeu	a4,s3,882 <malloc+0xb8>
 7fa:	f426                	sd	s1,40(sp)
 7fc:	e852                	sd	s4,16(sp)
 7fe:	e456                	sd	s5,8(sp)
 800:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 802:	8a4e                	mv	s4,s3
 804:	6705                	lui	a4,0x1
 806:	00e9f363          	bgeu	s3,a4,80c <malloc+0x42>
 80a:	6a05                	lui	s4,0x1
 80c:	000a0b1b          	sext.w	s6,s4
  p = sbrk (nu * sizeof (Header));
 810:	004a1a1b          	slliw	s4,s4,0x4
              p->s.size = nunits;
            }
          freep = prevp;
          return (void *)(p + 1);
        }
      if (p == freep)
 814:	00000497          	auipc	s1,0x0
 818:	7ec48493          	addi	s1,s1,2028 # 1000 <freep>
  if (p == (char *)-1)
 81c:	5afd                	li	s5,-1
 81e:	a83d                	j	85c <malloc+0x92>
 820:	f426                	sd	s1,40(sp)
 822:	e852                	sd	s4,16(sp)
 824:	e456                	sd	s5,8(sp)
 826:	e05a                	sd	s6,0(sp)
      base.s.ptr = freep = prevp = &base;
 828:	00000797          	auipc	a5,0x0
 82c:	7e878793          	addi	a5,a5,2024 # 1010 <base>
 830:	00000717          	auipc	a4,0x0
 834:	7cf73823          	sd	a5,2000(a4) # 1000 <freep>
 838:	e39c                	sd	a5,0(a5)
      base.s.size = 0;
 83a:	0007a423          	sw	zero,8(a5)
      if (p->s.size >= nunits)
 83e:	b7d1                	j	802 <malloc+0x38>
            prevp->s.ptr = p->s.ptr;
 840:	6398                	ld	a4,0(a5)
 842:	e118                	sd	a4,0(a0)
 844:	a899                	j	89a <malloc+0xd0>
  hp->s.size = nu;
 846:	01652423          	sw	s6,8(a0)
  free ((void *)(hp + 1));
 84a:	0541                	addi	a0,a0,16
 84c:	ef9ff0ef          	jal	744 <free>
  return freep;
 850:	6088                	ld	a0,0(s1)
        if ((p = morecore (nunits)) == 0)
 852:	c125                	beqz	a0,8b2 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 854:	611c                	ld	a5,0(a0)
      if (p->s.size >= nunits)
 856:	4798                	lw	a4,8(a5)
 858:	03277163          	bgeu	a4,s2,87a <malloc+0xb0>
      if (p == freep)
 85c:	6098                	ld	a4,0(s1)
 85e:	853e                	mv	a0,a5
 860:	fef71ae3          	bne	a4,a5,854 <malloc+0x8a>
  p = sbrk (nu * sizeof (Header));
 864:	8552                	mv	a0,s4
 866:	afdff0ef          	jal	362 <sbrk>
  if (p == (char *)-1)
 86a:	fd551ee3          	bne	a0,s5,846 <malloc+0x7c>
          return 0;
 86e:	4501                	li	a0,0
 870:	74a2                	ld	s1,40(sp)
 872:	6a42                	ld	s4,16(sp)
 874:	6aa2                	ld	s5,8(sp)
 876:	6b02                	ld	s6,0(sp)
 878:	a03d                	j	8a6 <malloc+0xdc>
 87a:	74a2                	ld	s1,40(sp)
 87c:	6a42                	ld	s4,16(sp)
 87e:	6aa2                	ld	s5,8(sp)
 880:	6b02                	ld	s6,0(sp)
          if (p->s.size == nunits)
 882:	fae90fe3          	beq	s2,a4,840 <malloc+0x76>
              p->s.size -= nunits;
 886:	4137073b          	subw	a4,a4,s3
 88a:	c798                	sw	a4,8(a5)
              p += p->s.size;
 88c:	02071693          	slli	a3,a4,0x20
 890:	01c6d713          	srli	a4,a3,0x1c
 894:	97ba                	add	a5,a5,a4
              p->s.size = nunits;
 896:	0137a423          	sw	s3,8(a5)
          freep = prevp;
 89a:	00000717          	auipc	a4,0x0
 89e:	76a73323          	sd	a0,1894(a4) # 1000 <freep>
          return (void *)(p + 1);
 8a2:	01078513          	addi	a0,a5,16
    }
}
 8a6:	70e2                	ld	ra,56(sp)
 8a8:	7442                	ld	s0,48(sp)
 8aa:	7902                	ld	s2,32(sp)
 8ac:	69e2                	ld	s3,24(sp)
 8ae:	6121                	addi	sp,sp,64
 8b0:	8082                	ret
 8b2:	74a2                	ld	s1,40(sp)
 8b4:	6a42                	ld	s4,16(sp)
 8b6:	6aa2                	ld	s5,8(sp)
 8b8:	6b02                	ld	s6,0(sp)
 8ba:	b7f5                	j	8a6 <malloc+0xdc>
