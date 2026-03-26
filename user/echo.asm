
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	e05a                	sd	s6,0(sp)
  12:	0080                	addi	s0,sp,64
  int i;

  for(i = 1; i < argc; i++){
  14:	4785                	li	a5,1
  16:	06a7d063          	bge	a5,a0,76 <main+0x76>
  1a:	00858493          	addi	s1,a1,8
  1e:	3579                	addiw	a0,a0,-2
  20:	02051793          	slli	a5,a0,0x20
  24:	01d7d513          	srli	a0,a5,0x1d
  28:	00a48ab3          	add	s5,s1,a0
  2c:	05c1                	addi	a1,a1,16
  2e:	00a58a33          	add	s4,a1,a0
    write(1, argv[i], strlen(argv[i]));
  32:	4985                	li	s3,1
    if(i + 1 < argc){
      write(1, " ", 1);
  34:	00001b17          	auipc	s6,0x1
  38:	8bcb0b13          	addi	s6,s6,-1860 # 8f0 <malloc+0xf8>
  3c:	a809                	j	4e <main+0x4e>
  3e:	864e                	mv	a2,s3
  40:	85da                	mv	a1,s6
  42:	854e                	mv	a0,s3
  44:	2e4000ef          	jal	328 <write>
  for(i = 1; i < argc; i++){
  48:	04a1                	addi	s1,s1,8
  4a:	03448663          	beq	s1,s4,76 <main+0x76>
    write(1, argv[i], strlen(argv[i]));
  4e:	0004b903          	ld	s2,0(s1)
  52:	854a                	mv	a0,s2
  54:	08a000ef          	jal	de <strlen>
  58:	862a                	mv	a2,a0
  5a:	85ca                	mv	a1,s2
  5c:	854e                	mv	a0,s3
  5e:	2ca000ef          	jal	328 <write>
    if(i + 1 < argc){
  62:	fd549ee3          	bne	s1,s5,3e <main+0x3e>
    } else {
      write(1, "\n", 1);
  66:	4605                	li	a2,1
  68:	00001597          	auipc	a1,0x1
  6c:	89058593          	addi	a1,a1,-1904 # 8f8 <malloc+0x100>
  70:	8532                	mv	a0,a2
  72:	2b6000ef          	jal	328 <write>
    }
  }
  exit(0);
  76:	4501                	li	a0,0
  78:	290000ef          	jal	308 <exit>

000000000000007c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start ()
{
  7c:	1141                	addi	sp,sp,-16
  7e:	e406                	sd	ra,8(sp)
  80:	e022                	sd	s0,0(sp)
  82:	0800                	addi	s0,sp,16
  extern int main ();
  main ();
  84:	f7dff0ef          	jal	0 <main>
  exit (0);
  88:	4501                	li	a0,0
  8a:	27e000ef          	jal	308 <exit>

000000000000008e <strcpy>:
}

char *
strcpy (char *s, const char *t)
{
  8e:	1141                	addi	sp,sp,-16
  90:	e406                	sd	ra,8(sp)
  92:	e022                	sd	s0,0(sp)
  94:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  96:	87aa                	mv	a5,a0
  98:	0585                	addi	a1,a1,1
  9a:	0785                	addi	a5,a5,1
  9c:	fff5c703          	lbu	a4,-1(a1)
  a0:	fee78fa3          	sb	a4,-1(a5)
  a4:	fb75                	bnez	a4,98 <strcpy+0xa>
    ;
  return os;
}
  a6:	60a2                	ld	ra,8(sp)
  a8:	6402                	ld	s0,0(sp)
  aa:	0141                	addi	sp,sp,16
  ac:	8082                	ret

00000000000000ae <strcmp>:

int
strcmp (const char *p, const char *q)
{
  ae:	1141                	addi	sp,sp,-16
  b0:	e406                	sd	ra,8(sp)
  b2:	e022                	sd	s0,0(sp)
  b4:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  b6:	00054783          	lbu	a5,0(a0)
  ba:	cb91                	beqz	a5,ce <strcmp+0x20>
  bc:	0005c703          	lbu	a4,0(a1)
  c0:	00f71763          	bne	a4,a5,ce <strcmp+0x20>
    p++, q++;
  c4:	0505                	addi	a0,a0,1
  c6:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  c8:	00054783          	lbu	a5,0(a0)
  cc:	fbe5                	bnez	a5,bc <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  ce:	0005c503          	lbu	a0,0(a1)
}
  d2:	40a7853b          	subw	a0,a5,a0
  d6:	60a2                	ld	ra,8(sp)
  d8:	6402                	ld	s0,0(sp)
  da:	0141                	addi	sp,sp,16
  dc:	8082                	ret

00000000000000de <strlen>:

uint
strlen (const char *s)
{
  de:	1141                	addi	sp,sp,-16
  e0:	e406                	sd	ra,8(sp)
  e2:	e022                	sd	s0,0(sp)
  e4:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  e6:	00054783          	lbu	a5,0(a0)
  ea:	cf91                	beqz	a5,106 <strlen+0x28>
  ec:	00150793          	addi	a5,a0,1
  f0:	86be                	mv	a3,a5
  f2:	0785                	addi	a5,a5,1
  f4:	fff7c703          	lbu	a4,-1(a5)
  f8:	ff65                	bnez	a4,f0 <strlen+0x12>
  fa:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  fe:	60a2                	ld	ra,8(sp)
 100:	6402                	ld	s0,0(sp)
 102:	0141                	addi	sp,sp,16
 104:	8082                	ret
  for (n = 0; s[n]; n++)
 106:	4501                	li	a0,0
 108:	bfdd                	j	fe <strlen+0x20>

000000000000010a <memset>:

void *
memset (void *dst, int c, uint n)
{
 10a:	1141                	addi	sp,sp,-16
 10c:	e406                	sd	ra,8(sp)
 10e:	e022                	sd	s0,0(sp)
 110:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
 112:	ca19                	beqz	a2,128 <memset+0x1e>
 114:	87aa                	mv	a5,a0
 116:	1602                	slli	a2,a2,0x20
 118:	9201                	srli	a2,a2,0x20
 11a:	00a60733          	add	a4,a2,a0
    {
      cdst[i] = c;
 11e:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 122:	0785                	addi	a5,a5,1
 124:	fee79de3          	bne	a5,a4,11e <memset+0x14>
    }
  return dst;
}
 128:	60a2                	ld	ra,8(sp)
 12a:	6402                	ld	s0,0(sp)
 12c:	0141                	addi	sp,sp,16
 12e:	8082                	ret

0000000000000130 <strchr>:

char *
strchr (const char *s, char c)
{
 130:	1141                	addi	sp,sp,-16
 132:	e406                	sd	ra,8(sp)
 134:	e022                	sd	s0,0(sp)
 136:	0800                	addi	s0,sp,16
  for (; *s; s++)
 138:	00054783          	lbu	a5,0(a0)
 13c:	cf81                	beqz	a5,154 <strchr+0x24>
    if (*s == c)
 13e:	00f58763          	beq	a1,a5,14c <strchr+0x1c>
  for (; *s; s++)
 142:	0505                	addi	a0,a0,1
 144:	00054783          	lbu	a5,0(a0)
 148:	fbfd                	bnez	a5,13e <strchr+0xe>
      return (char *)s;
  return 0;
 14a:	4501                	li	a0,0
}
 14c:	60a2                	ld	ra,8(sp)
 14e:	6402                	ld	s0,0(sp)
 150:	0141                	addi	sp,sp,16
 152:	8082                	ret
  return 0;
 154:	4501                	li	a0,0
 156:	bfdd                	j	14c <strchr+0x1c>

0000000000000158 <gets>:

char *
gets (char *buf, int max)
{
 158:	711d                	addi	sp,sp,-96
 15a:	ec86                	sd	ra,88(sp)
 15c:	e8a2                	sd	s0,80(sp)
 15e:	e4a6                	sd	s1,72(sp)
 160:	e0ca                	sd	s2,64(sp)
 162:	fc4e                	sd	s3,56(sp)
 164:	f852                	sd	s4,48(sp)
 166:	f456                	sd	s5,40(sp)
 168:	f05a                	sd	s6,32(sp)
 16a:	ec5e                	sd	s7,24(sp)
 16c:	e862                	sd	s8,16(sp)
 16e:	1080                	addi	s0,sp,96
 170:	8baa                	mv	s7,a0
 172:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 174:	892a                	mv	s2,a0
 176:	4481                	li	s1,0
    {
      cc = read (0, &c, 1);
 178:	faf40b13          	addi	s6,s0,-81
 17c:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;)
 17e:	8c26                	mv	s8,s1
 180:	0014899b          	addiw	s3,s1,1
 184:	84ce                	mv	s1,s3
 186:	0349d463          	bge	s3,s4,1ae <gets+0x56>
      cc = read (0, &c, 1);
 18a:	8656                	mv	a2,s5
 18c:	85da                	mv	a1,s6
 18e:	4501                	li	a0,0
 190:	190000ef          	jal	320 <read>
      if (cc < 1)
 194:	00a05d63          	blez	a0,1ae <gets+0x56>
        break;
      buf[i++] = c;
 198:	faf44783          	lbu	a5,-81(s0)
 19c:	00f90023          	sb	a5,0(s2)
      if (c == '\n' || c == '\r')
 1a0:	0905                	addi	s2,s2,1
 1a2:	ff678713          	addi	a4,a5,-10
 1a6:	c319                	beqz	a4,1ac <gets+0x54>
 1a8:	17cd                	addi	a5,a5,-13
 1aa:	fbf1                	bnez	a5,17e <gets+0x26>
      buf[i++] = c;
 1ac:	8c4e                	mv	s8,s3
        break;
    }
  buf[i] = '\0';
 1ae:	9c5e                	add	s8,s8,s7
 1b0:	000c0023          	sb	zero,0(s8)
  return buf;
}
 1b4:	855e                	mv	a0,s7
 1b6:	60e6                	ld	ra,88(sp)
 1b8:	6446                	ld	s0,80(sp)
 1ba:	64a6                	ld	s1,72(sp)
 1bc:	6906                	ld	s2,64(sp)
 1be:	79e2                	ld	s3,56(sp)
 1c0:	7a42                	ld	s4,48(sp)
 1c2:	7aa2                	ld	s5,40(sp)
 1c4:	7b02                	ld	s6,32(sp)
 1c6:	6be2                	ld	s7,24(sp)
 1c8:	6c42                	ld	s8,16(sp)
 1ca:	6125                	addi	sp,sp,96
 1cc:	8082                	ret

00000000000001ce <stat>:

int
stat (const char *n, struct stat *st)
{
 1ce:	1101                	addi	sp,sp,-32
 1d0:	ec06                	sd	ra,24(sp)
 1d2:	e822                	sd	s0,16(sp)
 1d4:	e04a                	sd	s2,0(sp)
 1d6:	1000                	addi	s0,sp,32
 1d8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open (n, O_RDONLY);
 1da:	4581                	li	a1,0
 1dc:	16c000ef          	jal	348 <open>
  if (fd < 0)
 1e0:	02054263          	bltz	a0,204 <stat+0x36>
 1e4:	e426                	sd	s1,8(sp)
 1e6:	84aa                	mv	s1,a0
    return -1;
  r = fstat (fd, st);
 1e8:	85ca                	mv	a1,s2
 1ea:	176000ef          	jal	360 <fstat>
 1ee:	892a                	mv	s2,a0
  close (fd);
 1f0:	8526                	mv	a0,s1
 1f2:	13e000ef          	jal	330 <close>
  return r;
 1f6:	64a2                	ld	s1,8(sp)
}
 1f8:	854a                	mv	a0,s2
 1fa:	60e2                	ld	ra,24(sp)
 1fc:	6442                	ld	s0,16(sp)
 1fe:	6902                	ld	s2,0(sp)
 200:	6105                	addi	sp,sp,32
 202:	8082                	ret
    return -1;
 204:	57fd                	li	a5,-1
 206:	893e                	mv	s2,a5
 208:	bfc5                	j	1f8 <stat+0x2a>

000000000000020a <atoi>:

int
atoi (const char *s)
{
 20a:	1141                	addi	sp,sp,-16
 20c:	e406                	sd	ra,8(sp)
 20e:	e022                	sd	s0,0(sp)
 210:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 212:	00054683          	lbu	a3,0(a0)
 216:	fd06879b          	addiw	a5,a3,-48
 21a:	0ff7f793          	zext.b	a5,a5
 21e:	4625                	li	a2,9
 220:	02f66963          	bltu	a2,a5,252 <atoi+0x48>
 224:	872a                	mv	a4,a0
  n = 0;
 226:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 228:	0705                	addi	a4,a4,1
 22a:	0025179b          	slliw	a5,a0,0x2
 22e:	9fa9                	addw	a5,a5,a0
 230:	0017979b          	slliw	a5,a5,0x1
 234:	9fb5                	addw	a5,a5,a3
 236:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 23a:	00074683          	lbu	a3,0(a4)
 23e:	fd06879b          	addiw	a5,a3,-48
 242:	0ff7f793          	zext.b	a5,a5
 246:	fef671e3          	bgeu	a2,a5,228 <atoi+0x1e>
  return n;
}
 24a:	60a2                	ld	ra,8(sp)
 24c:	6402                	ld	s0,0(sp)
 24e:	0141                	addi	sp,sp,16
 250:	8082                	ret
  n = 0;
 252:	4501                	li	a0,0
 254:	bfdd                	j	24a <atoi+0x40>

0000000000000256 <memmove>:

void *
memmove (void *vdst, const void *vsrc, int n)
{
 256:	1141                	addi	sp,sp,-16
 258:	e406                	sd	ra,8(sp)
 25a:	e022                	sd	s0,0(sp)
 25c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 25e:	02b57563          	bgeu	a0,a1,288 <memmove+0x32>
    {
      while (n-- > 0)
 262:	00c05f63          	blez	a2,280 <memmove+0x2a>
 266:	1602                	slli	a2,a2,0x20
 268:	9201                	srli	a2,a2,0x20
 26a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 26e:	872a                	mv	a4,a0
        *dst++ = *src++;
 270:	0585                	addi	a1,a1,1
 272:	0705                	addi	a4,a4,1
 274:	fff5c683          	lbu	a3,-1(a1)
 278:	fed70fa3          	sb	a3,-1(a4)
      while (n-- > 0)
 27c:	fee79ae3          	bne	a5,a4,270 <memmove+0x1a>
      src += n;
      while (n-- > 0)
        *--dst = *--src;
    }
  return vdst;
}
 280:	60a2                	ld	ra,8(sp)
 282:	6402                	ld	s0,0(sp)
 284:	0141                	addi	sp,sp,16
 286:	8082                	ret
      while (n-- > 0)
 288:	fec05ce3          	blez	a2,280 <memmove+0x2a>
      dst += n;
 28c:	00c50733          	add	a4,a0,a2
      src += n;
 290:	95b2                	add	a1,a1,a2
 292:	fff6079b          	addiw	a5,a2,-1
 296:	1782                	slli	a5,a5,0x20
 298:	9381                	srli	a5,a5,0x20
 29a:	fff7c793          	not	a5,a5
 29e:	97ba                	add	a5,a5,a4
        *--dst = *--src;
 2a0:	15fd                	addi	a1,a1,-1
 2a2:	177d                	addi	a4,a4,-1
 2a4:	0005c683          	lbu	a3,0(a1)
 2a8:	00d70023          	sb	a3,0(a4)
      while (n-- > 0)
 2ac:	fef71ae3          	bne	a4,a5,2a0 <memmove+0x4a>
 2b0:	bfc1                	j	280 <memmove+0x2a>

00000000000002b2 <memcmp>:

int
memcmp (const void *s1, const void *s2, uint n)
{
 2b2:	1141                	addi	sp,sp,-16
 2b4:	e406                	sd	ra,8(sp)
 2b6:	e022                	sd	s0,0(sp)
 2b8:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 2ba:	c61d                	beqz	a2,2e8 <memcmp+0x36>
 2bc:	1602                	slli	a2,a2,0x20
 2be:	9201                	srli	a2,a2,0x20
 2c0:	00c506b3          	add	a3,a0,a2
    {
      if (*p1 != *p2)
 2c4:	00054783          	lbu	a5,0(a0)
 2c8:	0005c703          	lbu	a4,0(a1)
 2cc:	00e79863          	bne	a5,a4,2dc <memcmp+0x2a>
        {
          return *p1 - *p2;
        }
      p1++;
 2d0:	0505                	addi	a0,a0,1
      p2++;
 2d2:	0585                	addi	a1,a1,1
  while (n-- > 0)
 2d4:	fed518e3          	bne	a0,a3,2c4 <memcmp+0x12>
    }
  return 0;
 2d8:	4501                	li	a0,0
 2da:	a019                	j	2e0 <memcmp+0x2e>
          return *p1 - *p2;
 2dc:	40e7853b          	subw	a0,a5,a4
}
 2e0:	60a2                	ld	ra,8(sp)
 2e2:	6402                	ld	s0,0(sp)
 2e4:	0141                	addi	sp,sp,16
 2e6:	8082                	ret
  return 0;
 2e8:	4501                	li	a0,0
 2ea:	bfdd                	j	2e0 <memcmp+0x2e>

00000000000002ec <memcpy>:

void *
memcpy (void *dst, const void *src, uint n)
{
 2ec:	1141                	addi	sp,sp,-16
 2ee:	e406                	sd	ra,8(sp)
 2f0:	e022                	sd	s0,0(sp)
 2f2:	0800                	addi	s0,sp,16
  return memmove (dst, src, n);
 2f4:	f63ff0ef          	jal	256 <memmove>
}
 2f8:	60a2                	ld	ra,8(sp)
 2fa:	6402                	ld	s0,0(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret

0000000000000300 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 300:	4885                	li	a7,1
 ecall
 302:	00000073          	ecall
 ret
 306:	8082                	ret

0000000000000308 <exit>:
.global exit
exit:
 li a7, SYS_exit
 308:	4889                	li	a7,2
 ecall
 30a:	00000073          	ecall
 ret
 30e:	8082                	ret

0000000000000310 <wait>:
.global wait
wait:
 li a7, SYS_wait
 310:	488d                	li	a7,3
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 318:	4891                	li	a7,4
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <read>:
.global read
read:
 li a7, SYS_read
 320:	4895                	li	a7,5
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <write>:
.global write
write:
 li a7, SYS_write
 328:	48c1                	li	a7,16
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <close>:
.global close
close:
 li a7, SYS_close
 330:	48d5                	li	a7,21
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <kill>:
.global kill
kill:
 li a7, SYS_kill
 338:	4899                	li	a7,6
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <exec>:
.global exec
exec:
 li a7, SYS_exec
 340:	489d                	li	a7,7
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <open>:
.global open
open:
 li a7, SYS_open
 348:	48bd                	li	a7,15
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 350:	48c5                	li	a7,17
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 358:	48c9                	li	a7,18
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 360:	48a1                	li	a7,8
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <link>:
.global link
link:
 li a7, SYS_link
 368:	48cd                	li	a7,19
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 370:	48d1                	li	a7,20
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 378:	48a5                	li	a7,9
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <dup>:
.global dup
dup:
 li a7, SYS_dup
 380:	48a9                	li	a7,10
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 388:	48ad                	li	a7,11
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 390:	48b1                	li	a7,12
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 398:	48b5                	li	a7,13
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3a0:	48b9                	li	a7,14
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3a8:	48d9                	li	a7,22
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3b0:	1101                	addi	sp,sp,-32
 3b2:	ec06                	sd	ra,24(sp)
 3b4:	e822                	sd	s0,16(sp)
 3b6:	1000                	addi	s0,sp,32
 3b8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3bc:	4605                	li	a2,1
 3be:	fef40593          	addi	a1,s0,-17
 3c2:	f67ff0ef          	jal	328 <write>
}
 3c6:	60e2                	ld	ra,24(sp)
 3c8:	6442                	ld	s0,16(sp)
 3ca:	6105                	addi	sp,sp,32
 3cc:	8082                	ret

00000000000003ce <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3ce:	7139                	addi	sp,sp,-64
 3d0:	fc06                	sd	ra,56(sp)
 3d2:	f822                	sd	s0,48(sp)
 3d4:	f04a                	sd	s2,32(sp)
 3d6:	ec4e                	sd	s3,24(sp)
 3d8:	0080                	addi	s0,sp,64
 3da:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3dc:	cac9                	beqz	a3,46e <printint+0xa0>
 3de:	01f5d79b          	srliw	a5,a1,0x1f
 3e2:	c7d1                	beqz	a5,46e <printint+0xa0>
    neg = 1;
    x = -xx;
 3e4:	40b005bb          	negw	a1,a1
    neg = 1;
 3e8:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 3ea:	fc040993          	addi	s3,s0,-64
  neg = 0;
 3ee:	86ce                	mv	a3,s3
  i = 0;
 3f0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3f2:	00000817          	auipc	a6,0x0
 3f6:	51680813          	addi	a6,a6,1302 # 908 <digits>
 3fa:	88ba                	mv	a7,a4
 3fc:	0017051b          	addiw	a0,a4,1
 400:	872a                	mv	a4,a0
 402:	02c5f7bb          	remuw	a5,a1,a2
 406:	1782                	slli	a5,a5,0x20
 408:	9381                	srli	a5,a5,0x20
 40a:	97c2                	add	a5,a5,a6
 40c:	0007c783          	lbu	a5,0(a5)
 410:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 414:	87ae                	mv	a5,a1
 416:	02c5d5bb          	divuw	a1,a1,a2
 41a:	0685                	addi	a3,a3,1
 41c:	fcc7ffe3          	bgeu	a5,a2,3fa <printint+0x2c>
  if(neg)
 420:	00030c63          	beqz	t1,438 <printint+0x6a>
    buf[i++] = '-';
 424:	fd050793          	addi	a5,a0,-48
 428:	00878533          	add	a0,a5,s0
 42c:	02d00793          	li	a5,45
 430:	fef50823          	sb	a5,-16(a0)
 434:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 438:	02e05563          	blez	a4,462 <printint+0x94>
 43c:	f426                	sd	s1,40(sp)
 43e:	377d                	addiw	a4,a4,-1
 440:	00e984b3          	add	s1,s3,a4
 444:	19fd                	addi	s3,s3,-1
 446:	99ba                	add	s3,s3,a4
 448:	1702                	slli	a4,a4,0x20
 44a:	9301                	srli	a4,a4,0x20
 44c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 450:	0004c583          	lbu	a1,0(s1)
 454:	854a                	mv	a0,s2
 456:	f5bff0ef          	jal	3b0 <putc>
  while(--i >= 0)
 45a:	14fd                	addi	s1,s1,-1
 45c:	ff349ae3          	bne	s1,s3,450 <printint+0x82>
 460:	74a2                	ld	s1,40(sp)
}
 462:	70e2                	ld	ra,56(sp)
 464:	7442                	ld	s0,48(sp)
 466:	7902                	ld	s2,32(sp)
 468:	69e2                	ld	s3,24(sp)
 46a:	6121                	addi	sp,sp,64
 46c:	8082                	ret
  neg = 0;
 46e:	4301                	li	t1,0
 470:	bfad                	j	3ea <printint+0x1c>

0000000000000472 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 472:	711d                	addi	sp,sp,-96
 474:	ec86                	sd	ra,88(sp)
 476:	e8a2                	sd	s0,80(sp)
 478:	e4a6                	sd	s1,72(sp)
 47a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 47c:	0005c483          	lbu	s1,0(a1)
 480:	20048963          	beqz	s1,692 <vprintf+0x220>
 484:	e0ca                	sd	s2,64(sp)
 486:	fc4e                	sd	s3,56(sp)
 488:	f852                	sd	s4,48(sp)
 48a:	f456                	sd	s5,40(sp)
 48c:	f05a                	sd	s6,32(sp)
 48e:	ec5e                	sd	s7,24(sp)
 490:	e862                	sd	s8,16(sp)
 492:	8b2a                	mv	s6,a0
 494:	8a2e                	mv	s4,a1
 496:	8bb2                	mv	s7,a2
  state = 0;
 498:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 49a:	4901                	li	s2,0
 49c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 49e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 4a2:	06400c13          	li	s8,100
 4a6:	a00d                	j	4c8 <vprintf+0x56>
        putc(fd, c0);
 4a8:	85a6                	mv	a1,s1
 4aa:	855a                	mv	a0,s6
 4ac:	f05ff0ef          	jal	3b0 <putc>
 4b0:	a019                	j	4b6 <vprintf+0x44>
    } else if(state == '%'){
 4b2:	03598363          	beq	s3,s5,4d8 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 4b6:	0019079b          	addiw	a5,s2,1
 4ba:	893e                	mv	s2,a5
 4bc:	873e                	mv	a4,a5
 4be:	97d2                	add	a5,a5,s4
 4c0:	0007c483          	lbu	s1,0(a5)
 4c4:	1c048063          	beqz	s1,684 <vprintf+0x212>
    c0 = fmt[i] & 0xff;
 4c8:	0004879b          	sext.w	a5,s1
    if(state == 0){
 4cc:	fe0993e3          	bnez	s3,4b2 <vprintf+0x40>
      if(c0 == '%'){
 4d0:	fd579ce3          	bne	a5,s5,4a8 <vprintf+0x36>
        state = '%';
 4d4:	89be                	mv	s3,a5
 4d6:	b7c5                	j	4b6 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 4d8:	00ea06b3          	add	a3,s4,a4
 4dc:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 4e0:	1a060e63          	beqz	a2,69c <vprintf+0x22a>
      if(c0 == 'd'){
 4e4:	03878763          	beq	a5,s8,512 <vprintf+0xa0>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4e8:	f9478693          	addi	a3,a5,-108
 4ec:	0016b693          	seqz	a3,a3
 4f0:	f9c60593          	addi	a1,a2,-100
 4f4:	e99d                	bnez	a1,52a <vprintf+0xb8>
 4f6:	ca95                	beqz	a3,52a <vprintf+0xb8>
        printint(fd, va_arg(ap, uint64), 10, 1);
 4f8:	008b8493          	addi	s1,s7,8
 4fc:	4685                	li	a3,1
 4fe:	4629                	li	a2,10
 500:	000ba583          	lw	a1,0(s7)
 504:	855a                	mv	a0,s6
 506:	ec9ff0ef          	jal	3ce <printint>
        i += 1;
 50a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 50c:	8ba6                	mv	s7,s1
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 50e:	4981                	li	s3,0
 510:	b75d                	j	4b6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 512:	008b8493          	addi	s1,s7,8
 516:	4685                	li	a3,1
 518:	4629                	li	a2,10
 51a:	000ba583          	lw	a1,0(s7)
 51e:	855a                	mv	a0,s6
 520:	eafff0ef          	jal	3ce <printint>
 524:	8ba6                	mv	s7,s1
      state = 0;
 526:	4981                	li	s3,0
 528:	b779                	j	4b6 <vprintf+0x44>
      if(c1) c2 = fmt[i+2] & 0xff;
 52a:	9752                	add	a4,a4,s4
 52c:	00274583          	lbu	a1,2(a4)
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 530:	f9460713          	addi	a4,a2,-108
 534:	00173713          	seqz	a4,a4
 538:	8f75                	and	a4,a4,a3
 53a:	f9c58513          	addi	a0,a1,-100
 53e:	16051963          	bnez	a0,6b0 <vprintf+0x23e>
 542:	16070763          	beqz	a4,6b0 <vprintf+0x23e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 546:	008b8493          	addi	s1,s7,8
 54a:	4685                	li	a3,1
 54c:	4629                	li	a2,10
 54e:	000ba583          	lw	a1,0(s7)
 552:	855a                	mv	a0,s6
 554:	e7bff0ef          	jal	3ce <printint>
        i += 2;
 558:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 55a:	8ba6                	mv	s7,s1
      state = 0;
 55c:	4981                	li	s3,0
        i += 2;
 55e:	bfa1                	j	4b6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 0);
 560:	008b8493          	addi	s1,s7,8
 564:	4681                	li	a3,0
 566:	4629                	li	a2,10
 568:	000ba583          	lw	a1,0(s7)
 56c:	855a                	mv	a0,s6
 56e:	e61ff0ef          	jal	3ce <printint>
 572:	8ba6                	mv	s7,s1
      state = 0;
 574:	4981                	li	s3,0
 576:	b781                	j	4b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 578:	008b8493          	addi	s1,s7,8
 57c:	4681                	li	a3,0
 57e:	4629                	li	a2,10
 580:	000ba583          	lw	a1,0(s7)
 584:	855a                	mv	a0,s6
 586:	e49ff0ef          	jal	3ce <printint>
        i += 1;
 58a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 58c:	8ba6                	mv	s7,s1
      state = 0;
 58e:	4981                	li	s3,0
 590:	b71d                	j	4b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 592:	008b8493          	addi	s1,s7,8
 596:	4681                	li	a3,0
 598:	4629                	li	a2,10
 59a:	000ba583          	lw	a1,0(s7)
 59e:	855a                	mv	a0,s6
 5a0:	e2fff0ef          	jal	3ce <printint>
        i += 2;
 5a4:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 5a6:	8ba6                	mv	s7,s1
      state = 0;
 5a8:	4981                	li	s3,0
        i += 2;
 5aa:	b731                	j	4b6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 5ac:	008b8493          	addi	s1,s7,8
 5b0:	4681                	li	a3,0
 5b2:	4641                	li	a2,16
 5b4:	000ba583          	lw	a1,0(s7)
 5b8:	855a                	mv	a0,s6
 5ba:	e15ff0ef          	jal	3ce <printint>
 5be:	8ba6                	mv	s7,s1
      state = 0;
 5c0:	4981                	li	s3,0
 5c2:	bdd5                	j	4b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5c4:	008b8493          	addi	s1,s7,8
 5c8:	4681                	li	a3,0
 5ca:	4641                	li	a2,16
 5cc:	000ba583          	lw	a1,0(s7)
 5d0:	855a                	mv	a0,s6
 5d2:	dfdff0ef          	jal	3ce <printint>
        i += 1;
 5d6:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 5d8:	8ba6                	mv	s7,s1
      state = 0;
 5da:	4981                	li	s3,0
 5dc:	bde9                	j	4b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5de:	008b8493          	addi	s1,s7,8
 5e2:	4681                	li	a3,0
 5e4:	4641                	li	a2,16
 5e6:	000ba583          	lw	a1,0(s7)
 5ea:	855a                	mv	a0,s6
 5ec:	de3ff0ef          	jal	3ce <printint>
        i += 2;
 5f0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 5f2:	8ba6                	mv	s7,s1
      state = 0;
 5f4:	4981                	li	s3,0
        i += 2;
 5f6:	b5c1                	j	4b6 <vprintf+0x44>
 5f8:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 5fa:	008b8793          	addi	a5,s7,8
 5fe:	8cbe                	mv	s9,a5
 600:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 604:	03000593          	li	a1,48
 608:	855a                	mv	a0,s6
 60a:	da7ff0ef          	jal	3b0 <putc>
  putc(fd, 'x');
 60e:	07800593          	li	a1,120
 612:	855a                	mv	a0,s6
 614:	d9dff0ef          	jal	3b0 <putc>
 618:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 61a:	00000b97          	auipc	s7,0x0
 61e:	2eeb8b93          	addi	s7,s7,750 # 908 <digits>
 622:	03c9d793          	srli	a5,s3,0x3c
 626:	97de                	add	a5,a5,s7
 628:	0007c583          	lbu	a1,0(a5)
 62c:	855a                	mv	a0,s6
 62e:	d83ff0ef          	jal	3b0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 632:	0992                	slli	s3,s3,0x4
 634:	34fd                	addiw	s1,s1,-1
 636:	f4f5                	bnez	s1,622 <vprintf+0x1b0>
        printptr(fd, va_arg(ap, uint64));
 638:	8be6                	mv	s7,s9
      state = 0;
 63a:	4981                	li	s3,0
 63c:	6ca2                	ld	s9,8(sp)
 63e:	bda5                	j	4b6 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 640:	008b8993          	addi	s3,s7,8
 644:	000bb483          	ld	s1,0(s7)
 648:	cc91                	beqz	s1,664 <vprintf+0x1f2>
        for(; *s; s++)
 64a:	0004c583          	lbu	a1,0(s1)
 64e:	c985                	beqz	a1,67e <vprintf+0x20c>
          putc(fd, *s);
 650:	855a                	mv	a0,s6
 652:	d5fff0ef          	jal	3b0 <putc>
        for(; *s; s++)
 656:	0485                	addi	s1,s1,1
 658:	0004c583          	lbu	a1,0(s1)
 65c:	f9f5                	bnez	a1,650 <vprintf+0x1de>
        if((s = va_arg(ap, char*)) == 0)
 65e:	8bce                	mv	s7,s3
      state = 0;
 660:	4981                	li	s3,0
 662:	bd91                	j	4b6 <vprintf+0x44>
          s = "(null)";
 664:	00000497          	auipc	s1,0x0
 668:	29c48493          	addi	s1,s1,668 # 900 <malloc+0x108>
        for(; *s; s++)
 66c:	02800593          	li	a1,40
 670:	b7c5                	j	650 <vprintf+0x1de>
        putc(fd, '%');
 672:	85be                	mv	a1,a5
 674:	855a                	mv	a0,s6
 676:	d3bff0ef          	jal	3b0 <putc>
      state = 0;
 67a:	4981                	li	s3,0
 67c:	bd2d                	j	4b6 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 67e:	8bce                	mv	s7,s3
      state = 0;
 680:	4981                	li	s3,0
 682:	bd15                	j	4b6 <vprintf+0x44>
 684:	6906                	ld	s2,64(sp)
 686:	79e2                	ld	s3,56(sp)
 688:	7a42                	ld	s4,48(sp)
 68a:	7aa2                	ld	s5,40(sp)
 68c:	7b02                	ld	s6,32(sp)
 68e:	6be2                	ld	s7,24(sp)
 690:	6c42                	ld	s8,16(sp)
    }
  }
}
 692:	60e6                	ld	ra,88(sp)
 694:	6446                	ld	s0,80(sp)
 696:	64a6                	ld	s1,72(sp)
 698:	6125                	addi	sp,sp,96
 69a:	8082                	ret
      if(c0 == 'd'){
 69c:	06400713          	li	a4,100
 6a0:	e6e789e3          	beq	a5,a4,512 <vprintf+0xa0>
      } else if(c0 == 'l' && c1 == 'd'){
 6a4:	f9478693          	addi	a3,a5,-108
 6a8:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 6ac:	85b2                	mv	a1,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6ae:	4701                	li	a4,0
      } else if(c0 == 'u'){
 6b0:	07500513          	li	a0,117
 6b4:	eaa786e3          	beq	a5,a0,560 <vprintf+0xee>
      } else if(c0 == 'l' && c1 == 'u'){
 6b8:	f8b60513          	addi	a0,a2,-117
 6bc:	e119                	bnez	a0,6c2 <vprintf+0x250>
 6be:	ea069de3          	bnez	a3,578 <vprintf+0x106>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6c2:	f8b58513          	addi	a0,a1,-117
 6c6:	e119                	bnez	a0,6cc <vprintf+0x25a>
 6c8:	ec0715e3          	bnez	a4,592 <vprintf+0x120>
      } else if(c0 == 'x'){
 6cc:	07800513          	li	a0,120
 6d0:	eca78ee3          	beq	a5,a0,5ac <vprintf+0x13a>
      } else if(c0 == 'l' && c1 == 'x'){
 6d4:	f8860613          	addi	a2,a2,-120
 6d8:	e219                	bnez	a2,6de <vprintf+0x26c>
 6da:	ee0695e3          	bnez	a3,5c4 <vprintf+0x152>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6de:	f8858593          	addi	a1,a1,-120
 6e2:	e199                	bnez	a1,6e8 <vprintf+0x276>
 6e4:	ee071de3          	bnez	a4,5de <vprintf+0x16c>
      } else if(c0 == 'p'){
 6e8:	07000713          	li	a4,112
 6ec:	f0e786e3          	beq	a5,a4,5f8 <vprintf+0x186>
      } else if(c0 == 's'){
 6f0:	07300713          	li	a4,115
 6f4:	f4e786e3          	beq	a5,a4,640 <vprintf+0x1ce>
      } else if(c0 == '%'){
 6f8:	02500713          	li	a4,37
 6fc:	f6e78be3          	beq	a5,a4,672 <vprintf+0x200>
        putc(fd, '%');
 700:	02500593          	li	a1,37
 704:	855a                	mv	a0,s6
 706:	cabff0ef          	jal	3b0 <putc>
        putc(fd, c0);
 70a:	85a6                	mv	a1,s1
 70c:	855a                	mv	a0,s6
 70e:	ca3ff0ef          	jal	3b0 <putc>
      state = 0;
 712:	4981                	li	s3,0
 714:	b34d                	j	4b6 <vprintf+0x44>

0000000000000716 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 716:	715d                	addi	sp,sp,-80
 718:	ec06                	sd	ra,24(sp)
 71a:	e822                	sd	s0,16(sp)
 71c:	1000                	addi	s0,sp,32
 71e:	e010                	sd	a2,0(s0)
 720:	e414                	sd	a3,8(s0)
 722:	e818                	sd	a4,16(s0)
 724:	ec1c                	sd	a5,24(s0)
 726:	03043023          	sd	a6,32(s0)
 72a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 72e:	8622                	mv	a2,s0
 730:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 734:	d3fff0ef          	jal	472 <vprintf>
}
 738:	60e2                	ld	ra,24(sp)
 73a:	6442                	ld	s0,16(sp)
 73c:	6161                	addi	sp,sp,80
 73e:	8082                	ret

0000000000000740 <printf>:

void
printf(const char *fmt, ...)
{
 740:	711d                	addi	sp,sp,-96
 742:	ec06                	sd	ra,24(sp)
 744:	e822                	sd	s0,16(sp)
 746:	1000                	addi	s0,sp,32
 748:	e40c                	sd	a1,8(s0)
 74a:	e810                	sd	a2,16(s0)
 74c:	ec14                	sd	a3,24(s0)
 74e:	f018                	sd	a4,32(s0)
 750:	f41c                	sd	a5,40(s0)
 752:	03043823          	sd	a6,48(s0)
 756:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 75a:	00840613          	addi	a2,s0,8
 75e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 762:	85aa                	mv	a1,a0
 764:	4505                	li	a0,1
 766:	d0dff0ef          	jal	472 <vprintf>
}
 76a:	60e2                	ld	ra,24(sp)
 76c:	6442                	ld	s0,16(sp)
 76e:	6125                	addi	sp,sp,96
 770:	8082                	ret

0000000000000772 <free>:
static Header base;
static Header *freep;

void
free (void *ap)
{
 772:	1141                	addi	sp,sp,-16
 774:	e406                	sd	ra,8(sp)
 776:	e022                	sd	s0,0(sp)
 778:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 77a:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 77e:	00001797          	auipc	a5,0x1
 782:	8827b783          	ld	a5,-1918(a5) # 1000 <freep>
 786:	a039                	j	794 <free+0x22>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 788:	6398                	ld	a4,0(a5)
 78a:	00e7e463          	bltu	a5,a4,792 <free+0x20>
 78e:	00e6ea63          	bltu	a3,a4,7a2 <free+0x30>
{
 792:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 794:	fed7fae3          	bgeu	a5,a3,788 <free+0x16>
 798:	6398                	ld	a4,0(a5)
 79a:	00e6e463          	bltu	a3,a4,7a2 <free+0x30>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 79e:	fee7eae3          	bltu	a5,a4,792 <free+0x20>
      break;
  if (bp + bp->s.size == p->s.ptr)
 7a2:	ff852583          	lw	a1,-8(a0)
 7a6:	6390                	ld	a2,0(a5)
 7a8:	02059813          	slli	a6,a1,0x20
 7ac:	01c85713          	srli	a4,a6,0x1c
 7b0:	9736                	add	a4,a4,a3
 7b2:	02e60563          	beq	a2,a4,7dc <free+0x6a>
    {
      bp->s.size += p->s.ptr->s.size;
      bp->s.ptr = p->s.ptr->s.ptr;
 7b6:	fec53823          	sd	a2,-16(a0)
    }
  else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp)
 7ba:	4790                	lw	a2,8(a5)
 7bc:	02061593          	slli	a1,a2,0x20
 7c0:	01c5d713          	srli	a4,a1,0x1c
 7c4:	973e                	add	a4,a4,a5
 7c6:	02e68263          	beq	a3,a4,7ea <free+0x78>
    {
      p->s.size += bp->s.size;
      p->s.ptr = bp->s.ptr;
 7ca:	e394                	sd	a3,0(a5)
    }
  else
    p->s.ptr = bp;
  freep = p;
 7cc:	00001717          	auipc	a4,0x1
 7d0:	82f73a23          	sd	a5,-1996(a4) # 1000 <freep>
}
 7d4:	60a2                	ld	ra,8(sp)
 7d6:	6402                	ld	s0,0(sp)
 7d8:	0141                	addi	sp,sp,16
 7da:	8082                	ret
      bp->s.size += p->s.ptr->s.size;
 7dc:	4618                	lw	a4,8(a2)
 7de:	9f2d                	addw	a4,a4,a1
 7e0:	fee52c23          	sw	a4,-8(a0)
      bp->s.ptr = p->s.ptr->s.ptr;
 7e4:	6398                	ld	a4,0(a5)
 7e6:	6310                	ld	a2,0(a4)
 7e8:	b7f9                	j	7b6 <free+0x44>
      p->s.size += bp->s.size;
 7ea:	ff852703          	lw	a4,-8(a0)
 7ee:	9f31                	addw	a4,a4,a2
 7f0:	c798                	sw	a4,8(a5)
      p->s.ptr = bp->s.ptr;
 7f2:	ff053683          	ld	a3,-16(a0)
 7f6:	bfd1                	j	7ca <free+0x58>

00000000000007f8 <malloc>:
  return freep;
}

void *
malloc (uint nbytes)
{
 7f8:	7139                	addi	sp,sp,-64
 7fa:	fc06                	sd	ra,56(sp)
 7fc:	f822                	sd	s0,48(sp)
 7fe:	f04a                	sd	s2,32(sp)
 800:	ec4e                	sd	s3,24(sp)
 802:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof (Header) - 1) / sizeof (Header) + 1;
 804:	02051993          	slli	s3,a0,0x20
 808:	0209d993          	srli	s3,s3,0x20
 80c:	09bd                	addi	s3,s3,15
 80e:	0049d993          	srli	s3,s3,0x4
 812:	2985                	addiw	s3,s3,1
 814:	894e                	mv	s2,s3
  if ((prevp = freep) == 0)
 816:	00000517          	auipc	a0,0x0
 81a:	7ea53503          	ld	a0,2026(a0) # 1000 <freep>
 81e:	c905                	beqz	a0,84e <malloc+0x56>
    {
      base.s.ptr = freep = prevp = &base;
      base.s.size = 0;
    }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 820:	611c                	ld	a5,0(a0)
    {
      if (p->s.size >= nunits)
 822:	4798                	lw	a4,8(a5)
 824:	09377663          	bgeu	a4,s3,8b0 <malloc+0xb8>
 828:	f426                	sd	s1,40(sp)
 82a:	e852                	sd	s4,16(sp)
 82c:	e456                	sd	s5,8(sp)
 82e:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 830:	8a4e                	mv	s4,s3
 832:	6705                	lui	a4,0x1
 834:	00e9f363          	bgeu	s3,a4,83a <malloc+0x42>
 838:	6a05                	lui	s4,0x1
 83a:	000a0b1b          	sext.w	s6,s4
  p = sbrk (nu * sizeof (Header));
 83e:	004a1a1b          	slliw	s4,s4,0x4
              p->s.size = nunits;
            }
          freep = prevp;
          return (void *)(p + 1);
        }
      if (p == freep)
 842:	00000497          	auipc	s1,0x0
 846:	7be48493          	addi	s1,s1,1982 # 1000 <freep>
  if (p == (char *)-1)
 84a:	5afd                	li	s5,-1
 84c:	a83d                	j	88a <malloc+0x92>
 84e:	f426                	sd	s1,40(sp)
 850:	e852                	sd	s4,16(sp)
 852:	e456                	sd	s5,8(sp)
 854:	e05a                	sd	s6,0(sp)
      base.s.ptr = freep = prevp = &base;
 856:	00000797          	auipc	a5,0x0
 85a:	7ba78793          	addi	a5,a5,1978 # 1010 <base>
 85e:	00000717          	auipc	a4,0x0
 862:	7af73123          	sd	a5,1954(a4) # 1000 <freep>
 866:	e39c                	sd	a5,0(a5)
      base.s.size = 0;
 868:	0007a423          	sw	zero,8(a5)
      if (p->s.size >= nunits)
 86c:	b7d1                	j	830 <malloc+0x38>
            prevp->s.ptr = p->s.ptr;
 86e:	6398                	ld	a4,0(a5)
 870:	e118                	sd	a4,0(a0)
 872:	a899                	j	8c8 <malloc+0xd0>
  hp->s.size = nu;
 874:	01652423          	sw	s6,8(a0)
  free ((void *)(hp + 1));
 878:	0541                	addi	a0,a0,16
 87a:	ef9ff0ef          	jal	772 <free>
  return freep;
 87e:	6088                	ld	a0,0(s1)
        if ((p = morecore (nunits)) == 0)
 880:	c125                	beqz	a0,8e0 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 882:	611c                	ld	a5,0(a0)
      if (p->s.size >= nunits)
 884:	4798                	lw	a4,8(a5)
 886:	03277163          	bgeu	a4,s2,8a8 <malloc+0xb0>
      if (p == freep)
 88a:	6098                	ld	a4,0(s1)
 88c:	853e                	mv	a0,a5
 88e:	fef71ae3          	bne	a4,a5,882 <malloc+0x8a>
  p = sbrk (nu * sizeof (Header));
 892:	8552                	mv	a0,s4
 894:	afdff0ef          	jal	390 <sbrk>
  if (p == (char *)-1)
 898:	fd551ee3          	bne	a0,s5,874 <malloc+0x7c>
          return 0;
 89c:	4501                	li	a0,0
 89e:	74a2                	ld	s1,40(sp)
 8a0:	6a42                	ld	s4,16(sp)
 8a2:	6aa2                	ld	s5,8(sp)
 8a4:	6b02                	ld	s6,0(sp)
 8a6:	a03d                	j	8d4 <malloc+0xdc>
 8a8:	74a2                	ld	s1,40(sp)
 8aa:	6a42                	ld	s4,16(sp)
 8ac:	6aa2                	ld	s5,8(sp)
 8ae:	6b02                	ld	s6,0(sp)
          if (p->s.size == nunits)
 8b0:	fae90fe3          	beq	s2,a4,86e <malloc+0x76>
              p->s.size -= nunits;
 8b4:	4137073b          	subw	a4,a4,s3
 8b8:	c798                	sw	a4,8(a5)
              p += p->s.size;
 8ba:	02071693          	slli	a3,a4,0x20
 8be:	01c6d713          	srli	a4,a3,0x1c
 8c2:	97ba                	add	a5,a5,a4
              p->s.size = nunits;
 8c4:	0137a423          	sw	s3,8(a5)
          freep = prevp;
 8c8:	00000717          	auipc	a4,0x0
 8cc:	72a73c23          	sd	a0,1848(a4) # 1000 <freep>
          return (void *)(p + 1);
 8d0:	01078513          	addi	a0,a5,16
    }
}
 8d4:	70e2                	ld	ra,56(sp)
 8d6:	7442                	ld	s0,48(sp)
 8d8:	7902                	ld	s2,32(sp)
 8da:	69e2                	ld	s3,24(sp)
 8dc:	6121                	addi	sp,sp,64
 8de:	8082                	ret
 8e0:	74a2                	ld	s1,40(sp)
 8e2:	6a42                	ld	s4,16(sp)
 8e4:	6aa2                	ld	s5,8(sp)
 8e6:	6b02                	ld	s6,0(sp)
 8e8:	b7f5                	j	8d4 <malloc+0xdc>
