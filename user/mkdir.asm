
user/_mkdir:     file format elf64-littleriscv


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
    fprintf(2, "Usage: mkdir files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  26:	6088                	ld	a0,0(s1)
  28:	332000ef          	jal	35a <mkdir>
  2c:	02054463          	bltz	a0,54 <main+0x54>
  for(i = 1; i < argc; i++){
  30:	04a1                	addi	s1,s1,8
  32:	ff249ae3          	bne	s1,s2,26 <main+0x26>
      fprintf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit(0);
  36:	4501                	li	a0,0
  38:	2ba000ef          	jal	2f2 <exit>
  3c:	e426                	sd	s1,8(sp)
  3e:	e04a                	sd	s2,0(sp)
    fprintf(2, "Usage: mkdir files...\n");
  40:	00001597          	auipc	a1,0x1
  44:	8a058593          	addi	a1,a1,-1888 # 8e0 <malloc+0xfe>
  48:	4509                	li	a0,2
  4a:	6b6000ef          	jal	700 <fprintf>
    exit(1);
  4e:	4505                	li	a0,1
  50:	2a2000ef          	jal	2f2 <exit>
      fprintf(2, "mkdir: %s failed to create\n", argv[i]);
  54:	6090                	ld	a2,0(s1)
  56:	00001597          	auipc	a1,0x1
  5a:	8a258593          	addi	a1,a1,-1886 # 8f8 <malloc+0x116>
  5e:	4509                	li	a0,2
  60:	6a0000ef          	jal	700 <fprintf>
      break;
  64:	bfc9                	j	36 <main+0x36>

0000000000000066 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start ()
{
  66:	1141                	addi	sp,sp,-16
  68:	e406                	sd	ra,8(sp)
  6a:	e022                	sd	s0,0(sp)
  6c:	0800                	addi	s0,sp,16
  extern int main ();
  main ();
  6e:	f93ff0ef          	jal	0 <main>
  exit (0);
  72:	4501                	li	a0,0
  74:	27e000ef          	jal	2f2 <exit>

0000000000000078 <strcpy>:
}

char *
strcpy (char *s, const char *t)
{
  78:	1141                	addi	sp,sp,-16
  7a:	e406                	sd	ra,8(sp)
  7c:	e022                	sd	s0,0(sp)
  7e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  80:	87aa                	mv	a5,a0
  82:	0585                	addi	a1,a1,1
  84:	0785                	addi	a5,a5,1
  86:	fff5c703          	lbu	a4,-1(a1)
  8a:	fee78fa3          	sb	a4,-1(a5)
  8e:	fb75                	bnez	a4,82 <strcpy+0xa>
    ;
  return os;
}
  90:	60a2                	ld	ra,8(sp)
  92:	6402                	ld	s0,0(sp)
  94:	0141                	addi	sp,sp,16
  96:	8082                	ret

0000000000000098 <strcmp>:

int
strcmp (const char *p, const char *q)
{
  98:	1141                	addi	sp,sp,-16
  9a:	e406                	sd	ra,8(sp)
  9c:	e022                	sd	s0,0(sp)
  9e:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  a0:	00054783          	lbu	a5,0(a0)
  a4:	cb91                	beqz	a5,b8 <strcmp+0x20>
  a6:	0005c703          	lbu	a4,0(a1)
  aa:	00f71763          	bne	a4,a5,b8 <strcmp+0x20>
    p++, q++;
  ae:	0505                	addi	a0,a0,1
  b0:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  b2:	00054783          	lbu	a5,0(a0)
  b6:	fbe5                	bnez	a5,a6 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  b8:	0005c503          	lbu	a0,0(a1)
}
  bc:	40a7853b          	subw	a0,a5,a0
  c0:	60a2                	ld	ra,8(sp)
  c2:	6402                	ld	s0,0(sp)
  c4:	0141                	addi	sp,sp,16
  c6:	8082                	ret

00000000000000c8 <strlen>:

uint
strlen (const char *s)
{
  c8:	1141                	addi	sp,sp,-16
  ca:	e406                	sd	ra,8(sp)
  cc:	e022                	sd	s0,0(sp)
  ce:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  d0:	00054783          	lbu	a5,0(a0)
  d4:	cf91                	beqz	a5,f0 <strlen+0x28>
  d6:	00150793          	addi	a5,a0,1
  da:	86be                	mv	a3,a5
  dc:	0785                	addi	a5,a5,1
  de:	fff7c703          	lbu	a4,-1(a5)
  e2:	ff65                	bnez	a4,da <strlen+0x12>
  e4:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  e8:	60a2                	ld	ra,8(sp)
  ea:	6402                	ld	s0,0(sp)
  ec:	0141                	addi	sp,sp,16
  ee:	8082                	ret
  for (n = 0; s[n]; n++)
  f0:	4501                	li	a0,0
  f2:	bfdd                	j	e8 <strlen+0x20>

00000000000000f4 <memset>:

void *
memset (void *dst, int c, uint n)
{
  f4:	1141                	addi	sp,sp,-16
  f6:	e406                	sd	ra,8(sp)
  f8:	e022                	sd	s0,0(sp)
  fa:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
  fc:	ca19                	beqz	a2,112 <memset+0x1e>
  fe:	87aa                	mv	a5,a0
 100:	1602                	slli	a2,a2,0x20
 102:	9201                	srli	a2,a2,0x20
 104:	00a60733          	add	a4,a2,a0
    {
      cdst[i] = c;
 108:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 10c:	0785                	addi	a5,a5,1
 10e:	fee79de3          	bne	a5,a4,108 <memset+0x14>
    }
  return dst;
}
 112:	60a2                	ld	ra,8(sp)
 114:	6402                	ld	s0,0(sp)
 116:	0141                	addi	sp,sp,16
 118:	8082                	ret

000000000000011a <strchr>:

char *
strchr (const char *s, char c)
{
 11a:	1141                	addi	sp,sp,-16
 11c:	e406                	sd	ra,8(sp)
 11e:	e022                	sd	s0,0(sp)
 120:	0800                	addi	s0,sp,16
  for (; *s; s++)
 122:	00054783          	lbu	a5,0(a0)
 126:	cf81                	beqz	a5,13e <strchr+0x24>
    if (*s == c)
 128:	00f58763          	beq	a1,a5,136 <strchr+0x1c>
  for (; *s; s++)
 12c:	0505                	addi	a0,a0,1
 12e:	00054783          	lbu	a5,0(a0)
 132:	fbfd                	bnez	a5,128 <strchr+0xe>
      return (char *)s;
  return 0;
 134:	4501                	li	a0,0
}
 136:	60a2                	ld	ra,8(sp)
 138:	6402                	ld	s0,0(sp)
 13a:	0141                	addi	sp,sp,16
 13c:	8082                	ret
  return 0;
 13e:	4501                	li	a0,0
 140:	bfdd                	j	136 <strchr+0x1c>

0000000000000142 <gets>:

char *
gets (char *buf, int max)
{
 142:	711d                	addi	sp,sp,-96
 144:	ec86                	sd	ra,88(sp)
 146:	e8a2                	sd	s0,80(sp)
 148:	e4a6                	sd	s1,72(sp)
 14a:	e0ca                	sd	s2,64(sp)
 14c:	fc4e                	sd	s3,56(sp)
 14e:	f852                	sd	s4,48(sp)
 150:	f456                	sd	s5,40(sp)
 152:	f05a                	sd	s6,32(sp)
 154:	ec5e                	sd	s7,24(sp)
 156:	e862                	sd	s8,16(sp)
 158:	1080                	addi	s0,sp,96
 15a:	8baa                	mv	s7,a0
 15c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 15e:	892a                	mv	s2,a0
 160:	4481                	li	s1,0
    {
      cc = read (0, &c, 1);
 162:	faf40b13          	addi	s6,s0,-81
 166:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;)
 168:	8c26                	mv	s8,s1
 16a:	0014899b          	addiw	s3,s1,1
 16e:	84ce                	mv	s1,s3
 170:	0349d463          	bge	s3,s4,198 <gets+0x56>
      cc = read (0, &c, 1);
 174:	8656                	mv	a2,s5
 176:	85da                	mv	a1,s6
 178:	4501                	li	a0,0
 17a:	190000ef          	jal	30a <read>
      if (cc < 1)
 17e:	00a05d63          	blez	a0,198 <gets+0x56>
        break;
      buf[i++] = c;
 182:	faf44783          	lbu	a5,-81(s0)
 186:	00f90023          	sb	a5,0(s2)
      if (c == '\n' || c == '\r')
 18a:	0905                	addi	s2,s2,1
 18c:	ff678713          	addi	a4,a5,-10
 190:	c319                	beqz	a4,196 <gets+0x54>
 192:	17cd                	addi	a5,a5,-13
 194:	fbf1                	bnez	a5,168 <gets+0x26>
      buf[i++] = c;
 196:	8c4e                	mv	s8,s3
        break;
    }
  buf[i] = '\0';
 198:	9c5e                	add	s8,s8,s7
 19a:	000c0023          	sb	zero,0(s8)
  return buf;
}
 19e:	855e                	mv	a0,s7
 1a0:	60e6                	ld	ra,88(sp)
 1a2:	6446                	ld	s0,80(sp)
 1a4:	64a6                	ld	s1,72(sp)
 1a6:	6906                	ld	s2,64(sp)
 1a8:	79e2                	ld	s3,56(sp)
 1aa:	7a42                	ld	s4,48(sp)
 1ac:	7aa2                	ld	s5,40(sp)
 1ae:	7b02                	ld	s6,32(sp)
 1b0:	6be2                	ld	s7,24(sp)
 1b2:	6c42                	ld	s8,16(sp)
 1b4:	6125                	addi	sp,sp,96
 1b6:	8082                	ret

00000000000001b8 <stat>:

int
stat (const char *n, struct stat *st)
{
 1b8:	1101                	addi	sp,sp,-32
 1ba:	ec06                	sd	ra,24(sp)
 1bc:	e822                	sd	s0,16(sp)
 1be:	e04a                	sd	s2,0(sp)
 1c0:	1000                	addi	s0,sp,32
 1c2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open (n, O_RDONLY);
 1c4:	4581                	li	a1,0
 1c6:	16c000ef          	jal	332 <open>
  if (fd < 0)
 1ca:	02054263          	bltz	a0,1ee <stat+0x36>
 1ce:	e426                	sd	s1,8(sp)
 1d0:	84aa                	mv	s1,a0
    return -1;
  r = fstat (fd, st);
 1d2:	85ca                	mv	a1,s2
 1d4:	176000ef          	jal	34a <fstat>
 1d8:	892a                	mv	s2,a0
  close (fd);
 1da:	8526                	mv	a0,s1
 1dc:	13e000ef          	jal	31a <close>
  return r;
 1e0:	64a2                	ld	s1,8(sp)
}
 1e2:	854a                	mv	a0,s2
 1e4:	60e2                	ld	ra,24(sp)
 1e6:	6442                	ld	s0,16(sp)
 1e8:	6902                	ld	s2,0(sp)
 1ea:	6105                	addi	sp,sp,32
 1ec:	8082                	ret
    return -1;
 1ee:	57fd                	li	a5,-1
 1f0:	893e                	mv	s2,a5
 1f2:	bfc5                	j	1e2 <stat+0x2a>

00000000000001f4 <atoi>:

int
atoi (const char *s)
{
 1f4:	1141                	addi	sp,sp,-16
 1f6:	e406                	sd	ra,8(sp)
 1f8:	e022                	sd	s0,0(sp)
 1fa:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 1fc:	00054683          	lbu	a3,0(a0)
 200:	fd06879b          	addiw	a5,a3,-48
 204:	0ff7f793          	zext.b	a5,a5
 208:	4625                	li	a2,9
 20a:	02f66963          	bltu	a2,a5,23c <atoi+0x48>
 20e:	872a                	mv	a4,a0
  n = 0;
 210:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 212:	0705                	addi	a4,a4,1
 214:	0025179b          	slliw	a5,a0,0x2
 218:	9fa9                	addw	a5,a5,a0
 21a:	0017979b          	slliw	a5,a5,0x1
 21e:	9fb5                	addw	a5,a5,a3
 220:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 224:	00074683          	lbu	a3,0(a4)
 228:	fd06879b          	addiw	a5,a3,-48
 22c:	0ff7f793          	zext.b	a5,a5
 230:	fef671e3          	bgeu	a2,a5,212 <atoi+0x1e>
  return n;
}
 234:	60a2                	ld	ra,8(sp)
 236:	6402                	ld	s0,0(sp)
 238:	0141                	addi	sp,sp,16
 23a:	8082                	ret
  n = 0;
 23c:	4501                	li	a0,0
 23e:	bfdd                	j	234 <atoi+0x40>

0000000000000240 <memmove>:

void *
memmove (void *vdst, const void *vsrc, int n)
{
 240:	1141                	addi	sp,sp,-16
 242:	e406                	sd	ra,8(sp)
 244:	e022                	sd	s0,0(sp)
 246:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 248:	02b57563          	bgeu	a0,a1,272 <memmove+0x32>
    {
      while (n-- > 0)
 24c:	00c05f63          	blez	a2,26a <memmove+0x2a>
 250:	1602                	slli	a2,a2,0x20
 252:	9201                	srli	a2,a2,0x20
 254:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 258:	872a                	mv	a4,a0
        *dst++ = *src++;
 25a:	0585                	addi	a1,a1,1
 25c:	0705                	addi	a4,a4,1
 25e:	fff5c683          	lbu	a3,-1(a1)
 262:	fed70fa3          	sb	a3,-1(a4)
      while (n-- > 0)
 266:	fee79ae3          	bne	a5,a4,25a <memmove+0x1a>
      src += n;
      while (n-- > 0)
        *--dst = *--src;
    }
  return vdst;
}
 26a:	60a2                	ld	ra,8(sp)
 26c:	6402                	ld	s0,0(sp)
 26e:	0141                	addi	sp,sp,16
 270:	8082                	ret
      while (n-- > 0)
 272:	fec05ce3          	blez	a2,26a <memmove+0x2a>
      dst += n;
 276:	00c50733          	add	a4,a0,a2
      src += n;
 27a:	95b2                	add	a1,a1,a2
 27c:	fff6079b          	addiw	a5,a2,-1
 280:	1782                	slli	a5,a5,0x20
 282:	9381                	srli	a5,a5,0x20
 284:	fff7c793          	not	a5,a5
 288:	97ba                	add	a5,a5,a4
        *--dst = *--src;
 28a:	15fd                	addi	a1,a1,-1
 28c:	177d                	addi	a4,a4,-1
 28e:	0005c683          	lbu	a3,0(a1)
 292:	00d70023          	sb	a3,0(a4)
      while (n-- > 0)
 296:	fef71ae3          	bne	a4,a5,28a <memmove+0x4a>
 29a:	bfc1                	j	26a <memmove+0x2a>

000000000000029c <memcmp>:

int
memcmp (const void *s1, const void *s2, uint n)
{
 29c:	1141                	addi	sp,sp,-16
 29e:	e406                	sd	ra,8(sp)
 2a0:	e022                	sd	s0,0(sp)
 2a2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 2a4:	c61d                	beqz	a2,2d2 <memcmp+0x36>
 2a6:	1602                	slli	a2,a2,0x20
 2a8:	9201                	srli	a2,a2,0x20
 2aa:	00c506b3          	add	a3,a0,a2
    {
      if (*p1 != *p2)
 2ae:	00054783          	lbu	a5,0(a0)
 2b2:	0005c703          	lbu	a4,0(a1)
 2b6:	00e79863          	bne	a5,a4,2c6 <memcmp+0x2a>
        {
          return *p1 - *p2;
        }
      p1++;
 2ba:	0505                	addi	a0,a0,1
      p2++;
 2bc:	0585                	addi	a1,a1,1
  while (n-- > 0)
 2be:	fed518e3          	bne	a0,a3,2ae <memcmp+0x12>
    }
  return 0;
 2c2:	4501                	li	a0,0
 2c4:	a019                	j	2ca <memcmp+0x2e>
          return *p1 - *p2;
 2c6:	40e7853b          	subw	a0,a5,a4
}
 2ca:	60a2                	ld	ra,8(sp)
 2cc:	6402                	ld	s0,0(sp)
 2ce:	0141                	addi	sp,sp,16
 2d0:	8082                	ret
  return 0;
 2d2:	4501                	li	a0,0
 2d4:	bfdd                	j	2ca <memcmp+0x2e>

00000000000002d6 <memcpy>:

void *
memcpy (void *dst, const void *src, uint n)
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e406                	sd	ra,8(sp)
 2da:	e022                	sd	s0,0(sp)
 2dc:	0800                	addi	s0,sp,16
  return memmove (dst, src, n);
 2de:	f63ff0ef          	jal	240 <memmove>
}
 2e2:	60a2                	ld	ra,8(sp)
 2e4:	6402                	ld	s0,0(sp)
 2e6:	0141                	addi	sp,sp,16
 2e8:	8082                	ret

00000000000002ea <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2ea:	4885                	li	a7,1
 ecall
 2ec:	00000073          	ecall
 ret
 2f0:	8082                	ret

00000000000002f2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2f2:	4889                	li	a7,2
 ecall
 2f4:	00000073          	ecall
 ret
 2f8:	8082                	ret

00000000000002fa <wait>:
.global wait
wait:
 li a7, SYS_wait
 2fa:	488d                	li	a7,3
 ecall
 2fc:	00000073          	ecall
 ret
 300:	8082                	ret

0000000000000302 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 302:	4891                	li	a7,4
 ecall
 304:	00000073          	ecall
 ret
 308:	8082                	ret

000000000000030a <read>:
.global read
read:
 li a7, SYS_read
 30a:	4895                	li	a7,5
 ecall
 30c:	00000073          	ecall
 ret
 310:	8082                	ret

0000000000000312 <write>:
.global write
write:
 li a7, SYS_write
 312:	48c1                	li	a7,16
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <close>:
.global close
close:
 li a7, SYS_close
 31a:	48d5                	li	a7,21
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <kill>:
.global kill
kill:
 li a7, SYS_kill
 322:	4899                	li	a7,6
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <exec>:
.global exec
exec:
 li a7, SYS_exec
 32a:	489d                	li	a7,7
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <open>:
.global open
open:
 li a7, SYS_open
 332:	48bd                	li	a7,15
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 33a:	48c5                	li	a7,17
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 342:	48c9                	li	a7,18
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 34a:	48a1                	li	a7,8
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <link>:
.global link
link:
 li a7, SYS_link
 352:	48cd                	li	a7,19
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 35a:	48d1                	li	a7,20
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 362:	48a5                	li	a7,9
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <dup>:
.global dup
dup:
 li a7, SYS_dup
 36a:	48a9                	li	a7,10
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 372:	48ad                	li	a7,11
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 37a:	48b1                	li	a7,12
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 382:	48b5                	li	a7,13
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 38a:	48b9                	li	a7,14
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <trace>:
.global trace
trace:
 li a7, SYS_trace
 392:	48d9                	li	a7,22
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 39a:	1101                	addi	sp,sp,-32
 39c:	ec06                	sd	ra,24(sp)
 39e:	e822                	sd	s0,16(sp)
 3a0:	1000                	addi	s0,sp,32
 3a2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3a6:	4605                	li	a2,1
 3a8:	fef40593          	addi	a1,s0,-17
 3ac:	f67ff0ef          	jal	312 <write>
}
 3b0:	60e2                	ld	ra,24(sp)
 3b2:	6442                	ld	s0,16(sp)
 3b4:	6105                	addi	sp,sp,32
 3b6:	8082                	ret

00000000000003b8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3b8:	7139                	addi	sp,sp,-64
 3ba:	fc06                	sd	ra,56(sp)
 3bc:	f822                	sd	s0,48(sp)
 3be:	f04a                	sd	s2,32(sp)
 3c0:	ec4e                	sd	s3,24(sp)
 3c2:	0080                	addi	s0,sp,64
 3c4:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3c6:	cac9                	beqz	a3,458 <printint+0xa0>
 3c8:	01f5d79b          	srliw	a5,a1,0x1f
 3cc:	c7d1                	beqz	a5,458 <printint+0xa0>
    neg = 1;
    x = -xx;
 3ce:	40b005bb          	negw	a1,a1
    neg = 1;
 3d2:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 3d4:	fc040993          	addi	s3,s0,-64
  neg = 0;
 3d8:	86ce                	mv	a3,s3
  i = 0;
 3da:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3dc:	00000817          	auipc	a6,0x0
 3e0:	54480813          	addi	a6,a6,1348 # 920 <digits>
 3e4:	88ba                	mv	a7,a4
 3e6:	0017051b          	addiw	a0,a4,1
 3ea:	872a                	mv	a4,a0
 3ec:	02c5f7bb          	remuw	a5,a1,a2
 3f0:	1782                	slli	a5,a5,0x20
 3f2:	9381                	srli	a5,a5,0x20
 3f4:	97c2                	add	a5,a5,a6
 3f6:	0007c783          	lbu	a5,0(a5)
 3fa:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3fe:	87ae                	mv	a5,a1
 400:	02c5d5bb          	divuw	a1,a1,a2
 404:	0685                	addi	a3,a3,1
 406:	fcc7ffe3          	bgeu	a5,a2,3e4 <printint+0x2c>
  if(neg)
 40a:	00030c63          	beqz	t1,422 <printint+0x6a>
    buf[i++] = '-';
 40e:	fd050793          	addi	a5,a0,-48
 412:	00878533          	add	a0,a5,s0
 416:	02d00793          	li	a5,45
 41a:	fef50823          	sb	a5,-16(a0)
 41e:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 422:	02e05563          	blez	a4,44c <printint+0x94>
 426:	f426                	sd	s1,40(sp)
 428:	377d                	addiw	a4,a4,-1
 42a:	00e984b3          	add	s1,s3,a4
 42e:	19fd                	addi	s3,s3,-1
 430:	99ba                	add	s3,s3,a4
 432:	1702                	slli	a4,a4,0x20
 434:	9301                	srli	a4,a4,0x20
 436:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 43a:	0004c583          	lbu	a1,0(s1)
 43e:	854a                	mv	a0,s2
 440:	f5bff0ef          	jal	39a <putc>
  while(--i >= 0)
 444:	14fd                	addi	s1,s1,-1
 446:	ff349ae3          	bne	s1,s3,43a <printint+0x82>
 44a:	74a2                	ld	s1,40(sp)
}
 44c:	70e2                	ld	ra,56(sp)
 44e:	7442                	ld	s0,48(sp)
 450:	7902                	ld	s2,32(sp)
 452:	69e2                	ld	s3,24(sp)
 454:	6121                	addi	sp,sp,64
 456:	8082                	ret
  neg = 0;
 458:	4301                	li	t1,0
 45a:	bfad                	j	3d4 <printint+0x1c>

000000000000045c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 45c:	711d                	addi	sp,sp,-96
 45e:	ec86                	sd	ra,88(sp)
 460:	e8a2                	sd	s0,80(sp)
 462:	e4a6                	sd	s1,72(sp)
 464:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 466:	0005c483          	lbu	s1,0(a1)
 46a:	20048963          	beqz	s1,67c <vprintf+0x220>
 46e:	e0ca                	sd	s2,64(sp)
 470:	fc4e                	sd	s3,56(sp)
 472:	f852                	sd	s4,48(sp)
 474:	f456                	sd	s5,40(sp)
 476:	f05a                	sd	s6,32(sp)
 478:	ec5e                	sd	s7,24(sp)
 47a:	e862                	sd	s8,16(sp)
 47c:	8b2a                	mv	s6,a0
 47e:	8a2e                	mv	s4,a1
 480:	8bb2                	mv	s7,a2
  state = 0;
 482:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 484:	4901                	li	s2,0
 486:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 488:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 48c:	06400c13          	li	s8,100
 490:	a00d                	j	4b2 <vprintf+0x56>
        putc(fd, c0);
 492:	85a6                	mv	a1,s1
 494:	855a                	mv	a0,s6
 496:	f05ff0ef          	jal	39a <putc>
 49a:	a019                	j	4a0 <vprintf+0x44>
    } else if(state == '%'){
 49c:	03598363          	beq	s3,s5,4c2 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 4a0:	0019079b          	addiw	a5,s2,1
 4a4:	893e                	mv	s2,a5
 4a6:	873e                	mv	a4,a5
 4a8:	97d2                	add	a5,a5,s4
 4aa:	0007c483          	lbu	s1,0(a5)
 4ae:	1c048063          	beqz	s1,66e <vprintf+0x212>
    c0 = fmt[i] & 0xff;
 4b2:	0004879b          	sext.w	a5,s1
    if(state == 0){
 4b6:	fe0993e3          	bnez	s3,49c <vprintf+0x40>
      if(c0 == '%'){
 4ba:	fd579ce3          	bne	a5,s5,492 <vprintf+0x36>
        state = '%';
 4be:	89be                	mv	s3,a5
 4c0:	b7c5                	j	4a0 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 4c2:	00ea06b3          	add	a3,s4,a4
 4c6:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 4ca:	1a060e63          	beqz	a2,686 <vprintf+0x22a>
      if(c0 == 'd'){
 4ce:	03878763          	beq	a5,s8,4fc <vprintf+0xa0>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4d2:	f9478693          	addi	a3,a5,-108
 4d6:	0016b693          	seqz	a3,a3
 4da:	f9c60593          	addi	a1,a2,-100
 4de:	e99d                	bnez	a1,514 <vprintf+0xb8>
 4e0:	ca95                	beqz	a3,514 <vprintf+0xb8>
        printint(fd, va_arg(ap, uint64), 10, 1);
 4e2:	008b8493          	addi	s1,s7,8
 4e6:	4685                	li	a3,1
 4e8:	4629                	li	a2,10
 4ea:	000ba583          	lw	a1,0(s7)
 4ee:	855a                	mv	a0,s6
 4f0:	ec9ff0ef          	jal	3b8 <printint>
        i += 1;
 4f4:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 4f6:	8ba6                	mv	s7,s1
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 4f8:	4981                	li	s3,0
 4fa:	b75d                	j	4a0 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 4fc:	008b8493          	addi	s1,s7,8
 500:	4685                	li	a3,1
 502:	4629                	li	a2,10
 504:	000ba583          	lw	a1,0(s7)
 508:	855a                	mv	a0,s6
 50a:	eafff0ef          	jal	3b8 <printint>
 50e:	8ba6                	mv	s7,s1
      state = 0;
 510:	4981                	li	s3,0
 512:	b779                	j	4a0 <vprintf+0x44>
      if(c1) c2 = fmt[i+2] & 0xff;
 514:	9752                	add	a4,a4,s4
 516:	00274583          	lbu	a1,2(a4)
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 51a:	f9460713          	addi	a4,a2,-108
 51e:	00173713          	seqz	a4,a4
 522:	8f75                	and	a4,a4,a3
 524:	f9c58513          	addi	a0,a1,-100
 528:	16051963          	bnez	a0,69a <vprintf+0x23e>
 52c:	16070763          	beqz	a4,69a <vprintf+0x23e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 530:	008b8493          	addi	s1,s7,8
 534:	4685                	li	a3,1
 536:	4629                	li	a2,10
 538:	000ba583          	lw	a1,0(s7)
 53c:	855a                	mv	a0,s6
 53e:	e7bff0ef          	jal	3b8 <printint>
        i += 2;
 542:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 544:	8ba6                	mv	s7,s1
      state = 0;
 546:	4981                	li	s3,0
        i += 2;
 548:	bfa1                	j	4a0 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 0);
 54a:	008b8493          	addi	s1,s7,8
 54e:	4681                	li	a3,0
 550:	4629                	li	a2,10
 552:	000ba583          	lw	a1,0(s7)
 556:	855a                	mv	a0,s6
 558:	e61ff0ef          	jal	3b8 <printint>
 55c:	8ba6                	mv	s7,s1
      state = 0;
 55e:	4981                	li	s3,0
 560:	b781                	j	4a0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 562:	008b8493          	addi	s1,s7,8
 566:	4681                	li	a3,0
 568:	4629                	li	a2,10
 56a:	000ba583          	lw	a1,0(s7)
 56e:	855a                	mv	a0,s6
 570:	e49ff0ef          	jal	3b8 <printint>
        i += 1;
 574:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 576:	8ba6                	mv	s7,s1
      state = 0;
 578:	4981                	li	s3,0
 57a:	b71d                	j	4a0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 57c:	008b8493          	addi	s1,s7,8
 580:	4681                	li	a3,0
 582:	4629                	li	a2,10
 584:	000ba583          	lw	a1,0(s7)
 588:	855a                	mv	a0,s6
 58a:	e2fff0ef          	jal	3b8 <printint>
        i += 2;
 58e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 590:	8ba6                	mv	s7,s1
      state = 0;
 592:	4981                	li	s3,0
        i += 2;
 594:	b731                	j	4a0 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 596:	008b8493          	addi	s1,s7,8
 59a:	4681                	li	a3,0
 59c:	4641                	li	a2,16
 59e:	000ba583          	lw	a1,0(s7)
 5a2:	855a                	mv	a0,s6
 5a4:	e15ff0ef          	jal	3b8 <printint>
 5a8:	8ba6                	mv	s7,s1
      state = 0;
 5aa:	4981                	li	s3,0
 5ac:	bdd5                	j	4a0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5ae:	008b8493          	addi	s1,s7,8
 5b2:	4681                	li	a3,0
 5b4:	4641                	li	a2,16
 5b6:	000ba583          	lw	a1,0(s7)
 5ba:	855a                	mv	a0,s6
 5bc:	dfdff0ef          	jal	3b8 <printint>
        i += 1;
 5c0:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 5c2:	8ba6                	mv	s7,s1
      state = 0;
 5c4:	4981                	li	s3,0
 5c6:	bde9                	j	4a0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5c8:	008b8493          	addi	s1,s7,8
 5cc:	4681                	li	a3,0
 5ce:	4641                	li	a2,16
 5d0:	000ba583          	lw	a1,0(s7)
 5d4:	855a                	mv	a0,s6
 5d6:	de3ff0ef          	jal	3b8 <printint>
        i += 2;
 5da:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 5dc:	8ba6                	mv	s7,s1
      state = 0;
 5de:	4981                	li	s3,0
        i += 2;
 5e0:	b5c1                	j	4a0 <vprintf+0x44>
 5e2:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 5e4:	008b8793          	addi	a5,s7,8
 5e8:	8cbe                	mv	s9,a5
 5ea:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5ee:	03000593          	li	a1,48
 5f2:	855a                	mv	a0,s6
 5f4:	da7ff0ef          	jal	39a <putc>
  putc(fd, 'x');
 5f8:	07800593          	li	a1,120
 5fc:	855a                	mv	a0,s6
 5fe:	d9dff0ef          	jal	39a <putc>
 602:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 604:	00000b97          	auipc	s7,0x0
 608:	31cb8b93          	addi	s7,s7,796 # 920 <digits>
 60c:	03c9d793          	srli	a5,s3,0x3c
 610:	97de                	add	a5,a5,s7
 612:	0007c583          	lbu	a1,0(a5)
 616:	855a                	mv	a0,s6
 618:	d83ff0ef          	jal	39a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 61c:	0992                	slli	s3,s3,0x4
 61e:	34fd                	addiw	s1,s1,-1
 620:	f4f5                	bnez	s1,60c <vprintf+0x1b0>
        printptr(fd, va_arg(ap, uint64));
 622:	8be6                	mv	s7,s9
      state = 0;
 624:	4981                	li	s3,0
 626:	6ca2                	ld	s9,8(sp)
 628:	bda5                	j	4a0 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 62a:	008b8993          	addi	s3,s7,8
 62e:	000bb483          	ld	s1,0(s7)
 632:	cc91                	beqz	s1,64e <vprintf+0x1f2>
        for(; *s; s++)
 634:	0004c583          	lbu	a1,0(s1)
 638:	c985                	beqz	a1,668 <vprintf+0x20c>
          putc(fd, *s);
 63a:	855a                	mv	a0,s6
 63c:	d5fff0ef          	jal	39a <putc>
        for(; *s; s++)
 640:	0485                	addi	s1,s1,1
 642:	0004c583          	lbu	a1,0(s1)
 646:	f9f5                	bnez	a1,63a <vprintf+0x1de>
        if((s = va_arg(ap, char*)) == 0)
 648:	8bce                	mv	s7,s3
      state = 0;
 64a:	4981                	li	s3,0
 64c:	bd91                	j	4a0 <vprintf+0x44>
          s = "(null)";
 64e:	00000497          	auipc	s1,0x0
 652:	2ca48493          	addi	s1,s1,714 # 918 <malloc+0x136>
        for(; *s; s++)
 656:	02800593          	li	a1,40
 65a:	b7c5                	j	63a <vprintf+0x1de>
        putc(fd, '%');
 65c:	85be                	mv	a1,a5
 65e:	855a                	mv	a0,s6
 660:	d3bff0ef          	jal	39a <putc>
      state = 0;
 664:	4981                	li	s3,0
 666:	bd2d                	j	4a0 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 668:	8bce                	mv	s7,s3
      state = 0;
 66a:	4981                	li	s3,0
 66c:	bd15                	j	4a0 <vprintf+0x44>
 66e:	6906                	ld	s2,64(sp)
 670:	79e2                	ld	s3,56(sp)
 672:	7a42                	ld	s4,48(sp)
 674:	7aa2                	ld	s5,40(sp)
 676:	7b02                	ld	s6,32(sp)
 678:	6be2                	ld	s7,24(sp)
 67a:	6c42                	ld	s8,16(sp)
    }
  }
}
 67c:	60e6                	ld	ra,88(sp)
 67e:	6446                	ld	s0,80(sp)
 680:	64a6                	ld	s1,72(sp)
 682:	6125                	addi	sp,sp,96
 684:	8082                	ret
      if(c0 == 'd'){
 686:	06400713          	li	a4,100
 68a:	e6e789e3          	beq	a5,a4,4fc <vprintf+0xa0>
      } else if(c0 == 'l' && c1 == 'd'){
 68e:	f9478693          	addi	a3,a5,-108
 692:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 696:	85b2                	mv	a1,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 698:	4701                	li	a4,0
      } else if(c0 == 'u'){
 69a:	07500513          	li	a0,117
 69e:	eaa786e3          	beq	a5,a0,54a <vprintf+0xee>
      } else if(c0 == 'l' && c1 == 'u'){
 6a2:	f8b60513          	addi	a0,a2,-117
 6a6:	e119                	bnez	a0,6ac <vprintf+0x250>
 6a8:	ea069de3          	bnez	a3,562 <vprintf+0x106>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6ac:	f8b58513          	addi	a0,a1,-117
 6b0:	e119                	bnez	a0,6b6 <vprintf+0x25a>
 6b2:	ec0715e3          	bnez	a4,57c <vprintf+0x120>
      } else if(c0 == 'x'){
 6b6:	07800513          	li	a0,120
 6ba:	eca78ee3          	beq	a5,a0,596 <vprintf+0x13a>
      } else if(c0 == 'l' && c1 == 'x'){
 6be:	f8860613          	addi	a2,a2,-120
 6c2:	e219                	bnez	a2,6c8 <vprintf+0x26c>
 6c4:	ee0695e3          	bnez	a3,5ae <vprintf+0x152>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6c8:	f8858593          	addi	a1,a1,-120
 6cc:	e199                	bnez	a1,6d2 <vprintf+0x276>
 6ce:	ee071de3          	bnez	a4,5c8 <vprintf+0x16c>
      } else if(c0 == 'p'){
 6d2:	07000713          	li	a4,112
 6d6:	f0e786e3          	beq	a5,a4,5e2 <vprintf+0x186>
      } else if(c0 == 's'){
 6da:	07300713          	li	a4,115
 6de:	f4e786e3          	beq	a5,a4,62a <vprintf+0x1ce>
      } else if(c0 == '%'){
 6e2:	02500713          	li	a4,37
 6e6:	f6e78be3          	beq	a5,a4,65c <vprintf+0x200>
        putc(fd, '%');
 6ea:	02500593          	li	a1,37
 6ee:	855a                	mv	a0,s6
 6f0:	cabff0ef          	jal	39a <putc>
        putc(fd, c0);
 6f4:	85a6                	mv	a1,s1
 6f6:	855a                	mv	a0,s6
 6f8:	ca3ff0ef          	jal	39a <putc>
      state = 0;
 6fc:	4981                	li	s3,0
 6fe:	b34d                	j	4a0 <vprintf+0x44>

0000000000000700 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 700:	715d                	addi	sp,sp,-80
 702:	ec06                	sd	ra,24(sp)
 704:	e822                	sd	s0,16(sp)
 706:	1000                	addi	s0,sp,32
 708:	e010                	sd	a2,0(s0)
 70a:	e414                	sd	a3,8(s0)
 70c:	e818                	sd	a4,16(s0)
 70e:	ec1c                	sd	a5,24(s0)
 710:	03043023          	sd	a6,32(s0)
 714:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 718:	8622                	mv	a2,s0
 71a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 71e:	d3fff0ef          	jal	45c <vprintf>
}
 722:	60e2                	ld	ra,24(sp)
 724:	6442                	ld	s0,16(sp)
 726:	6161                	addi	sp,sp,80
 728:	8082                	ret

000000000000072a <printf>:

void
printf(const char *fmt, ...)
{
 72a:	711d                	addi	sp,sp,-96
 72c:	ec06                	sd	ra,24(sp)
 72e:	e822                	sd	s0,16(sp)
 730:	1000                	addi	s0,sp,32
 732:	e40c                	sd	a1,8(s0)
 734:	e810                	sd	a2,16(s0)
 736:	ec14                	sd	a3,24(s0)
 738:	f018                	sd	a4,32(s0)
 73a:	f41c                	sd	a5,40(s0)
 73c:	03043823          	sd	a6,48(s0)
 740:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 744:	00840613          	addi	a2,s0,8
 748:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 74c:	85aa                	mv	a1,a0
 74e:	4505                	li	a0,1
 750:	d0dff0ef          	jal	45c <vprintf>
}
 754:	60e2                	ld	ra,24(sp)
 756:	6442                	ld	s0,16(sp)
 758:	6125                	addi	sp,sp,96
 75a:	8082                	ret

000000000000075c <free>:
static Header base;
static Header *freep;

void
free (void *ap)
{
 75c:	1141                	addi	sp,sp,-16
 75e:	e406                	sd	ra,8(sp)
 760:	e022                	sd	s0,0(sp)
 762:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 764:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 768:	00001797          	auipc	a5,0x1
 76c:	8987b783          	ld	a5,-1896(a5) # 1000 <freep>
 770:	a039                	j	77e <free+0x22>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 772:	6398                	ld	a4,0(a5)
 774:	00e7e463          	bltu	a5,a4,77c <free+0x20>
 778:	00e6ea63          	bltu	a3,a4,78c <free+0x30>
{
 77c:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 77e:	fed7fae3          	bgeu	a5,a3,772 <free+0x16>
 782:	6398                	ld	a4,0(a5)
 784:	00e6e463          	bltu	a3,a4,78c <free+0x30>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 788:	fee7eae3          	bltu	a5,a4,77c <free+0x20>
      break;
  if (bp + bp->s.size == p->s.ptr)
 78c:	ff852583          	lw	a1,-8(a0)
 790:	6390                	ld	a2,0(a5)
 792:	02059813          	slli	a6,a1,0x20
 796:	01c85713          	srli	a4,a6,0x1c
 79a:	9736                	add	a4,a4,a3
 79c:	02e60563          	beq	a2,a4,7c6 <free+0x6a>
    {
      bp->s.size += p->s.ptr->s.size;
      bp->s.ptr = p->s.ptr->s.ptr;
 7a0:	fec53823          	sd	a2,-16(a0)
    }
  else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp)
 7a4:	4790                	lw	a2,8(a5)
 7a6:	02061593          	slli	a1,a2,0x20
 7aa:	01c5d713          	srli	a4,a1,0x1c
 7ae:	973e                	add	a4,a4,a5
 7b0:	02e68263          	beq	a3,a4,7d4 <free+0x78>
    {
      p->s.size += bp->s.size;
      p->s.ptr = bp->s.ptr;
 7b4:	e394                	sd	a3,0(a5)
    }
  else
    p->s.ptr = bp;
  freep = p;
 7b6:	00001717          	auipc	a4,0x1
 7ba:	84f73523          	sd	a5,-1974(a4) # 1000 <freep>
}
 7be:	60a2                	ld	ra,8(sp)
 7c0:	6402                	ld	s0,0(sp)
 7c2:	0141                	addi	sp,sp,16
 7c4:	8082                	ret
      bp->s.size += p->s.ptr->s.size;
 7c6:	4618                	lw	a4,8(a2)
 7c8:	9f2d                	addw	a4,a4,a1
 7ca:	fee52c23          	sw	a4,-8(a0)
      bp->s.ptr = p->s.ptr->s.ptr;
 7ce:	6398                	ld	a4,0(a5)
 7d0:	6310                	ld	a2,0(a4)
 7d2:	b7f9                	j	7a0 <free+0x44>
      p->s.size += bp->s.size;
 7d4:	ff852703          	lw	a4,-8(a0)
 7d8:	9f31                	addw	a4,a4,a2
 7da:	c798                	sw	a4,8(a5)
      p->s.ptr = bp->s.ptr;
 7dc:	ff053683          	ld	a3,-16(a0)
 7e0:	bfd1                	j	7b4 <free+0x58>

00000000000007e2 <malloc>:
  return freep;
}

void *
malloc (uint nbytes)
{
 7e2:	7139                	addi	sp,sp,-64
 7e4:	fc06                	sd	ra,56(sp)
 7e6:	f822                	sd	s0,48(sp)
 7e8:	f04a                	sd	s2,32(sp)
 7ea:	ec4e                	sd	s3,24(sp)
 7ec:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof (Header) - 1) / sizeof (Header) + 1;
 7ee:	02051993          	slli	s3,a0,0x20
 7f2:	0209d993          	srli	s3,s3,0x20
 7f6:	09bd                	addi	s3,s3,15
 7f8:	0049d993          	srli	s3,s3,0x4
 7fc:	2985                	addiw	s3,s3,1
 7fe:	894e                	mv	s2,s3
  if ((prevp = freep) == 0)
 800:	00001517          	auipc	a0,0x1
 804:	80053503          	ld	a0,-2048(a0) # 1000 <freep>
 808:	c905                	beqz	a0,838 <malloc+0x56>
    {
      base.s.ptr = freep = prevp = &base;
      base.s.size = 0;
    }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 80a:	611c                	ld	a5,0(a0)
    {
      if (p->s.size >= nunits)
 80c:	4798                	lw	a4,8(a5)
 80e:	09377663          	bgeu	a4,s3,89a <malloc+0xb8>
 812:	f426                	sd	s1,40(sp)
 814:	e852                	sd	s4,16(sp)
 816:	e456                	sd	s5,8(sp)
 818:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 81a:	8a4e                	mv	s4,s3
 81c:	6705                	lui	a4,0x1
 81e:	00e9f363          	bgeu	s3,a4,824 <malloc+0x42>
 822:	6a05                	lui	s4,0x1
 824:	000a0b1b          	sext.w	s6,s4
  p = sbrk (nu * sizeof (Header));
 828:	004a1a1b          	slliw	s4,s4,0x4
              p->s.size = nunits;
            }
          freep = prevp;
          return (void *)(p + 1);
        }
      if (p == freep)
 82c:	00000497          	auipc	s1,0x0
 830:	7d448493          	addi	s1,s1,2004 # 1000 <freep>
  if (p == (char *)-1)
 834:	5afd                	li	s5,-1
 836:	a83d                	j	874 <malloc+0x92>
 838:	f426                	sd	s1,40(sp)
 83a:	e852                	sd	s4,16(sp)
 83c:	e456                	sd	s5,8(sp)
 83e:	e05a                	sd	s6,0(sp)
      base.s.ptr = freep = prevp = &base;
 840:	00000797          	auipc	a5,0x0
 844:	7d078793          	addi	a5,a5,2000 # 1010 <base>
 848:	00000717          	auipc	a4,0x0
 84c:	7af73c23          	sd	a5,1976(a4) # 1000 <freep>
 850:	e39c                	sd	a5,0(a5)
      base.s.size = 0;
 852:	0007a423          	sw	zero,8(a5)
      if (p->s.size >= nunits)
 856:	b7d1                	j	81a <malloc+0x38>
            prevp->s.ptr = p->s.ptr;
 858:	6398                	ld	a4,0(a5)
 85a:	e118                	sd	a4,0(a0)
 85c:	a899                	j	8b2 <malloc+0xd0>
  hp->s.size = nu;
 85e:	01652423          	sw	s6,8(a0)
  free ((void *)(hp + 1));
 862:	0541                	addi	a0,a0,16
 864:	ef9ff0ef          	jal	75c <free>
  return freep;
 868:	6088                	ld	a0,0(s1)
        if ((p = morecore (nunits)) == 0)
 86a:	c125                	beqz	a0,8ca <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 86c:	611c                	ld	a5,0(a0)
      if (p->s.size >= nunits)
 86e:	4798                	lw	a4,8(a5)
 870:	03277163          	bgeu	a4,s2,892 <malloc+0xb0>
      if (p == freep)
 874:	6098                	ld	a4,0(s1)
 876:	853e                	mv	a0,a5
 878:	fef71ae3          	bne	a4,a5,86c <malloc+0x8a>
  p = sbrk (nu * sizeof (Header));
 87c:	8552                	mv	a0,s4
 87e:	afdff0ef          	jal	37a <sbrk>
  if (p == (char *)-1)
 882:	fd551ee3          	bne	a0,s5,85e <malloc+0x7c>
          return 0;
 886:	4501                	li	a0,0
 888:	74a2                	ld	s1,40(sp)
 88a:	6a42                	ld	s4,16(sp)
 88c:	6aa2                	ld	s5,8(sp)
 88e:	6b02                	ld	s6,0(sp)
 890:	a03d                	j	8be <malloc+0xdc>
 892:	74a2                	ld	s1,40(sp)
 894:	6a42                	ld	s4,16(sp)
 896:	6aa2                	ld	s5,8(sp)
 898:	6b02                	ld	s6,0(sp)
          if (p->s.size == nunits)
 89a:	fae90fe3          	beq	s2,a4,858 <malloc+0x76>
              p->s.size -= nunits;
 89e:	4137073b          	subw	a4,a4,s3
 8a2:	c798                	sw	a4,8(a5)
              p += p->s.size;
 8a4:	02071693          	slli	a3,a4,0x20
 8a8:	01c6d713          	srli	a4,a3,0x1c
 8ac:	97ba                	add	a5,a5,a4
              p->s.size = nunits;
 8ae:	0137a423          	sw	s3,8(a5)
          freep = prevp;
 8b2:	00000717          	auipc	a4,0x0
 8b6:	74a73723          	sd	a0,1870(a4) # 1000 <freep>
          return (void *)(p + 1);
 8ba:	01078513          	addi	a0,a5,16
    }
}
 8be:	70e2                	ld	ra,56(sp)
 8c0:	7442                	ld	s0,48(sp)
 8c2:	7902                	ld	s2,32(sp)
 8c4:	69e2                	ld	s3,24(sp)
 8c6:	6121                	addi	sp,sp,64
 8c8:	8082                	ret
 8ca:	74a2                	ld	s1,40(sp)
 8cc:	6a42                	ld	s4,16(sp)
 8ce:	6aa2                	ld	s5,8(sp)
 8d0:	6b02                	ld	s6,0(sp)
 8d2:	b7f5                	j	8be <malloc+0xdc>
