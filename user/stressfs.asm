
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dc010113          	addi	sp,sp,-576
   4:	22113c23          	sd	ra,568(sp)
   8:	22813823          	sd	s0,560(sp)
   c:	22913423          	sd	s1,552(sp)
  10:	23213023          	sd	s2,544(sp)
  14:	21313c23          	sd	s3,536(sp)
  18:	21413823          	sd	s4,528(sp)
  1c:	0480                	addi	s0,sp,576
  int fd, i;
  char path[] = "stressfs0";
  1e:	00001797          	auipc	a5,0x1
  22:	97278793          	addi	a5,a5,-1678 # 990 <malloc+0x12c>
  26:	6398                	ld	a4,0(a5)
  28:	fce43023          	sd	a4,-64(s0)
  2c:	0087d783          	lhu	a5,8(a5)
  30:	fcf41423          	sh	a5,-56(s0)
  char data[512];

  printf("stressfs starting\n");
  34:	00001517          	auipc	a0,0x1
  38:	92c50513          	addi	a0,a0,-1748 # 960 <malloc+0xfc>
  3c:	770000ef          	jal	7ac <printf>
  memset(data, 'a', sizeof(data));
  40:	20000613          	li	a2,512
  44:	06100593          	li	a1,97
  48:	dc040513          	addi	a0,s0,-576
  4c:	12a000ef          	jal	176 <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	318000ef          	jal	36c <fork>
  58:	00a04563          	bgtz	a0,62 <main+0x62>
  for(i = 0; i < 4; i++)
  5c:	2485                	addiw	s1,s1,1
  5e:	ff249be3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  62:	85a6                	mv	a1,s1
  64:	00001517          	auipc	a0,0x1
  68:	91450513          	addi	a0,a0,-1772 # 978 <malloc+0x114>
  6c:	740000ef          	jal	7ac <printf>

  path[8] += i;
  70:	fc844783          	lbu	a5,-56(s0)
  74:	9fa5                	addw	a5,a5,s1
  76:	fcf40423          	sb	a5,-56(s0)
  fd = open(path, O_CREATE | O_RDWR);
  7a:	20200593          	li	a1,514
  7e:	fc040513          	addi	a0,s0,-64
  82:	332000ef          	jal	3b4 <open>
  86:	892a                	mv	s2,a0
  88:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  8a:	dc040a13          	addi	s4,s0,-576
  8e:	20000993          	li	s3,512
  92:	864e                	mv	a2,s3
  94:	85d2                	mv	a1,s4
  96:	854a                	mv	a0,s2
  98:	2fc000ef          	jal	394 <write>
  for(i = 0; i < 20; i++)
  9c:	34fd                	addiw	s1,s1,-1
  9e:	f8f5                	bnez	s1,92 <main+0x92>
  close(fd);
  a0:	854a                	mv	a0,s2
  a2:	2fa000ef          	jal	39c <close>

  printf("read\n");
  a6:	00001517          	auipc	a0,0x1
  aa:	8e250513          	addi	a0,a0,-1822 # 988 <malloc+0x124>
  ae:	6fe000ef          	jal	7ac <printf>

  fd = open(path, O_RDONLY);
  b2:	4581                	li	a1,0
  b4:	fc040513          	addi	a0,s0,-64
  b8:	2fc000ef          	jal	3b4 <open>
  bc:	892a                	mv	s2,a0
  be:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  c0:	dc040a13          	addi	s4,s0,-576
  c4:	20000993          	li	s3,512
  c8:	864e                	mv	a2,s3
  ca:	85d2                	mv	a1,s4
  cc:	854a                	mv	a0,s2
  ce:	2be000ef          	jal	38c <read>
  for (i = 0; i < 20; i++)
  d2:	34fd                	addiw	s1,s1,-1
  d4:	f8f5                	bnez	s1,c8 <main+0xc8>
  close(fd);
  d6:	854a                	mv	a0,s2
  d8:	2c4000ef          	jal	39c <close>

  wait(0);
  dc:	4501                	li	a0,0
  de:	29e000ef          	jal	37c <wait>

  exit(0);
  e2:	4501                	li	a0,0
  e4:	290000ef          	jal	374 <exit>

00000000000000e8 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start ()
{
  e8:	1141                	addi	sp,sp,-16
  ea:	e406                	sd	ra,8(sp)
  ec:	e022                	sd	s0,0(sp)
  ee:	0800                	addi	s0,sp,16
  extern int main ();
  main ();
  f0:	f11ff0ef          	jal	0 <main>
  exit (0);
  f4:	4501                	li	a0,0
  f6:	27e000ef          	jal	374 <exit>

00000000000000fa <strcpy>:
}

char *
strcpy (char *s, const char *t)
{
  fa:	1141                	addi	sp,sp,-16
  fc:	e406                	sd	ra,8(sp)
  fe:	e022                	sd	s0,0(sp)
 100:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 102:	87aa                	mv	a5,a0
 104:	0585                	addi	a1,a1,1
 106:	0785                	addi	a5,a5,1
 108:	fff5c703          	lbu	a4,-1(a1)
 10c:	fee78fa3          	sb	a4,-1(a5)
 110:	fb75                	bnez	a4,104 <strcpy+0xa>
    ;
  return os;
}
 112:	60a2                	ld	ra,8(sp)
 114:	6402                	ld	s0,0(sp)
 116:	0141                	addi	sp,sp,16
 118:	8082                	ret

000000000000011a <strcmp>:

int
strcmp (const char *p, const char *q)
{
 11a:	1141                	addi	sp,sp,-16
 11c:	e406                	sd	ra,8(sp)
 11e:	e022                	sd	s0,0(sp)
 120:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 122:	00054783          	lbu	a5,0(a0)
 126:	cb91                	beqz	a5,13a <strcmp+0x20>
 128:	0005c703          	lbu	a4,0(a1)
 12c:	00f71763          	bne	a4,a5,13a <strcmp+0x20>
    p++, q++;
 130:	0505                	addi	a0,a0,1
 132:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 134:	00054783          	lbu	a5,0(a0)
 138:	fbe5                	bnez	a5,128 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 13a:	0005c503          	lbu	a0,0(a1)
}
 13e:	40a7853b          	subw	a0,a5,a0
 142:	60a2                	ld	ra,8(sp)
 144:	6402                	ld	s0,0(sp)
 146:	0141                	addi	sp,sp,16
 148:	8082                	ret

000000000000014a <strlen>:

uint
strlen (const char *s)
{
 14a:	1141                	addi	sp,sp,-16
 14c:	e406                	sd	ra,8(sp)
 14e:	e022                	sd	s0,0(sp)
 150:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 152:	00054783          	lbu	a5,0(a0)
 156:	cf91                	beqz	a5,172 <strlen+0x28>
 158:	00150793          	addi	a5,a0,1
 15c:	86be                	mv	a3,a5
 15e:	0785                	addi	a5,a5,1
 160:	fff7c703          	lbu	a4,-1(a5)
 164:	ff65                	bnez	a4,15c <strlen+0x12>
 166:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 16a:	60a2                	ld	ra,8(sp)
 16c:	6402                	ld	s0,0(sp)
 16e:	0141                	addi	sp,sp,16
 170:	8082                	ret
  for (n = 0; s[n]; n++)
 172:	4501                	li	a0,0
 174:	bfdd                	j	16a <strlen+0x20>

0000000000000176 <memset>:

void *
memset (void *dst, int c, uint n)
{
 176:	1141                	addi	sp,sp,-16
 178:	e406                	sd	ra,8(sp)
 17a:	e022                	sd	s0,0(sp)
 17c:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
 17e:	ca19                	beqz	a2,194 <memset+0x1e>
 180:	87aa                	mv	a5,a0
 182:	1602                	slli	a2,a2,0x20
 184:	9201                	srli	a2,a2,0x20
 186:	00a60733          	add	a4,a2,a0
    {
      cdst[i] = c;
 18a:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 18e:	0785                	addi	a5,a5,1
 190:	fee79de3          	bne	a5,a4,18a <memset+0x14>
    }
  return dst;
}
 194:	60a2                	ld	ra,8(sp)
 196:	6402                	ld	s0,0(sp)
 198:	0141                	addi	sp,sp,16
 19a:	8082                	ret

000000000000019c <strchr>:

char *
strchr (const char *s, char c)
{
 19c:	1141                	addi	sp,sp,-16
 19e:	e406                	sd	ra,8(sp)
 1a0:	e022                	sd	s0,0(sp)
 1a2:	0800                	addi	s0,sp,16
  for (; *s; s++)
 1a4:	00054783          	lbu	a5,0(a0)
 1a8:	cf81                	beqz	a5,1c0 <strchr+0x24>
    if (*s == c)
 1aa:	00f58763          	beq	a1,a5,1b8 <strchr+0x1c>
  for (; *s; s++)
 1ae:	0505                	addi	a0,a0,1
 1b0:	00054783          	lbu	a5,0(a0)
 1b4:	fbfd                	bnez	a5,1aa <strchr+0xe>
      return (char *)s;
  return 0;
 1b6:	4501                	li	a0,0
}
 1b8:	60a2                	ld	ra,8(sp)
 1ba:	6402                	ld	s0,0(sp)
 1bc:	0141                	addi	sp,sp,16
 1be:	8082                	ret
  return 0;
 1c0:	4501                	li	a0,0
 1c2:	bfdd                	j	1b8 <strchr+0x1c>

00000000000001c4 <gets>:

char *
gets (char *buf, int max)
{
 1c4:	711d                	addi	sp,sp,-96
 1c6:	ec86                	sd	ra,88(sp)
 1c8:	e8a2                	sd	s0,80(sp)
 1ca:	e4a6                	sd	s1,72(sp)
 1cc:	e0ca                	sd	s2,64(sp)
 1ce:	fc4e                	sd	s3,56(sp)
 1d0:	f852                	sd	s4,48(sp)
 1d2:	f456                	sd	s5,40(sp)
 1d4:	f05a                	sd	s6,32(sp)
 1d6:	ec5e                	sd	s7,24(sp)
 1d8:	e862                	sd	s8,16(sp)
 1da:	1080                	addi	s0,sp,96
 1dc:	8baa                	mv	s7,a0
 1de:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 1e0:	892a                	mv	s2,a0
 1e2:	4481                	li	s1,0
    {
      cc = read (0, &c, 1);
 1e4:	faf40b13          	addi	s6,s0,-81
 1e8:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;)
 1ea:	8c26                	mv	s8,s1
 1ec:	0014899b          	addiw	s3,s1,1
 1f0:	84ce                	mv	s1,s3
 1f2:	0349d463          	bge	s3,s4,21a <gets+0x56>
      cc = read (0, &c, 1);
 1f6:	8656                	mv	a2,s5
 1f8:	85da                	mv	a1,s6
 1fa:	4501                	li	a0,0
 1fc:	190000ef          	jal	38c <read>
      if (cc < 1)
 200:	00a05d63          	blez	a0,21a <gets+0x56>
        break;
      buf[i++] = c;
 204:	faf44783          	lbu	a5,-81(s0)
 208:	00f90023          	sb	a5,0(s2)
      if (c == '\n' || c == '\r')
 20c:	0905                	addi	s2,s2,1
 20e:	ff678713          	addi	a4,a5,-10
 212:	c319                	beqz	a4,218 <gets+0x54>
 214:	17cd                	addi	a5,a5,-13
 216:	fbf1                	bnez	a5,1ea <gets+0x26>
      buf[i++] = c;
 218:	8c4e                	mv	s8,s3
        break;
    }
  buf[i] = '\0';
 21a:	9c5e                	add	s8,s8,s7
 21c:	000c0023          	sb	zero,0(s8)
  return buf;
}
 220:	855e                	mv	a0,s7
 222:	60e6                	ld	ra,88(sp)
 224:	6446                	ld	s0,80(sp)
 226:	64a6                	ld	s1,72(sp)
 228:	6906                	ld	s2,64(sp)
 22a:	79e2                	ld	s3,56(sp)
 22c:	7a42                	ld	s4,48(sp)
 22e:	7aa2                	ld	s5,40(sp)
 230:	7b02                	ld	s6,32(sp)
 232:	6be2                	ld	s7,24(sp)
 234:	6c42                	ld	s8,16(sp)
 236:	6125                	addi	sp,sp,96
 238:	8082                	ret

000000000000023a <stat>:

int
stat (const char *n, struct stat *st)
{
 23a:	1101                	addi	sp,sp,-32
 23c:	ec06                	sd	ra,24(sp)
 23e:	e822                	sd	s0,16(sp)
 240:	e04a                	sd	s2,0(sp)
 242:	1000                	addi	s0,sp,32
 244:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open (n, O_RDONLY);
 246:	4581                	li	a1,0
 248:	16c000ef          	jal	3b4 <open>
  if (fd < 0)
 24c:	02054263          	bltz	a0,270 <stat+0x36>
 250:	e426                	sd	s1,8(sp)
 252:	84aa                	mv	s1,a0
    return -1;
  r = fstat (fd, st);
 254:	85ca                	mv	a1,s2
 256:	176000ef          	jal	3cc <fstat>
 25a:	892a                	mv	s2,a0
  close (fd);
 25c:	8526                	mv	a0,s1
 25e:	13e000ef          	jal	39c <close>
  return r;
 262:	64a2                	ld	s1,8(sp)
}
 264:	854a                	mv	a0,s2
 266:	60e2                	ld	ra,24(sp)
 268:	6442                	ld	s0,16(sp)
 26a:	6902                	ld	s2,0(sp)
 26c:	6105                	addi	sp,sp,32
 26e:	8082                	ret
    return -1;
 270:	57fd                	li	a5,-1
 272:	893e                	mv	s2,a5
 274:	bfc5                	j	264 <stat+0x2a>

0000000000000276 <atoi>:

int
atoi (const char *s)
{
 276:	1141                	addi	sp,sp,-16
 278:	e406                	sd	ra,8(sp)
 27a:	e022                	sd	s0,0(sp)
 27c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 27e:	00054683          	lbu	a3,0(a0)
 282:	fd06879b          	addiw	a5,a3,-48
 286:	0ff7f793          	zext.b	a5,a5
 28a:	4625                	li	a2,9
 28c:	02f66963          	bltu	a2,a5,2be <atoi+0x48>
 290:	872a                	mv	a4,a0
  n = 0;
 292:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 294:	0705                	addi	a4,a4,1
 296:	0025179b          	slliw	a5,a0,0x2
 29a:	9fa9                	addw	a5,a5,a0
 29c:	0017979b          	slliw	a5,a5,0x1
 2a0:	9fb5                	addw	a5,a5,a3
 2a2:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 2a6:	00074683          	lbu	a3,0(a4)
 2aa:	fd06879b          	addiw	a5,a3,-48
 2ae:	0ff7f793          	zext.b	a5,a5
 2b2:	fef671e3          	bgeu	a2,a5,294 <atoi+0x1e>
  return n;
}
 2b6:	60a2                	ld	ra,8(sp)
 2b8:	6402                	ld	s0,0(sp)
 2ba:	0141                	addi	sp,sp,16
 2bc:	8082                	ret
  n = 0;
 2be:	4501                	li	a0,0
 2c0:	bfdd                	j	2b6 <atoi+0x40>

00000000000002c2 <memmove>:

void *
memmove (void *vdst, const void *vsrc, int n)
{
 2c2:	1141                	addi	sp,sp,-16
 2c4:	e406                	sd	ra,8(sp)
 2c6:	e022                	sd	s0,0(sp)
 2c8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 2ca:	02b57563          	bgeu	a0,a1,2f4 <memmove+0x32>
    {
      while (n-- > 0)
 2ce:	00c05f63          	blez	a2,2ec <memmove+0x2a>
 2d2:	1602                	slli	a2,a2,0x20
 2d4:	9201                	srli	a2,a2,0x20
 2d6:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2da:	872a                	mv	a4,a0
        *dst++ = *src++;
 2dc:	0585                	addi	a1,a1,1
 2de:	0705                	addi	a4,a4,1
 2e0:	fff5c683          	lbu	a3,-1(a1)
 2e4:	fed70fa3          	sb	a3,-1(a4)
      while (n-- > 0)
 2e8:	fee79ae3          	bne	a5,a4,2dc <memmove+0x1a>
      src += n;
      while (n-- > 0)
        *--dst = *--src;
    }
  return vdst;
}
 2ec:	60a2                	ld	ra,8(sp)
 2ee:	6402                	ld	s0,0(sp)
 2f0:	0141                	addi	sp,sp,16
 2f2:	8082                	ret
      while (n-- > 0)
 2f4:	fec05ce3          	blez	a2,2ec <memmove+0x2a>
      dst += n;
 2f8:	00c50733          	add	a4,a0,a2
      src += n;
 2fc:	95b2                	add	a1,a1,a2
 2fe:	fff6079b          	addiw	a5,a2,-1
 302:	1782                	slli	a5,a5,0x20
 304:	9381                	srli	a5,a5,0x20
 306:	fff7c793          	not	a5,a5
 30a:	97ba                	add	a5,a5,a4
        *--dst = *--src;
 30c:	15fd                	addi	a1,a1,-1
 30e:	177d                	addi	a4,a4,-1
 310:	0005c683          	lbu	a3,0(a1)
 314:	00d70023          	sb	a3,0(a4)
      while (n-- > 0)
 318:	fef71ae3          	bne	a4,a5,30c <memmove+0x4a>
 31c:	bfc1                	j	2ec <memmove+0x2a>

000000000000031e <memcmp>:

int
memcmp (const void *s1, const void *s2, uint n)
{
 31e:	1141                	addi	sp,sp,-16
 320:	e406                	sd	ra,8(sp)
 322:	e022                	sd	s0,0(sp)
 324:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 326:	c61d                	beqz	a2,354 <memcmp+0x36>
 328:	1602                	slli	a2,a2,0x20
 32a:	9201                	srli	a2,a2,0x20
 32c:	00c506b3          	add	a3,a0,a2
    {
      if (*p1 != *p2)
 330:	00054783          	lbu	a5,0(a0)
 334:	0005c703          	lbu	a4,0(a1)
 338:	00e79863          	bne	a5,a4,348 <memcmp+0x2a>
        {
          return *p1 - *p2;
        }
      p1++;
 33c:	0505                	addi	a0,a0,1
      p2++;
 33e:	0585                	addi	a1,a1,1
  while (n-- > 0)
 340:	fed518e3          	bne	a0,a3,330 <memcmp+0x12>
    }
  return 0;
 344:	4501                	li	a0,0
 346:	a019                	j	34c <memcmp+0x2e>
          return *p1 - *p2;
 348:	40e7853b          	subw	a0,a5,a4
}
 34c:	60a2                	ld	ra,8(sp)
 34e:	6402                	ld	s0,0(sp)
 350:	0141                	addi	sp,sp,16
 352:	8082                	ret
  return 0;
 354:	4501                	li	a0,0
 356:	bfdd                	j	34c <memcmp+0x2e>

0000000000000358 <memcpy>:

void *
memcpy (void *dst, const void *src, uint n)
{
 358:	1141                	addi	sp,sp,-16
 35a:	e406                	sd	ra,8(sp)
 35c:	e022                	sd	s0,0(sp)
 35e:	0800                	addi	s0,sp,16
  return memmove (dst, src, n);
 360:	f63ff0ef          	jal	2c2 <memmove>
}
 364:	60a2                	ld	ra,8(sp)
 366:	6402                	ld	s0,0(sp)
 368:	0141                	addi	sp,sp,16
 36a:	8082                	ret

000000000000036c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 36c:	4885                	li	a7,1
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <exit>:
.global exit
exit:
 li a7, SYS_exit
 374:	4889                	li	a7,2
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <wait>:
.global wait
wait:
 li a7, SYS_wait
 37c:	488d                	li	a7,3
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 384:	4891                	li	a7,4
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <read>:
.global read
read:
 li a7, SYS_read
 38c:	4895                	li	a7,5
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <write>:
.global write
write:
 li a7, SYS_write
 394:	48c1                	li	a7,16
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <close>:
.global close
close:
 li a7, SYS_close
 39c:	48d5                	li	a7,21
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3a4:	4899                	li	a7,6
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ac:	489d                	li	a7,7
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <open>:
.global open
open:
 li a7, SYS_open
 3b4:	48bd                	li	a7,15
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3bc:	48c5                	li	a7,17
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3c4:	48c9                	li	a7,18
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3cc:	48a1                	li	a7,8
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <link>:
.global link
link:
 li a7, SYS_link
 3d4:	48cd                	li	a7,19
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3dc:	48d1                	li	a7,20
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3e4:	48a5                	li	a7,9
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <dup>:
.global dup
dup:
 li a7, SYS_dup
 3ec:	48a9                	li	a7,10
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3f4:	48ad                	li	a7,11
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3fc:	48b1                	li	a7,12
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 404:	48b5                	li	a7,13
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 40c:	48b9                	li	a7,14
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <trace>:
.global trace
trace:
 li a7, SYS_trace
 414:	48d9                	li	a7,22
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 41c:	1101                	addi	sp,sp,-32
 41e:	ec06                	sd	ra,24(sp)
 420:	e822                	sd	s0,16(sp)
 422:	1000                	addi	s0,sp,32
 424:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 428:	4605                	li	a2,1
 42a:	fef40593          	addi	a1,s0,-17
 42e:	f67ff0ef          	jal	394 <write>
}
 432:	60e2                	ld	ra,24(sp)
 434:	6442                	ld	s0,16(sp)
 436:	6105                	addi	sp,sp,32
 438:	8082                	ret

000000000000043a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 43a:	7139                	addi	sp,sp,-64
 43c:	fc06                	sd	ra,56(sp)
 43e:	f822                	sd	s0,48(sp)
 440:	f04a                	sd	s2,32(sp)
 442:	ec4e                	sd	s3,24(sp)
 444:	0080                	addi	s0,sp,64
 446:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 448:	cac9                	beqz	a3,4da <printint+0xa0>
 44a:	01f5d79b          	srliw	a5,a1,0x1f
 44e:	c7d1                	beqz	a5,4da <printint+0xa0>
    neg = 1;
    x = -xx;
 450:	40b005bb          	negw	a1,a1
    neg = 1;
 454:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 456:	fc040993          	addi	s3,s0,-64
  neg = 0;
 45a:	86ce                	mv	a3,s3
  i = 0;
 45c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 45e:	00000817          	auipc	a6,0x0
 462:	54a80813          	addi	a6,a6,1354 # 9a8 <digits>
 466:	88ba                	mv	a7,a4
 468:	0017051b          	addiw	a0,a4,1
 46c:	872a                	mv	a4,a0
 46e:	02c5f7bb          	remuw	a5,a1,a2
 472:	1782                	slli	a5,a5,0x20
 474:	9381                	srli	a5,a5,0x20
 476:	97c2                	add	a5,a5,a6
 478:	0007c783          	lbu	a5,0(a5)
 47c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 480:	87ae                	mv	a5,a1
 482:	02c5d5bb          	divuw	a1,a1,a2
 486:	0685                	addi	a3,a3,1
 488:	fcc7ffe3          	bgeu	a5,a2,466 <printint+0x2c>
  if(neg)
 48c:	00030c63          	beqz	t1,4a4 <printint+0x6a>
    buf[i++] = '-';
 490:	fd050793          	addi	a5,a0,-48
 494:	00878533          	add	a0,a5,s0
 498:	02d00793          	li	a5,45
 49c:	fef50823          	sb	a5,-16(a0)
 4a0:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 4a4:	02e05563          	blez	a4,4ce <printint+0x94>
 4a8:	f426                	sd	s1,40(sp)
 4aa:	377d                	addiw	a4,a4,-1
 4ac:	00e984b3          	add	s1,s3,a4
 4b0:	19fd                	addi	s3,s3,-1
 4b2:	99ba                	add	s3,s3,a4
 4b4:	1702                	slli	a4,a4,0x20
 4b6:	9301                	srli	a4,a4,0x20
 4b8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4bc:	0004c583          	lbu	a1,0(s1)
 4c0:	854a                	mv	a0,s2
 4c2:	f5bff0ef          	jal	41c <putc>
  while(--i >= 0)
 4c6:	14fd                	addi	s1,s1,-1
 4c8:	ff349ae3          	bne	s1,s3,4bc <printint+0x82>
 4cc:	74a2                	ld	s1,40(sp)
}
 4ce:	70e2                	ld	ra,56(sp)
 4d0:	7442                	ld	s0,48(sp)
 4d2:	7902                	ld	s2,32(sp)
 4d4:	69e2                	ld	s3,24(sp)
 4d6:	6121                	addi	sp,sp,64
 4d8:	8082                	ret
  neg = 0;
 4da:	4301                	li	t1,0
 4dc:	bfad                	j	456 <printint+0x1c>

00000000000004de <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4de:	711d                	addi	sp,sp,-96
 4e0:	ec86                	sd	ra,88(sp)
 4e2:	e8a2                	sd	s0,80(sp)
 4e4:	e4a6                	sd	s1,72(sp)
 4e6:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4e8:	0005c483          	lbu	s1,0(a1)
 4ec:	20048963          	beqz	s1,6fe <vprintf+0x220>
 4f0:	e0ca                	sd	s2,64(sp)
 4f2:	fc4e                	sd	s3,56(sp)
 4f4:	f852                	sd	s4,48(sp)
 4f6:	f456                	sd	s5,40(sp)
 4f8:	f05a                	sd	s6,32(sp)
 4fa:	ec5e                	sd	s7,24(sp)
 4fc:	e862                	sd	s8,16(sp)
 4fe:	8b2a                	mv	s6,a0
 500:	8a2e                	mv	s4,a1
 502:	8bb2                	mv	s7,a2
  state = 0;
 504:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 506:	4901                	li	s2,0
 508:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 50a:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 50e:	06400c13          	li	s8,100
 512:	a00d                	j	534 <vprintf+0x56>
        putc(fd, c0);
 514:	85a6                	mv	a1,s1
 516:	855a                	mv	a0,s6
 518:	f05ff0ef          	jal	41c <putc>
 51c:	a019                	j	522 <vprintf+0x44>
    } else if(state == '%'){
 51e:	03598363          	beq	s3,s5,544 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 522:	0019079b          	addiw	a5,s2,1
 526:	893e                	mv	s2,a5
 528:	873e                	mv	a4,a5
 52a:	97d2                	add	a5,a5,s4
 52c:	0007c483          	lbu	s1,0(a5)
 530:	1c048063          	beqz	s1,6f0 <vprintf+0x212>
    c0 = fmt[i] & 0xff;
 534:	0004879b          	sext.w	a5,s1
    if(state == 0){
 538:	fe0993e3          	bnez	s3,51e <vprintf+0x40>
      if(c0 == '%'){
 53c:	fd579ce3          	bne	a5,s5,514 <vprintf+0x36>
        state = '%';
 540:	89be                	mv	s3,a5
 542:	b7c5                	j	522 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 544:	00ea06b3          	add	a3,s4,a4
 548:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 54c:	1a060e63          	beqz	a2,708 <vprintf+0x22a>
      if(c0 == 'd'){
 550:	03878763          	beq	a5,s8,57e <vprintf+0xa0>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 554:	f9478693          	addi	a3,a5,-108
 558:	0016b693          	seqz	a3,a3
 55c:	f9c60593          	addi	a1,a2,-100
 560:	e99d                	bnez	a1,596 <vprintf+0xb8>
 562:	ca95                	beqz	a3,596 <vprintf+0xb8>
        printint(fd, va_arg(ap, uint64), 10, 1);
 564:	008b8493          	addi	s1,s7,8
 568:	4685                	li	a3,1
 56a:	4629                	li	a2,10
 56c:	000ba583          	lw	a1,0(s7)
 570:	855a                	mv	a0,s6
 572:	ec9ff0ef          	jal	43a <printint>
        i += 1;
 576:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 578:	8ba6                	mv	s7,s1
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 57a:	4981                	li	s3,0
 57c:	b75d                	j	522 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 57e:	008b8493          	addi	s1,s7,8
 582:	4685                	li	a3,1
 584:	4629                	li	a2,10
 586:	000ba583          	lw	a1,0(s7)
 58a:	855a                	mv	a0,s6
 58c:	eafff0ef          	jal	43a <printint>
 590:	8ba6                	mv	s7,s1
      state = 0;
 592:	4981                	li	s3,0
 594:	b779                	j	522 <vprintf+0x44>
      if(c1) c2 = fmt[i+2] & 0xff;
 596:	9752                	add	a4,a4,s4
 598:	00274583          	lbu	a1,2(a4)
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 59c:	f9460713          	addi	a4,a2,-108
 5a0:	00173713          	seqz	a4,a4
 5a4:	8f75                	and	a4,a4,a3
 5a6:	f9c58513          	addi	a0,a1,-100
 5aa:	16051963          	bnez	a0,71c <vprintf+0x23e>
 5ae:	16070763          	beqz	a4,71c <vprintf+0x23e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5b2:	008b8493          	addi	s1,s7,8
 5b6:	4685                	li	a3,1
 5b8:	4629                	li	a2,10
 5ba:	000ba583          	lw	a1,0(s7)
 5be:	855a                	mv	a0,s6
 5c0:	e7bff0ef          	jal	43a <printint>
        i += 2;
 5c4:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5c6:	8ba6                	mv	s7,s1
      state = 0;
 5c8:	4981                	li	s3,0
        i += 2;
 5ca:	bfa1                	j	522 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 0);
 5cc:	008b8493          	addi	s1,s7,8
 5d0:	4681                	li	a3,0
 5d2:	4629                	li	a2,10
 5d4:	000ba583          	lw	a1,0(s7)
 5d8:	855a                	mv	a0,s6
 5da:	e61ff0ef          	jal	43a <printint>
 5de:	8ba6                	mv	s7,s1
      state = 0;
 5e0:	4981                	li	s3,0
 5e2:	b781                	j	522 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5e4:	008b8493          	addi	s1,s7,8
 5e8:	4681                	li	a3,0
 5ea:	4629                	li	a2,10
 5ec:	000ba583          	lw	a1,0(s7)
 5f0:	855a                	mv	a0,s6
 5f2:	e49ff0ef          	jal	43a <printint>
        i += 1;
 5f6:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 5f8:	8ba6                	mv	s7,s1
      state = 0;
 5fa:	4981                	li	s3,0
 5fc:	b71d                	j	522 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5fe:	008b8493          	addi	s1,s7,8
 602:	4681                	li	a3,0
 604:	4629                	li	a2,10
 606:	000ba583          	lw	a1,0(s7)
 60a:	855a                	mv	a0,s6
 60c:	e2fff0ef          	jal	43a <printint>
        i += 2;
 610:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 612:	8ba6                	mv	s7,s1
      state = 0;
 614:	4981                	li	s3,0
        i += 2;
 616:	b731                	j	522 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 618:	008b8493          	addi	s1,s7,8
 61c:	4681                	li	a3,0
 61e:	4641                	li	a2,16
 620:	000ba583          	lw	a1,0(s7)
 624:	855a                	mv	a0,s6
 626:	e15ff0ef          	jal	43a <printint>
 62a:	8ba6                	mv	s7,s1
      state = 0;
 62c:	4981                	li	s3,0
 62e:	bdd5                	j	522 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 630:	008b8493          	addi	s1,s7,8
 634:	4681                	li	a3,0
 636:	4641                	li	a2,16
 638:	000ba583          	lw	a1,0(s7)
 63c:	855a                	mv	a0,s6
 63e:	dfdff0ef          	jal	43a <printint>
        i += 1;
 642:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 644:	8ba6                	mv	s7,s1
      state = 0;
 646:	4981                	li	s3,0
 648:	bde9                	j	522 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 64a:	008b8493          	addi	s1,s7,8
 64e:	4681                	li	a3,0
 650:	4641                	li	a2,16
 652:	000ba583          	lw	a1,0(s7)
 656:	855a                	mv	a0,s6
 658:	de3ff0ef          	jal	43a <printint>
        i += 2;
 65c:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 65e:	8ba6                	mv	s7,s1
      state = 0;
 660:	4981                	li	s3,0
        i += 2;
 662:	b5c1                	j	522 <vprintf+0x44>
 664:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 666:	008b8793          	addi	a5,s7,8
 66a:	8cbe                	mv	s9,a5
 66c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 670:	03000593          	li	a1,48
 674:	855a                	mv	a0,s6
 676:	da7ff0ef          	jal	41c <putc>
  putc(fd, 'x');
 67a:	07800593          	li	a1,120
 67e:	855a                	mv	a0,s6
 680:	d9dff0ef          	jal	41c <putc>
 684:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 686:	00000b97          	auipc	s7,0x0
 68a:	322b8b93          	addi	s7,s7,802 # 9a8 <digits>
 68e:	03c9d793          	srli	a5,s3,0x3c
 692:	97de                	add	a5,a5,s7
 694:	0007c583          	lbu	a1,0(a5)
 698:	855a                	mv	a0,s6
 69a:	d83ff0ef          	jal	41c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 69e:	0992                	slli	s3,s3,0x4
 6a0:	34fd                	addiw	s1,s1,-1
 6a2:	f4f5                	bnez	s1,68e <vprintf+0x1b0>
        printptr(fd, va_arg(ap, uint64));
 6a4:	8be6                	mv	s7,s9
      state = 0;
 6a6:	4981                	li	s3,0
 6a8:	6ca2                	ld	s9,8(sp)
 6aa:	bda5                	j	522 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 6ac:	008b8993          	addi	s3,s7,8
 6b0:	000bb483          	ld	s1,0(s7)
 6b4:	cc91                	beqz	s1,6d0 <vprintf+0x1f2>
        for(; *s; s++)
 6b6:	0004c583          	lbu	a1,0(s1)
 6ba:	c985                	beqz	a1,6ea <vprintf+0x20c>
          putc(fd, *s);
 6bc:	855a                	mv	a0,s6
 6be:	d5fff0ef          	jal	41c <putc>
        for(; *s; s++)
 6c2:	0485                	addi	s1,s1,1
 6c4:	0004c583          	lbu	a1,0(s1)
 6c8:	f9f5                	bnez	a1,6bc <vprintf+0x1de>
        if((s = va_arg(ap, char*)) == 0)
 6ca:	8bce                	mv	s7,s3
      state = 0;
 6cc:	4981                	li	s3,0
 6ce:	bd91                	j	522 <vprintf+0x44>
          s = "(null)";
 6d0:	00000497          	auipc	s1,0x0
 6d4:	2d048493          	addi	s1,s1,720 # 9a0 <malloc+0x13c>
        for(; *s; s++)
 6d8:	02800593          	li	a1,40
 6dc:	b7c5                	j	6bc <vprintf+0x1de>
        putc(fd, '%');
 6de:	85be                	mv	a1,a5
 6e0:	855a                	mv	a0,s6
 6e2:	d3bff0ef          	jal	41c <putc>
      state = 0;
 6e6:	4981                	li	s3,0
 6e8:	bd2d                	j	522 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 6ea:	8bce                	mv	s7,s3
      state = 0;
 6ec:	4981                	li	s3,0
 6ee:	bd15                	j	522 <vprintf+0x44>
 6f0:	6906                	ld	s2,64(sp)
 6f2:	79e2                	ld	s3,56(sp)
 6f4:	7a42                	ld	s4,48(sp)
 6f6:	7aa2                	ld	s5,40(sp)
 6f8:	7b02                	ld	s6,32(sp)
 6fa:	6be2                	ld	s7,24(sp)
 6fc:	6c42                	ld	s8,16(sp)
    }
  }
}
 6fe:	60e6                	ld	ra,88(sp)
 700:	6446                	ld	s0,80(sp)
 702:	64a6                	ld	s1,72(sp)
 704:	6125                	addi	sp,sp,96
 706:	8082                	ret
      if(c0 == 'd'){
 708:	06400713          	li	a4,100
 70c:	e6e789e3          	beq	a5,a4,57e <vprintf+0xa0>
      } else if(c0 == 'l' && c1 == 'd'){
 710:	f9478693          	addi	a3,a5,-108
 714:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 718:	85b2                	mv	a1,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 71a:	4701                	li	a4,0
      } else if(c0 == 'u'){
 71c:	07500513          	li	a0,117
 720:	eaa786e3          	beq	a5,a0,5cc <vprintf+0xee>
      } else if(c0 == 'l' && c1 == 'u'){
 724:	f8b60513          	addi	a0,a2,-117
 728:	e119                	bnez	a0,72e <vprintf+0x250>
 72a:	ea069de3          	bnez	a3,5e4 <vprintf+0x106>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 72e:	f8b58513          	addi	a0,a1,-117
 732:	e119                	bnez	a0,738 <vprintf+0x25a>
 734:	ec0715e3          	bnez	a4,5fe <vprintf+0x120>
      } else if(c0 == 'x'){
 738:	07800513          	li	a0,120
 73c:	eca78ee3          	beq	a5,a0,618 <vprintf+0x13a>
      } else if(c0 == 'l' && c1 == 'x'){
 740:	f8860613          	addi	a2,a2,-120
 744:	e219                	bnez	a2,74a <vprintf+0x26c>
 746:	ee0695e3          	bnez	a3,630 <vprintf+0x152>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 74a:	f8858593          	addi	a1,a1,-120
 74e:	e199                	bnez	a1,754 <vprintf+0x276>
 750:	ee071de3          	bnez	a4,64a <vprintf+0x16c>
      } else if(c0 == 'p'){
 754:	07000713          	li	a4,112
 758:	f0e786e3          	beq	a5,a4,664 <vprintf+0x186>
      } else if(c0 == 's'){
 75c:	07300713          	li	a4,115
 760:	f4e786e3          	beq	a5,a4,6ac <vprintf+0x1ce>
      } else if(c0 == '%'){
 764:	02500713          	li	a4,37
 768:	f6e78be3          	beq	a5,a4,6de <vprintf+0x200>
        putc(fd, '%');
 76c:	02500593          	li	a1,37
 770:	855a                	mv	a0,s6
 772:	cabff0ef          	jal	41c <putc>
        putc(fd, c0);
 776:	85a6                	mv	a1,s1
 778:	855a                	mv	a0,s6
 77a:	ca3ff0ef          	jal	41c <putc>
      state = 0;
 77e:	4981                	li	s3,0
 780:	b34d                	j	522 <vprintf+0x44>

0000000000000782 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 782:	715d                	addi	sp,sp,-80
 784:	ec06                	sd	ra,24(sp)
 786:	e822                	sd	s0,16(sp)
 788:	1000                	addi	s0,sp,32
 78a:	e010                	sd	a2,0(s0)
 78c:	e414                	sd	a3,8(s0)
 78e:	e818                	sd	a4,16(s0)
 790:	ec1c                	sd	a5,24(s0)
 792:	03043023          	sd	a6,32(s0)
 796:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 79a:	8622                	mv	a2,s0
 79c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7a0:	d3fff0ef          	jal	4de <vprintf>
}
 7a4:	60e2                	ld	ra,24(sp)
 7a6:	6442                	ld	s0,16(sp)
 7a8:	6161                	addi	sp,sp,80
 7aa:	8082                	ret

00000000000007ac <printf>:

void
printf(const char *fmt, ...)
{
 7ac:	711d                	addi	sp,sp,-96
 7ae:	ec06                	sd	ra,24(sp)
 7b0:	e822                	sd	s0,16(sp)
 7b2:	1000                	addi	s0,sp,32
 7b4:	e40c                	sd	a1,8(s0)
 7b6:	e810                	sd	a2,16(s0)
 7b8:	ec14                	sd	a3,24(s0)
 7ba:	f018                	sd	a4,32(s0)
 7bc:	f41c                	sd	a5,40(s0)
 7be:	03043823          	sd	a6,48(s0)
 7c2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7c6:	00840613          	addi	a2,s0,8
 7ca:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7ce:	85aa                	mv	a1,a0
 7d0:	4505                	li	a0,1
 7d2:	d0dff0ef          	jal	4de <vprintf>
}
 7d6:	60e2                	ld	ra,24(sp)
 7d8:	6442                	ld	s0,16(sp)
 7da:	6125                	addi	sp,sp,96
 7dc:	8082                	ret

00000000000007de <free>:
static Header base;
static Header *freep;

void
free (void *ap)
{
 7de:	1141                	addi	sp,sp,-16
 7e0:	e406                	sd	ra,8(sp)
 7e2:	e022                	sd	s0,0(sp)
 7e4:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 7e6:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ea:	00001797          	auipc	a5,0x1
 7ee:	8167b783          	ld	a5,-2026(a5) # 1000 <freep>
 7f2:	a039                	j	800 <free+0x22>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f4:	6398                	ld	a4,0(a5)
 7f6:	00e7e463          	bltu	a5,a4,7fe <free+0x20>
 7fa:	00e6ea63          	bltu	a3,a4,80e <free+0x30>
{
 7fe:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 800:	fed7fae3          	bgeu	a5,a3,7f4 <free+0x16>
 804:	6398                	ld	a4,0(a5)
 806:	00e6e463          	bltu	a3,a4,80e <free+0x30>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 80a:	fee7eae3          	bltu	a5,a4,7fe <free+0x20>
      break;
  if (bp + bp->s.size == p->s.ptr)
 80e:	ff852583          	lw	a1,-8(a0)
 812:	6390                	ld	a2,0(a5)
 814:	02059813          	slli	a6,a1,0x20
 818:	01c85713          	srli	a4,a6,0x1c
 81c:	9736                	add	a4,a4,a3
 81e:	02e60563          	beq	a2,a4,848 <free+0x6a>
    {
      bp->s.size += p->s.ptr->s.size;
      bp->s.ptr = p->s.ptr->s.ptr;
 822:	fec53823          	sd	a2,-16(a0)
    }
  else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp)
 826:	4790                	lw	a2,8(a5)
 828:	02061593          	slli	a1,a2,0x20
 82c:	01c5d713          	srli	a4,a1,0x1c
 830:	973e                	add	a4,a4,a5
 832:	02e68263          	beq	a3,a4,856 <free+0x78>
    {
      p->s.size += bp->s.size;
      p->s.ptr = bp->s.ptr;
 836:	e394                	sd	a3,0(a5)
    }
  else
    p->s.ptr = bp;
  freep = p;
 838:	00000717          	auipc	a4,0x0
 83c:	7cf73423          	sd	a5,1992(a4) # 1000 <freep>
}
 840:	60a2                	ld	ra,8(sp)
 842:	6402                	ld	s0,0(sp)
 844:	0141                	addi	sp,sp,16
 846:	8082                	ret
      bp->s.size += p->s.ptr->s.size;
 848:	4618                	lw	a4,8(a2)
 84a:	9f2d                	addw	a4,a4,a1
 84c:	fee52c23          	sw	a4,-8(a0)
      bp->s.ptr = p->s.ptr->s.ptr;
 850:	6398                	ld	a4,0(a5)
 852:	6310                	ld	a2,0(a4)
 854:	b7f9                	j	822 <free+0x44>
      p->s.size += bp->s.size;
 856:	ff852703          	lw	a4,-8(a0)
 85a:	9f31                	addw	a4,a4,a2
 85c:	c798                	sw	a4,8(a5)
      p->s.ptr = bp->s.ptr;
 85e:	ff053683          	ld	a3,-16(a0)
 862:	bfd1                	j	836 <free+0x58>

0000000000000864 <malloc>:
  return freep;
}

void *
malloc (uint nbytes)
{
 864:	7139                	addi	sp,sp,-64
 866:	fc06                	sd	ra,56(sp)
 868:	f822                	sd	s0,48(sp)
 86a:	f04a                	sd	s2,32(sp)
 86c:	ec4e                	sd	s3,24(sp)
 86e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof (Header) - 1) / sizeof (Header) + 1;
 870:	02051993          	slli	s3,a0,0x20
 874:	0209d993          	srli	s3,s3,0x20
 878:	09bd                	addi	s3,s3,15
 87a:	0049d993          	srli	s3,s3,0x4
 87e:	2985                	addiw	s3,s3,1
 880:	894e                	mv	s2,s3
  if ((prevp = freep) == 0)
 882:	00000517          	auipc	a0,0x0
 886:	77e53503          	ld	a0,1918(a0) # 1000 <freep>
 88a:	c905                	beqz	a0,8ba <malloc+0x56>
    {
      base.s.ptr = freep = prevp = &base;
      base.s.size = 0;
    }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 88c:	611c                	ld	a5,0(a0)
    {
      if (p->s.size >= nunits)
 88e:	4798                	lw	a4,8(a5)
 890:	09377663          	bgeu	a4,s3,91c <malloc+0xb8>
 894:	f426                	sd	s1,40(sp)
 896:	e852                	sd	s4,16(sp)
 898:	e456                	sd	s5,8(sp)
 89a:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 89c:	8a4e                	mv	s4,s3
 89e:	6705                	lui	a4,0x1
 8a0:	00e9f363          	bgeu	s3,a4,8a6 <malloc+0x42>
 8a4:	6a05                	lui	s4,0x1
 8a6:	000a0b1b          	sext.w	s6,s4
  p = sbrk (nu * sizeof (Header));
 8aa:	004a1a1b          	slliw	s4,s4,0x4
              p->s.size = nunits;
            }
          freep = prevp;
          return (void *)(p + 1);
        }
      if (p == freep)
 8ae:	00000497          	auipc	s1,0x0
 8b2:	75248493          	addi	s1,s1,1874 # 1000 <freep>
  if (p == (char *)-1)
 8b6:	5afd                	li	s5,-1
 8b8:	a83d                	j	8f6 <malloc+0x92>
 8ba:	f426                	sd	s1,40(sp)
 8bc:	e852                	sd	s4,16(sp)
 8be:	e456                	sd	s5,8(sp)
 8c0:	e05a                	sd	s6,0(sp)
      base.s.ptr = freep = prevp = &base;
 8c2:	00000797          	auipc	a5,0x0
 8c6:	74e78793          	addi	a5,a5,1870 # 1010 <base>
 8ca:	00000717          	auipc	a4,0x0
 8ce:	72f73b23          	sd	a5,1846(a4) # 1000 <freep>
 8d2:	e39c                	sd	a5,0(a5)
      base.s.size = 0;
 8d4:	0007a423          	sw	zero,8(a5)
      if (p->s.size >= nunits)
 8d8:	b7d1                	j	89c <malloc+0x38>
            prevp->s.ptr = p->s.ptr;
 8da:	6398                	ld	a4,0(a5)
 8dc:	e118                	sd	a4,0(a0)
 8de:	a899                	j	934 <malloc+0xd0>
  hp->s.size = nu;
 8e0:	01652423          	sw	s6,8(a0)
  free ((void *)(hp + 1));
 8e4:	0541                	addi	a0,a0,16
 8e6:	ef9ff0ef          	jal	7de <free>
  return freep;
 8ea:	6088                	ld	a0,0(s1)
        if ((p = morecore (nunits)) == 0)
 8ec:	c125                	beqz	a0,94c <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 8ee:	611c                	ld	a5,0(a0)
      if (p->s.size >= nunits)
 8f0:	4798                	lw	a4,8(a5)
 8f2:	03277163          	bgeu	a4,s2,914 <malloc+0xb0>
      if (p == freep)
 8f6:	6098                	ld	a4,0(s1)
 8f8:	853e                	mv	a0,a5
 8fa:	fef71ae3          	bne	a4,a5,8ee <malloc+0x8a>
  p = sbrk (nu * sizeof (Header));
 8fe:	8552                	mv	a0,s4
 900:	afdff0ef          	jal	3fc <sbrk>
  if (p == (char *)-1)
 904:	fd551ee3          	bne	a0,s5,8e0 <malloc+0x7c>
          return 0;
 908:	4501                	li	a0,0
 90a:	74a2                	ld	s1,40(sp)
 90c:	6a42                	ld	s4,16(sp)
 90e:	6aa2                	ld	s5,8(sp)
 910:	6b02                	ld	s6,0(sp)
 912:	a03d                	j	940 <malloc+0xdc>
 914:	74a2                	ld	s1,40(sp)
 916:	6a42                	ld	s4,16(sp)
 918:	6aa2                	ld	s5,8(sp)
 91a:	6b02                	ld	s6,0(sp)
          if (p->s.size == nunits)
 91c:	fae90fe3          	beq	s2,a4,8da <malloc+0x76>
              p->s.size -= nunits;
 920:	4137073b          	subw	a4,a4,s3
 924:	c798                	sw	a4,8(a5)
              p += p->s.size;
 926:	02071693          	slli	a3,a4,0x20
 92a:	01c6d713          	srli	a4,a3,0x1c
 92e:	97ba                	add	a5,a5,a4
              p->s.size = nunits;
 930:	0137a423          	sw	s3,8(a5)
          freep = prevp;
 934:	00000717          	auipc	a4,0x0
 938:	6ca73623          	sd	a0,1740(a4) # 1000 <freep>
          return (void *)(p + 1);
 93c:	01078513          	addi	a0,a5,16
    }
}
 940:	70e2                	ld	ra,56(sp)
 942:	7442                	ld	s0,48(sp)
 944:	7902                	ld	s2,32(sp)
 946:	69e2                	ld	s3,24(sp)
 948:	6121                	addi	sp,sp,64
 94a:	8082                	ret
 94c:	74a2                	ld	s1,40(sp)
 94e:	6a42                	ld	s4,16(sp)
 950:	6aa2                	ld	s5,8(sp)
 952:	6b02                	ld	s6,0(sp)
 954:	b7f5                	j	940 <malloc+0xdc>
