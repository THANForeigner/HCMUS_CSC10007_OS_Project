
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	0080                	addi	s0,sp,64
  12:	89aa                	mv	s3,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  14:	20000a13          	li	s4,512
  18:	00001917          	auipc	s2,0x1
  1c:	ff890913          	addi	s2,s2,-8 # 1010 <buf>
    if (write(1, buf, n) != n) {
  20:	4a85                	li	s5,1
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  22:	8652                	mv	a2,s4
  24:	85ca                	mv	a1,s2
  26:	854e                	mv	a0,s3
  28:	372000ef          	jal	39a <read>
  2c:	84aa                	mv	s1,a0
  2e:	02a05363          	blez	a0,54 <cat+0x54>
    if (write(1, buf, n) != n) {
  32:	8626                	mv	a2,s1
  34:	85ca                	mv	a1,s2
  36:	8556                	mv	a0,s5
  38:	36a000ef          	jal	3a2 <write>
  3c:	fe9503e3          	beq	a0,s1,22 <cat+0x22>
      fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	93058593          	addi	a1,a1,-1744 # 970 <malloc+0xfe>
  48:	4509                	li	a0,2
  4a:	746000ef          	jal	790 <fprintf>
      exit(1);
  4e:	4505                	li	a0,1
  50:	332000ef          	jal	382 <exit>
    }
  }
  if(n < 0){
  54:	00054b63          	bltz	a0,6a <cat+0x6a>
    fprintf(2, "cat: read error\n");
    exit(1);
  }
}
  58:	70e2                	ld	ra,56(sp)
  5a:	7442                	ld	s0,48(sp)
  5c:	74a2                	ld	s1,40(sp)
  5e:	7902                	ld	s2,32(sp)
  60:	69e2                	ld	s3,24(sp)
  62:	6a42                	ld	s4,16(sp)
  64:	6aa2                	ld	s5,8(sp)
  66:	6121                	addi	sp,sp,64
  68:	8082                	ret
    fprintf(2, "cat: read error\n");
  6a:	00001597          	auipc	a1,0x1
  6e:	91e58593          	addi	a1,a1,-1762 # 988 <malloc+0x116>
  72:	4509                	li	a0,2
  74:	71c000ef          	jal	790 <fprintf>
    exit(1);
  78:	4505                	li	a0,1
  7a:	308000ef          	jal	382 <exit>

000000000000007e <main>:

int
main(int argc, char *argv[])
{
  7e:	7179                	addi	sp,sp,-48
  80:	f406                	sd	ra,40(sp)
  82:	f022                	sd	s0,32(sp)
  84:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  86:	4785                	li	a5,1
  88:	04a7d263          	bge	a5,a0,cc <main+0x4e>
  8c:	ec26                	sd	s1,24(sp)
  8e:	e84a                	sd	s2,16(sp)
  90:	e44e                	sd	s3,8(sp)
  92:	00858913          	addi	s2,a1,8
  96:	ffe5099b          	addiw	s3,a0,-2
  9a:	02099793          	slli	a5,s3,0x20
  9e:	01d7d993          	srli	s3,a5,0x1d
  a2:	05c1                	addi	a1,a1,16
  a4:	99ae                	add	s3,s3,a1
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], O_RDONLY)) < 0){
  a6:	4581                	li	a1,0
  a8:	00093503          	ld	a0,0(s2)
  ac:	316000ef          	jal	3c2 <open>
  b0:	84aa                	mv	s1,a0
  b2:	02054663          	bltz	a0,de <main+0x60>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  b6:	f4bff0ef          	jal	0 <cat>
    close(fd);
  ba:	8526                	mv	a0,s1
  bc:	2ee000ef          	jal	3aa <close>
  for(i = 1; i < argc; i++){
  c0:	0921                	addi	s2,s2,8
  c2:	ff3912e3          	bne	s2,s3,a6 <main+0x28>
  }
  exit(0);
  c6:	4501                	li	a0,0
  c8:	2ba000ef          	jal	382 <exit>
  cc:	ec26                	sd	s1,24(sp)
  ce:	e84a                	sd	s2,16(sp)
  d0:	e44e                	sd	s3,8(sp)
    cat(0);
  d2:	4501                	li	a0,0
  d4:	f2dff0ef          	jal	0 <cat>
    exit(0);
  d8:	4501                	li	a0,0
  da:	2a8000ef          	jal	382 <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
  de:	00093603          	ld	a2,0(s2)
  e2:	00001597          	auipc	a1,0x1
  e6:	8be58593          	addi	a1,a1,-1858 # 9a0 <malloc+0x12e>
  ea:	4509                	li	a0,2
  ec:	6a4000ef          	jal	790 <fprintf>
      exit(1);
  f0:	4505                	li	a0,1
  f2:	290000ef          	jal	382 <exit>

00000000000000f6 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start ()
{
  f6:	1141                	addi	sp,sp,-16
  f8:	e406                	sd	ra,8(sp)
  fa:	e022                	sd	s0,0(sp)
  fc:	0800                	addi	s0,sp,16
  extern int main ();
  main ();
  fe:	f81ff0ef          	jal	7e <main>
  exit (0);
 102:	4501                	li	a0,0
 104:	27e000ef          	jal	382 <exit>

0000000000000108 <strcpy>:
}

char *
strcpy (char *s, const char *t)
{
 108:	1141                	addi	sp,sp,-16
 10a:	e406                	sd	ra,8(sp)
 10c:	e022                	sd	s0,0(sp)
 10e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 110:	87aa                	mv	a5,a0
 112:	0585                	addi	a1,a1,1
 114:	0785                	addi	a5,a5,1
 116:	fff5c703          	lbu	a4,-1(a1)
 11a:	fee78fa3          	sb	a4,-1(a5)
 11e:	fb75                	bnez	a4,112 <strcpy+0xa>
    ;
  return os;
}
 120:	60a2                	ld	ra,8(sp)
 122:	6402                	ld	s0,0(sp)
 124:	0141                	addi	sp,sp,16
 126:	8082                	ret

0000000000000128 <strcmp>:

int
strcmp (const char *p, const char *q)
{
 128:	1141                	addi	sp,sp,-16
 12a:	e406                	sd	ra,8(sp)
 12c:	e022                	sd	s0,0(sp)
 12e:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 130:	00054783          	lbu	a5,0(a0)
 134:	cb91                	beqz	a5,148 <strcmp+0x20>
 136:	0005c703          	lbu	a4,0(a1)
 13a:	00f71763          	bne	a4,a5,148 <strcmp+0x20>
    p++, q++;
 13e:	0505                	addi	a0,a0,1
 140:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 142:	00054783          	lbu	a5,0(a0)
 146:	fbe5                	bnez	a5,136 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 148:	0005c503          	lbu	a0,0(a1)
}
 14c:	40a7853b          	subw	a0,a5,a0
 150:	60a2                	ld	ra,8(sp)
 152:	6402                	ld	s0,0(sp)
 154:	0141                	addi	sp,sp,16
 156:	8082                	ret

0000000000000158 <strlen>:

uint
strlen (const char *s)
{
 158:	1141                	addi	sp,sp,-16
 15a:	e406                	sd	ra,8(sp)
 15c:	e022                	sd	s0,0(sp)
 15e:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 160:	00054783          	lbu	a5,0(a0)
 164:	cf91                	beqz	a5,180 <strlen+0x28>
 166:	00150793          	addi	a5,a0,1
 16a:	86be                	mv	a3,a5
 16c:	0785                	addi	a5,a5,1
 16e:	fff7c703          	lbu	a4,-1(a5)
 172:	ff65                	bnez	a4,16a <strlen+0x12>
 174:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 178:	60a2                	ld	ra,8(sp)
 17a:	6402                	ld	s0,0(sp)
 17c:	0141                	addi	sp,sp,16
 17e:	8082                	ret
  for (n = 0; s[n]; n++)
 180:	4501                	li	a0,0
 182:	bfdd                	j	178 <strlen+0x20>

0000000000000184 <memset>:

void *
memset (void *dst, int c, uint n)
{
 184:	1141                	addi	sp,sp,-16
 186:	e406                	sd	ra,8(sp)
 188:	e022                	sd	s0,0(sp)
 18a:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
 18c:	ca19                	beqz	a2,1a2 <memset+0x1e>
 18e:	87aa                	mv	a5,a0
 190:	1602                	slli	a2,a2,0x20
 192:	9201                	srli	a2,a2,0x20
 194:	00a60733          	add	a4,a2,a0
    {
      cdst[i] = c;
 198:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 19c:	0785                	addi	a5,a5,1
 19e:	fee79de3          	bne	a5,a4,198 <memset+0x14>
    }
  return dst;
}
 1a2:	60a2                	ld	ra,8(sp)
 1a4:	6402                	ld	s0,0(sp)
 1a6:	0141                	addi	sp,sp,16
 1a8:	8082                	ret

00000000000001aa <strchr>:

char *
strchr (const char *s, char c)
{
 1aa:	1141                	addi	sp,sp,-16
 1ac:	e406                	sd	ra,8(sp)
 1ae:	e022                	sd	s0,0(sp)
 1b0:	0800                	addi	s0,sp,16
  for (; *s; s++)
 1b2:	00054783          	lbu	a5,0(a0)
 1b6:	cf81                	beqz	a5,1ce <strchr+0x24>
    if (*s == c)
 1b8:	00f58763          	beq	a1,a5,1c6 <strchr+0x1c>
  for (; *s; s++)
 1bc:	0505                	addi	a0,a0,1
 1be:	00054783          	lbu	a5,0(a0)
 1c2:	fbfd                	bnez	a5,1b8 <strchr+0xe>
      return (char *)s;
  return 0;
 1c4:	4501                	li	a0,0
}
 1c6:	60a2                	ld	ra,8(sp)
 1c8:	6402                	ld	s0,0(sp)
 1ca:	0141                	addi	sp,sp,16
 1cc:	8082                	ret
  return 0;
 1ce:	4501                	li	a0,0
 1d0:	bfdd                	j	1c6 <strchr+0x1c>

00000000000001d2 <gets>:

char *
gets (char *buf, int max)
{
 1d2:	711d                	addi	sp,sp,-96
 1d4:	ec86                	sd	ra,88(sp)
 1d6:	e8a2                	sd	s0,80(sp)
 1d8:	e4a6                	sd	s1,72(sp)
 1da:	e0ca                	sd	s2,64(sp)
 1dc:	fc4e                	sd	s3,56(sp)
 1de:	f852                	sd	s4,48(sp)
 1e0:	f456                	sd	s5,40(sp)
 1e2:	f05a                	sd	s6,32(sp)
 1e4:	ec5e                	sd	s7,24(sp)
 1e6:	e862                	sd	s8,16(sp)
 1e8:	1080                	addi	s0,sp,96
 1ea:	8baa                	mv	s7,a0
 1ec:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 1ee:	892a                	mv	s2,a0
 1f0:	4481                	li	s1,0
    {
      cc = read (0, &c, 1);
 1f2:	faf40b13          	addi	s6,s0,-81
 1f6:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;)
 1f8:	8c26                	mv	s8,s1
 1fa:	0014899b          	addiw	s3,s1,1
 1fe:	84ce                	mv	s1,s3
 200:	0349d463          	bge	s3,s4,228 <gets+0x56>
      cc = read (0, &c, 1);
 204:	8656                	mv	a2,s5
 206:	85da                	mv	a1,s6
 208:	4501                	li	a0,0
 20a:	190000ef          	jal	39a <read>
      if (cc < 1)
 20e:	00a05d63          	blez	a0,228 <gets+0x56>
        break;
      buf[i++] = c;
 212:	faf44783          	lbu	a5,-81(s0)
 216:	00f90023          	sb	a5,0(s2)
      if (c == '\n' || c == '\r')
 21a:	0905                	addi	s2,s2,1
 21c:	ff678713          	addi	a4,a5,-10
 220:	c319                	beqz	a4,226 <gets+0x54>
 222:	17cd                	addi	a5,a5,-13
 224:	fbf1                	bnez	a5,1f8 <gets+0x26>
      buf[i++] = c;
 226:	8c4e                	mv	s8,s3
        break;
    }
  buf[i] = '\0';
 228:	9c5e                	add	s8,s8,s7
 22a:	000c0023          	sb	zero,0(s8)
  return buf;
}
 22e:	855e                	mv	a0,s7
 230:	60e6                	ld	ra,88(sp)
 232:	6446                	ld	s0,80(sp)
 234:	64a6                	ld	s1,72(sp)
 236:	6906                	ld	s2,64(sp)
 238:	79e2                	ld	s3,56(sp)
 23a:	7a42                	ld	s4,48(sp)
 23c:	7aa2                	ld	s5,40(sp)
 23e:	7b02                	ld	s6,32(sp)
 240:	6be2                	ld	s7,24(sp)
 242:	6c42                	ld	s8,16(sp)
 244:	6125                	addi	sp,sp,96
 246:	8082                	ret

0000000000000248 <stat>:

int
stat (const char *n, struct stat *st)
{
 248:	1101                	addi	sp,sp,-32
 24a:	ec06                	sd	ra,24(sp)
 24c:	e822                	sd	s0,16(sp)
 24e:	e04a                	sd	s2,0(sp)
 250:	1000                	addi	s0,sp,32
 252:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open (n, O_RDONLY);
 254:	4581                	li	a1,0
 256:	16c000ef          	jal	3c2 <open>
  if (fd < 0)
 25a:	02054263          	bltz	a0,27e <stat+0x36>
 25e:	e426                	sd	s1,8(sp)
 260:	84aa                	mv	s1,a0
    return -1;
  r = fstat (fd, st);
 262:	85ca                	mv	a1,s2
 264:	176000ef          	jal	3da <fstat>
 268:	892a                	mv	s2,a0
  close (fd);
 26a:	8526                	mv	a0,s1
 26c:	13e000ef          	jal	3aa <close>
  return r;
 270:	64a2                	ld	s1,8(sp)
}
 272:	854a                	mv	a0,s2
 274:	60e2                	ld	ra,24(sp)
 276:	6442                	ld	s0,16(sp)
 278:	6902                	ld	s2,0(sp)
 27a:	6105                	addi	sp,sp,32
 27c:	8082                	ret
    return -1;
 27e:	57fd                	li	a5,-1
 280:	893e                	mv	s2,a5
 282:	bfc5                	j	272 <stat+0x2a>

0000000000000284 <atoi>:

int
atoi (const char *s)
{
 284:	1141                	addi	sp,sp,-16
 286:	e406                	sd	ra,8(sp)
 288:	e022                	sd	s0,0(sp)
 28a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 28c:	00054683          	lbu	a3,0(a0)
 290:	fd06879b          	addiw	a5,a3,-48
 294:	0ff7f793          	zext.b	a5,a5
 298:	4625                	li	a2,9
 29a:	02f66963          	bltu	a2,a5,2cc <atoi+0x48>
 29e:	872a                	mv	a4,a0
  n = 0;
 2a0:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 2a2:	0705                	addi	a4,a4,1
 2a4:	0025179b          	slliw	a5,a0,0x2
 2a8:	9fa9                	addw	a5,a5,a0
 2aa:	0017979b          	slliw	a5,a5,0x1
 2ae:	9fb5                	addw	a5,a5,a3
 2b0:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 2b4:	00074683          	lbu	a3,0(a4)
 2b8:	fd06879b          	addiw	a5,a3,-48
 2bc:	0ff7f793          	zext.b	a5,a5
 2c0:	fef671e3          	bgeu	a2,a5,2a2 <atoi+0x1e>
  return n;
}
 2c4:	60a2                	ld	ra,8(sp)
 2c6:	6402                	ld	s0,0(sp)
 2c8:	0141                	addi	sp,sp,16
 2ca:	8082                	ret
  n = 0;
 2cc:	4501                	li	a0,0
 2ce:	bfdd                	j	2c4 <atoi+0x40>

00000000000002d0 <memmove>:

void *
memmove (void *vdst, const void *vsrc, int n)
{
 2d0:	1141                	addi	sp,sp,-16
 2d2:	e406                	sd	ra,8(sp)
 2d4:	e022                	sd	s0,0(sp)
 2d6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 2d8:	02b57563          	bgeu	a0,a1,302 <memmove+0x32>
    {
      while (n-- > 0)
 2dc:	00c05f63          	blez	a2,2fa <memmove+0x2a>
 2e0:	1602                	slli	a2,a2,0x20
 2e2:	9201                	srli	a2,a2,0x20
 2e4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2e8:	872a                	mv	a4,a0
        *dst++ = *src++;
 2ea:	0585                	addi	a1,a1,1
 2ec:	0705                	addi	a4,a4,1
 2ee:	fff5c683          	lbu	a3,-1(a1)
 2f2:	fed70fa3          	sb	a3,-1(a4)
      while (n-- > 0)
 2f6:	fee79ae3          	bne	a5,a4,2ea <memmove+0x1a>
      src += n;
      while (n-- > 0)
        *--dst = *--src;
    }
  return vdst;
}
 2fa:	60a2                	ld	ra,8(sp)
 2fc:	6402                	ld	s0,0(sp)
 2fe:	0141                	addi	sp,sp,16
 300:	8082                	ret
      while (n-- > 0)
 302:	fec05ce3          	blez	a2,2fa <memmove+0x2a>
      dst += n;
 306:	00c50733          	add	a4,a0,a2
      src += n;
 30a:	95b2                	add	a1,a1,a2
 30c:	fff6079b          	addiw	a5,a2,-1
 310:	1782                	slli	a5,a5,0x20
 312:	9381                	srli	a5,a5,0x20
 314:	fff7c793          	not	a5,a5
 318:	97ba                	add	a5,a5,a4
        *--dst = *--src;
 31a:	15fd                	addi	a1,a1,-1
 31c:	177d                	addi	a4,a4,-1
 31e:	0005c683          	lbu	a3,0(a1)
 322:	00d70023          	sb	a3,0(a4)
      while (n-- > 0)
 326:	fef71ae3          	bne	a4,a5,31a <memmove+0x4a>
 32a:	bfc1                	j	2fa <memmove+0x2a>

000000000000032c <memcmp>:

int
memcmp (const void *s1, const void *s2, uint n)
{
 32c:	1141                	addi	sp,sp,-16
 32e:	e406                	sd	ra,8(sp)
 330:	e022                	sd	s0,0(sp)
 332:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 334:	c61d                	beqz	a2,362 <memcmp+0x36>
 336:	1602                	slli	a2,a2,0x20
 338:	9201                	srli	a2,a2,0x20
 33a:	00c506b3          	add	a3,a0,a2
    {
      if (*p1 != *p2)
 33e:	00054783          	lbu	a5,0(a0)
 342:	0005c703          	lbu	a4,0(a1)
 346:	00e79863          	bne	a5,a4,356 <memcmp+0x2a>
        {
          return *p1 - *p2;
        }
      p1++;
 34a:	0505                	addi	a0,a0,1
      p2++;
 34c:	0585                	addi	a1,a1,1
  while (n-- > 0)
 34e:	fed518e3          	bne	a0,a3,33e <memcmp+0x12>
    }
  return 0;
 352:	4501                	li	a0,0
 354:	a019                	j	35a <memcmp+0x2e>
          return *p1 - *p2;
 356:	40e7853b          	subw	a0,a5,a4
}
 35a:	60a2                	ld	ra,8(sp)
 35c:	6402                	ld	s0,0(sp)
 35e:	0141                	addi	sp,sp,16
 360:	8082                	ret
  return 0;
 362:	4501                	li	a0,0
 364:	bfdd                	j	35a <memcmp+0x2e>

0000000000000366 <memcpy>:

void *
memcpy (void *dst, const void *src, uint n)
{
 366:	1141                	addi	sp,sp,-16
 368:	e406                	sd	ra,8(sp)
 36a:	e022                	sd	s0,0(sp)
 36c:	0800                	addi	s0,sp,16
  return memmove (dst, src, n);
 36e:	f63ff0ef          	jal	2d0 <memmove>
}
 372:	60a2                	ld	ra,8(sp)
 374:	6402                	ld	s0,0(sp)
 376:	0141                	addi	sp,sp,16
 378:	8082                	ret

000000000000037a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 37a:	4885                	li	a7,1
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <exit>:
.global exit
exit:
 li a7, SYS_exit
 382:	4889                	li	a7,2
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <wait>:
.global wait
wait:
 li a7, SYS_wait
 38a:	488d                	li	a7,3
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 392:	4891                	li	a7,4
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <read>:
.global read
read:
 li a7, SYS_read
 39a:	4895                	li	a7,5
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <write>:
.global write
write:
 li a7, SYS_write
 3a2:	48c1                	li	a7,16
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <close>:
.global close
close:
 li a7, SYS_close
 3aa:	48d5                	li	a7,21
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3b2:	4899                	li	a7,6
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ba:	489d                	li	a7,7
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <open>:
.global open
open:
 li a7, SYS_open
 3c2:	48bd                	li	a7,15
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3ca:	48c5                	li	a7,17
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3d2:	48c9                	li	a7,18
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3da:	48a1                	li	a7,8
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <link>:
.global link
link:
 li a7, SYS_link
 3e2:	48cd                	li	a7,19
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3ea:	48d1                	li	a7,20
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3f2:	48a5                	li	a7,9
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <dup>:
.global dup
dup:
 li a7, SYS_dup
 3fa:	48a9                	li	a7,10
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 402:	48ad                	li	a7,11
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 40a:	48b1                	li	a7,12
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 412:	48b5                	li	a7,13
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 41a:	48b9                	li	a7,14
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <trace>:
.global trace
trace:
 li a7, SYS_trace
 422:	48d9                	li	a7,22
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 42a:	1101                	addi	sp,sp,-32
 42c:	ec06                	sd	ra,24(sp)
 42e:	e822                	sd	s0,16(sp)
 430:	1000                	addi	s0,sp,32
 432:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 436:	4605                	li	a2,1
 438:	fef40593          	addi	a1,s0,-17
 43c:	f67ff0ef          	jal	3a2 <write>
}
 440:	60e2                	ld	ra,24(sp)
 442:	6442                	ld	s0,16(sp)
 444:	6105                	addi	sp,sp,32
 446:	8082                	ret

0000000000000448 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 448:	7139                	addi	sp,sp,-64
 44a:	fc06                	sd	ra,56(sp)
 44c:	f822                	sd	s0,48(sp)
 44e:	f04a                	sd	s2,32(sp)
 450:	ec4e                	sd	s3,24(sp)
 452:	0080                	addi	s0,sp,64
 454:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 456:	cac9                	beqz	a3,4e8 <printint+0xa0>
 458:	01f5d79b          	srliw	a5,a1,0x1f
 45c:	c7d1                	beqz	a5,4e8 <printint+0xa0>
    neg = 1;
    x = -xx;
 45e:	40b005bb          	negw	a1,a1
    neg = 1;
 462:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 464:	fc040993          	addi	s3,s0,-64
  neg = 0;
 468:	86ce                	mv	a3,s3
  i = 0;
 46a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 46c:	00000817          	auipc	a6,0x0
 470:	55480813          	addi	a6,a6,1364 # 9c0 <digits>
 474:	88ba                	mv	a7,a4
 476:	0017051b          	addiw	a0,a4,1
 47a:	872a                	mv	a4,a0
 47c:	02c5f7bb          	remuw	a5,a1,a2
 480:	1782                	slli	a5,a5,0x20
 482:	9381                	srli	a5,a5,0x20
 484:	97c2                	add	a5,a5,a6
 486:	0007c783          	lbu	a5,0(a5)
 48a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 48e:	87ae                	mv	a5,a1
 490:	02c5d5bb          	divuw	a1,a1,a2
 494:	0685                	addi	a3,a3,1
 496:	fcc7ffe3          	bgeu	a5,a2,474 <printint+0x2c>
  if(neg)
 49a:	00030c63          	beqz	t1,4b2 <printint+0x6a>
    buf[i++] = '-';
 49e:	fd050793          	addi	a5,a0,-48
 4a2:	00878533          	add	a0,a5,s0
 4a6:	02d00793          	li	a5,45
 4aa:	fef50823          	sb	a5,-16(a0)
 4ae:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 4b2:	02e05563          	blez	a4,4dc <printint+0x94>
 4b6:	f426                	sd	s1,40(sp)
 4b8:	377d                	addiw	a4,a4,-1
 4ba:	00e984b3          	add	s1,s3,a4
 4be:	19fd                	addi	s3,s3,-1
 4c0:	99ba                	add	s3,s3,a4
 4c2:	1702                	slli	a4,a4,0x20
 4c4:	9301                	srli	a4,a4,0x20
 4c6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4ca:	0004c583          	lbu	a1,0(s1)
 4ce:	854a                	mv	a0,s2
 4d0:	f5bff0ef          	jal	42a <putc>
  while(--i >= 0)
 4d4:	14fd                	addi	s1,s1,-1
 4d6:	ff349ae3          	bne	s1,s3,4ca <printint+0x82>
 4da:	74a2                	ld	s1,40(sp)
}
 4dc:	70e2                	ld	ra,56(sp)
 4de:	7442                	ld	s0,48(sp)
 4e0:	7902                	ld	s2,32(sp)
 4e2:	69e2                	ld	s3,24(sp)
 4e4:	6121                	addi	sp,sp,64
 4e6:	8082                	ret
  neg = 0;
 4e8:	4301                	li	t1,0
 4ea:	bfad                	j	464 <printint+0x1c>

00000000000004ec <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4ec:	711d                	addi	sp,sp,-96
 4ee:	ec86                	sd	ra,88(sp)
 4f0:	e8a2                	sd	s0,80(sp)
 4f2:	e4a6                	sd	s1,72(sp)
 4f4:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4f6:	0005c483          	lbu	s1,0(a1)
 4fa:	20048963          	beqz	s1,70c <vprintf+0x220>
 4fe:	e0ca                	sd	s2,64(sp)
 500:	fc4e                	sd	s3,56(sp)
 502:	f852                	sd	s4,48(sp)
 504:	f456                	sd	s5,40(sp)
 506:	f05a                	sd	s6,32(sp)
 508:	ec5e                	sd	s7,24(sp)
 50a:	e862                	sd	s8,16(sp)
 50c:	8b2a                	mv	s6,a0
 50e:	8a2e                	mv	s4,a1
 510:	8bb2                	mv	s7,a2
  state = 0;
 512:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 514:	4901                	li	s2,0
 516:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 518:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 51c:	06400c13          	li	s8,100
 520:	a00d                	j	542 <vprintf+0x56>
        putc(fd, c0);
 522:	85a6                	mv	a1,s1
 524:	855a                	mv	a0,s6
 526:	f05ff0ef          	jal	42a <putc>
 52a:	a019                	j	530 <vprintf+0x44>
    } else if(state == '%'){
 52c:	03598363          	beq	s3,s5,552 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 530:	0019079b          	addiw	a5,s2,1
 534:	893e                	mv	s2,a5
 536:	873e                	mv	a4,a5
 538:	97d2                	add	a5,a5,s4
 53a:	0007c483          	lbu	s1,0(a5)
 53e:	1c048063          	beqz	s1,6fe <vprintf+0x212>
    c0 = fmt[i] & 0xff;
 542:	0004879b          	sext.w	a5,s1
    if(state == 0){
 546:	fe0993e3          	bnez	s3,52c <vprintf+0x40>
      if(c0 == '%'){
 54a:	fd579ce3          	bne	a5,s5,522 <vprintf+0x36>
        state = '%';
 54e:	89be                	mv	s3,a5
 550:	b7c5                	j	530 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 552:	00ea06b3          	add	a3,s4,a4
 556:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 55a:	1a060e63          	beqz	a2,716 <vprintf+0x22a>
      if(c0 == 'd'){
 55e:	03878763          	beq	a5,s8,58c <vprintf+0xa0>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 562:	f9478693          	addi	a3,a5,-108
 566:	0016b693          	seqz	a3,a3
 56a:	f9c60593          	addi	a1,a2,-100
 56e:	e99d                	bnez	a1,5a4 <vprintf+0xb8>
 570:	ca95                	beqz	a3,5a4 <vprintf+0xb8>
        printint(fd, va_arg(ap, uint64), 10, 1);
 572:	008b8493          	addi	s1,s7,8
 576:	4685                	li	a3,1
 578:	4629                	li	a2,10
 57a:	000ba583          	lw	a1,0(s7)
 57e:	855a                	mv	a0,s6
 580:	ec9ff0ef          	jal	448 <printint>
        i += 1;
 584:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 586:	8ba6                	mv	s7,s1
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 588:	4981                	li	s3,0
 58a:	b75d                	j	530 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 58c:	008b8493          	addi	s1,s7,8
 590:	4685                	li	a3,1
 592:	4629                	li	a2,10
 594:	000ba583          	lw	a1,0(s7)
 598:	855a                	mv	a0,s6
 59a:	eafff0ef          	jal	448 <printint>
 59e:	8ba6                	mv	s7,s1
      state = 0;
 5a0:	4981                	li	s3,0
 5a2:	b779                	j	530 <vprintf+0x44>
      if(c1) c2 = fmt[i+2] & 0xff;
 5a4:	9752                	add	a4,a4,s4
 5a6:	00274583          	lbu	a1,2(a4)
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5aa:	f9460713          	addi	a4,a2,-108
 5ae:	00173713          	seqz	a4,a4
 5b2:	8f75                	and	a4,a4,a3
 5b4:	f9c58513          	addi	a0,a1,-100
 5b8:	16051963          	bnez	a0,72a <vprintf+0x23e>
 5bc:	16070763          	beqz	a4,72a <vprintf+0x23e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5c0:	008b8493          	addi	s1,s7,8
 5c4:	4685                	li	a3,1
 5c6:	4629                	li	a2,10
 5c8:	000ba583          	lw	a1,0(s7)
 5cc:	855a                	mv	a0,s6
 5ce:	e7bff0ef          	jal	448 <printint>
        i += 2;
 5d2:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5d4:	8ba6                	mv	s7,s1
      state = 0;
 5d6:	4981                	li	s3,0
        i += 2;
 5d8:	bfa1                	j	530 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 0);
 5da:	008b8493          	addi	s1,s7,8
 5de:	4681                	li	a3,0
 5e0:	4629                	li	a2,10
 5e2:	000ba583          	lw	a1,0(s7)
 5e6:	855a                	mv	a0,s6
 5e8:	e61ff0ef          	jal	448 <printint>
 5ec:	8ba6                	mv	s7,s1
      state = 0;
 5ee:	4981                	li	s3,0
 5f0:	b781                	j	530 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5f2:	008b8493          	addi	s1,s7,8
 5f6:	4681                	li	a3,0
 5f8:	4629                	li	a2,10
 5fa:	000ba583          	lw	a1,0(s7)
 5fe:	855a                	mv	a0,s6
 600:	e49ff0ef          	jal	448 <printint>
        i += 1;
 604:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 606:	8ba6                	mv	s7,s1
      state = 0;
 608:	4981                	li	s3,0
 60a:	b71d                	j	530 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 60c:	008b8493          	addi	s1,s7,8
 610:	4681                	li	a3,0
 612:	4629                	li	a2,10
 614:	000ba583          	lw	a1,0(s7)
 618:	855a                	mv	a0,s6
 61a:	e2fff0ef          	jal	448 <printint>
        i += 2;
 61e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 620:	8ba6                	mv	s7,s1
      state = 0;
 622:	4981                	li	s3,0
        i += 2;
 624:	b731                	j	530 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 626:	008b8493          	addi	s1,s7,8
 62a:	4681                	li	a3,0
 62c:	4641                	li	a2,16
 62e:	000ba583          	lw	a1,0(s7)
 632:	855a                	mv	a0,s6
 634:	e15ff0ef          	jal	448 <printint>
 638:	8ba6                	mv	s7,s1
      state = 0;
 63a:	4981                	li	s3,0
 63c:	bdd5                	j	530 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 63e:	008b8493          	addi	s1,s7,8
 642:	4681                	li	a3,0
 644:	4641                	li	a2,16
 646:	000ba583          	lw	a1,0(s7)
 64a:	855a                	mv	a0,s6
 64c:	dfdff0ef          	jal	448 <printint>
        i += 1;
 650:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 652:	8ba6                	mv	s7,s1
      state = 0;
 654:	4981                	li	s3,0
 656:	bde9                	j	530 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 658:	008b8493          	addi	s1,s7,8
 65c:	4681                	li	a3,0
 65e:	4641                	li	a2,16
 660:	000ba583          	lw	a1,0(s7)
 664:	855a                	mv	a0,s6
 666:	de3ff0ef          	jal	448 <printint>
        i += 2;
 66a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 66c:	8ba6                	mv	s7,s1
      state = 0;
 66e:	4981                	li	s3,0
        i += 2;
 670:	b5c1                	j	530 <vprintf+0x44>
 672:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 674:	008b8793          	addi	a5,s7,8
 678:	8cbe                	mv	s9,a5
 67a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 67e:	03000593          	li	a1,48
 682:	855a                	mv	a0,s6
 684:	da7ff0ef          	jal	42a <putc>
  putc(fd, 'x');
 688:	07800593          	li	a1,120
 68c:	855a                	mv	a0,s6
 68e:	d9dff0ef          	jal	42a <putc>
 692:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 694:	00000b97          	auipc	s7,0x0
 698:	32cb8b93          	addi	s7,s7,812 # 9c0 <digits>
 69c:	03c9d793          	srli	a5,s3,0x3c
 6a0:	97de                	add	a5,a5,s7
 6a2:	0007c583          	lbu	a1,0(a5)
 6a6:	855a                	mv	a0,s6
 6a8:	d83ff0ef          	jal	42a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6ac:	0992                	slli	s3,s3,0x4
 6ae:	34fd                	addiw	s1,s1,-1
 6b0:	f4f5                	bnez	s1,69c <vprintf+0x1b0>
        printptr(fd, va_arg(ap, uint64));
 6b2:	8be6                	mv	s7,s9
      state = 0;
 6b4:	4981                	li	s3,0
 6b6:	6ca2                	ld	s9,8(sp)
 6b8:	bda5                	j	530 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 6ba:	008b8993          	addi	s3,s7,8
 6be:	000bb483          	ld	s1,0(s7)
 6c2:	cc91                	beqz	s1,6de <vprintf+0x1f2>
        for(; *s; s++)
 6c4:	0004c583          	lbu	a1,0(s1)
 6c8:	c985                	beqz	a1,6f8 <vprintf+0x20c>
          putc(fd, *s);
 6ca:	855a                	mv	a0,s6
 6cc:	d5fff0ef          	jal	42a <putc>
        for(; *s; s++)
 6d0:	0485                	addi	s1,s1,1
 6d2:	0004c583          	lbu	a1,0(s1)
 6d6:	f9f5                	bnez	a1,6ca <vprintf+0x1de>
        if((s = va_arg(ap, char*)) == 0)
 6d8:	8bce                	mv	s7,s3
      state = 0;
 6da:	4981                	li	s3,0
 6dc:	bd91                	j	530 <vprintf+0x44>
          s = "(null)";
 6de:	00000497          	auipc	s1,0x0
 6e2:	2da48493          	addi	s1,s1,730 # 9b8 <malloc+0x146>
        for(; *s; s++)
 6e6:	02800593          	li	a1,40
 6ea:	b7c5                	j	6ca <vprintf+0x1de>
        putc(fd, '%');
 6ec:	85be                	mv	a1,a5
 6ee:	855a                	mv	a0,s6
 6f0:	d3bff0ef          	jal	42a <putc>
      state = 0;
 6f4:	4981                	li	s3,0
 6f6:	bd2d                	j	530 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 6f8:	8bce                	mv	s7,s3
      state = 0;
 6fa:	4981                	li	s3,0
 6fc:	bd15                	j	530 <vprintf+0x44>
 6fe:	6906                	ld	s2,64(sp)
 700:	79e2                	ld	s3,56(sp)
 702:	7a42                	ld	s4,48(sp)
 704:	7aa2                	ld	s5,40(sp)
 706:	7b02                	ld	s6,32(sp)
 708:	6be2                	ld	s7,24(sp)
 70a:	6c42                	ld	s8,16(sp)
    }
  }
}
 70c:	60e6                	ld	ra,88(sp)
 70e:	6446                	ld	s0,80(sp)
 710:	64a6                	ld	s1,72(sp)
 712:	6125                	addi	sp,sp,96
 714:	8082                	ret
      if(c0 == 'd'){
 716:	06400713          	li	a4,100
 71a:	e6e789e3          	beq	a5,a4,58c <vprintf+0xa0>
      } else if(c0 == 'l' && c1 == 'd'){
 71e:	f9478693          	addi	a3,a5,-108
 722:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 726:	85b2                	mv	a1,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 728:	4701                	li	a4,0
      } else if(c0 == 'u'){
 72a:	07500513          	li	a0,117
 72e:	eaa786e3          	beq	a5,a0,5da <vprintf+0xee>
      } else if(c0 == 'l' && c1 == 'u'){
 732:	f8b60513          	addi	a0,a2,-117
 736:	e119                	bnez	a0,73c <vprintf+0x250>
 738:	ea069de3          	bnez	a3,5f2 <vprintf+0x106>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 73c:	f8b58513          	addi	a0,a1,-117
 740:	e119                	bnez	a0,746 <vprintf+0x25a>
 742:	ec0715e3          	bnez	a4,60c <vprintf+0x120>
      } else if(c0 == 'x'){
 746:	07800513          	li	a0,120
 74a:	eca78ee3          	beq	a5,a0,626 <vprintf+0x13a>
      } else if(c0 == 'l' && c1 == 'x'){
 74e:	f8860613          	addi	a2,a2,-120
 752:	e219                	bnez	a2,758 <vprintf+0x26c>
 754:	ee0695e3          	bnez	a3,63e <vprintf+0x152>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 758:	f8858593          	addi	a1,a1,-120
 75c:	e199                	bnez	a1,762 <vprintf+0x276>
 75e:	ee071de3          	bnez	a4,658 <vprintf+0x16c>
      } else if(c0 == 'p'){
 762:	07000713          	li	a4,112
 766:	f0e786e3          	beq	a5,a4,672 <vprintf+0x186>
      } else if(c0 == 's'){
 76a:	07300713          	li	a4,115
 76e:	f4e786e3          	beq	a5,a4,6ba <vprintf+0x1ce>
      } else if(c0 == '%'){
 772:	02500713          	li	a4,37
 776:	f6e78be3          	beq	a5,a4,6ec <vprintf+0x200>
        putc(fd, '%');
 77a:	02500593          	li	a1,37
 77e:	855a                	mv	a0,s6
 780:	cabff0ef          	jal	42a <putc>
        putc(fd, c0);
 784:	85a6                	mv	a1,s1
 786:	855a                	mv	a0,s6
 788:	ca3ff0ef          	jal	42a <putc>
      state = 0;
 78c:	4981                	li	s3,0
 78e:	b34d                	j	530 <vprintf+0x44>

0000000000000790 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 790:	715d                	addi	sp,sp,-80
 792:	ec06                	sd	ra,24(sp)
 794:	e822                	sd	s0,16(sp)
 796:	1000                	addi	s0,sp,32
 798:	e010                	sd	a2,0(s0)
 79a:	e414                	sd	a3,8(s0)
 79c:	e818                	sd	a4,16(s0)
 79e:	ec1c                	sd	a5,24(s0)
 7a0:	03043023          	sd	a6,32(s0)
 7a4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7a8:	8622                	mv	a2,s0
 7aa:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7ae:	d3fff0ef          	jal	4ec <vprintf>
}
 7b2:	60e2                	ld	ra,24(sp)
 7b4:	6442                	ld	s0,16(sp)
 7b6:	6161                	addi	sp,sp,80
 7b8:	8082                	ret

00000000000007ba <printf>:

void
printf(const char *fmt, ...)
{
 7ba:	711d                	addi	sp,sp,-96
 7bc:	ec06                	sd	ra,24(sp)
 7be:	e822                	sd	s0,16(sp)
 7c0:	1000                	addi	s0,sp,32
 7c2:	e40c                	sd	a1,8(s0)
 7c4:	e810                	sd	a2,16(s0)
 7c6:	ec14                	sd	a3,24(s0)
 7c8:	f018                	sd	a4,32(s0)
 7ca:	f41c                	sd	a5,40(s0)
 7cc:	03043823          	sd	a6,48(s0)
 7d0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7d4:	00840613          	addi	a2,s0,8
 7d8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7dc:	85aa                	mv	a1,a0
 7de:	4505                	li	a0,1
 7e0:	d0dff0ef          	jal	4ec <vprintf>
}
 7e4:	60e2                	ld	ra,24(sp)
 7e6:	6442                	ld	s0,16(sp)
 7e8:	6125                	addi	sp,sp,96
 7ea:	8082                	ret

00000000000007ec <free>:
static Header base;
static Header *freep;

void
free (void *ap)
{
 7ec:	1141                	addi	sp,sp,-16
 7ee:	e406                	sd	ra,8(sp)
 7f0:	e022                	sd	s0,0(sp)
 7f2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 7f4:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f8:	00001797          	auipc	a5,0x1
 7fc:	8087b783          	ld	a5,-2040(a5) # 1000 <freep>
 800:	a039                	j	80e <free+0x22>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 802:	6398                	ld	a4,0(a5)
 804:	00e7e463          	bltu	a5,a4,80c <free+0x20>
 808:	00e6ea63          	bltu	a3,a4,81c <free+0x30>
{
 80c:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 80e:	fed7fae3          	bgeu	a5,a3,802 <free+0x16>
 812:	6398                	ld	a4,0(a5)
 814:	00e6e463          	bltu	a3,a4,81c <free+0x30>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 818:	fee7eae3          	bltu	a5,a4,80c <free+0x20>
      break;
  if (bp + bp->s.size == p->s.ptr)
 81c:	ff852583          	lw	a1,-8(a0)
 820:	6390                	ld	a2,0(a5)
 822:	02059813          	slli	a6,a1,0x20
 826:	01c85713          	srli	a4,a6,0x1c
 82a:	9736                	add	a4,a4,a3
 82c:	02e60563          	beq	a2,a4,856 <free+0x6a>
    {
      bp->s.size += p->s.ptr->s.size;
      bp->s.ptr = p->s.ptr->s.ptr;
 830:	fec53823          	sd	a2,-16(a0)
    }
  else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp)
 834:	4790                	lw	a2,8(a5)
 836:	02061593          	slli	a1,a2,0x20
 83a:	01c5d713          	srli	a4,a1,0x1c
 83e:	973e                	add	a4,a4,a5
 840:	02e68263          	beq	a3,a4,864 <free+0x78>
    {
      p->s.size += bp->s.size;
      p->s.ptr = bp->s.ptr;
 844:	e394                	sd	a3,0(a5)
    }
  else
    p->s.ptr = bp;
  freep = p;
 846:	00000717          	auipc	a4,0x0
 84a:	7af73d23          	sd	a5,1978(a4) # 1000 <freep>
}
 84e:	60a2                	ld	ra,8(sp)
 850:	6402                	ld	s0,0(sp)
 852:	0141                	addi	sp,sp,16
 854:	8082                	ret
      bp->s.size += p->s.ptr->s.size;
 856:	4618                	lw	a4,8(a2)
 858:	9f2d                	addw	a4,a4,a1
 85a:	fee52c23          	sw	a4,-8(a0)
      bp->s.ptr = p->s.ptr->s.ptr;
 85e:	6398                	ld	a4,0(a5)
 860:	6310                	ld	a2,0(a4)
 862:	b7f9                	j	830 <free+0x44>
      p->s.size += bp->s.size;
 864:	ff852703          	lw	a4,-8(a0)
 868:	9f31                	addw	a4,a4,a2
 86a:	c798                	sw	a4,8(a5)
      p->s.ptr = bp->s.ptr;
 86c:	ff053683          	ld	a3,-16(a0)
 870:	bfd1                	j	844 <free+0x58>

0000000000000872 <malloc>:
  return freep;
}

void *
malloc (uint nbytes)
{
 872:	7139                	addi	sp,sp,-64
 874:	fc06                	sd	ra,56(sp)
 876:	f822                	sd	s0,48(sp)
 878:	f04a                	sd	s2,32(sp)
 87a:	ec4e                	sd	s3,24(sp)
 87c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof (Header) - 1) / sizeof (Header) + 1;
 87e:	02051993          	slli	s3,a0,0x20
 882:	0209d993          	srli	s3,s3,0x20
 886:	09bd                	addi	s3,s3,15
 888:	0049d993          	srli	s3,s3,0x4
 88c:	2985                	addiw	s3,s3,1
 88e:	894e                	mv	s2,s3
  if ((prevp = freep) == 0)
 890:	00000517          	auipc	a0,0x0
 894:	77053503          	ld	a0,1904(a0) # 1000 <freep>
 898:	c905                	beqz	a0,8c8 <malloc+0x56>
    {
      base.s.ptr = freep = prevp = &base;
      base.s.size = 0;
    }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 89a:	611c                	ld	a5,0(a0)
    {
      if (p->s.size >= nunits)
 89c:	4798                	lw	a4,8(a5)
 89e:	09377663          	bgeu	a4,s3,92a <malloc+0xb8>
 8a2:	f426                	sd	s1,40(sp)
 8a4:	e852                	sd	s4,16(sp)
 8a6:	e456                	sd	s5,8(sp)
 8a8:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 8aa:	8a4e                	mv	s4,s3
 8ac:	6705                	lui	a4,0x1
 8ae:	00e9f363          	bgeu	s3,a4,8b4 <malloc+0x42>
 8b2:	6a05                	lui	s4,0x1
 8b4:	000a0b1b          	sext.w	s6,s4
  p = sbrk (nu * sizeof (Header));
 8b8:	004a1a1b          	slliw	s4,s4,0x4
              p->s.size = nunits;
            }
          freep = prevp;
          return (void *)(p + 1);
        }
      if (p == freep)
 8bc:	00000497          	auipc	s1,0x0
 8c0:	74448493          	addi	s1,s1,1860 # 1000 <freep>
  if (p == (char *)-1)
 8c4:	5afd                	li	s5,-1
 8c6:	a83d                	j	904 <malloc+0x92>
 8c8:	f426                	sd	s1,40(sp)
 8ca:	e852                	sd	s4,16(sp)
 8cc:	e456                	sd	s5,8(sp)
 8ce:	e05a                	sd	s6,0(sp)
      base.s.ptr = freep = prevp = &base;
 8d0:	00001797          	auipc	a5,0x1
 8d4:	94078793          	addi	a5,a5,-1728 # 1210 <base>
 8d8:	00000717          	auipc	a4,0x0
 8dc:	72f73423          	sd	a5,1832(a4) # 1000 <freep>
 8e0:	e39c                	sd	a5,0(a5)
      base.s.size = 0;
 8e2:	0007a423          	sw	zero,8(a5)
      if (p->s.size >= nunits)
 8e6:	b7d1                	j	8aa <malloc+0x38>
            prevp->s.ptr = p->s.ptr;
 8e8:	6398                	ld	a4,0(a5)
 8ea:	e118                	sd	a4,0(a0)
 8ec:	a899                	j	942 <malloc+0xd0>
  hp->s.size = nu;
 8ee:	01652423          	sw	s6,8(a0)
  free ((void *)(hp + 1));
 8f2:	0541                	addi	a0,a0,16
 8f4:	ef9ff0ef          	jal	7ec <free>
  return freep;
 8f8:	6088                	ld	a0,0(s1)
        if ((p = morecore (nunits)) == 0)
 8fa:	c125                	beqz	a0,95a <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 8fc:	611c                	ld	a5,0(a0)
      if (p->s.size >= nunits)
 8fe:	4798                	lw	a4,8(a5)
 900:	03277163          	bgeu	a4,s2,922 <malloc+0xb0>
      if (p == freep)
 904:	6098                	ld	a4,0(s1)
 906:	853e                	mv	a0,a5
 908:	fef71ae3          	bne	a4,a5,8fc <malloc+0x8a>
  p = sbrk (nu * sizeof (Header));
 90c:	8552                	mv	a0,s4
 90e:	afdff0ef          	jal	40a <sbrk>
  if (p == (char *)-1)
 912:	fd551ee3          	bne	a0,s5,8ee <malloc+0x7c>
          return 0;
 916:	4501                	li	a0,0
 918:	74a2                	ld	s1,40(sp)
 91a:	6a42                	ld	s4,16(sp)
 91c:	6aa2                	ld	s5,8(sp)
 91e:	6b02                	ld	s6,0(sp)
 920:	a03d                	j	94e <malloc+0xdc>
 922:	74a2                	ld	s1,40(sp)
 924:	6a42                	ld	s4,16(sp)
 926:	6aa2                	ld	s5,8(sp)
 928:	6b02                	ld	s6,0(sp)
          if (p->s.size == nunits)
 92a:	fae90fe3          	beq	s2,a4,8e8 <malloc+0x76>
              p->s.size -= nunits;
 92e:	4137073b          	subw	a4,a4,s3
 932:	c798                	sw	a4,8(a5)
              p += p->s.size;
 934:	02071693          	slli	a3,a4,0x20
 938:	01c6d713          	srli	a4,a3,0x1c
 93c:	97ba                	add	a5,a5,a4
              p->s.size = nunits;
 93e:	0137a423          	sw	s3,8(a5)
          freep = prevp;
 942:	00000717          	auipc	a4,0x0
 946:	6aa73f23          	sd	a0,1726(a4) # 1000 <freep>
          return (void *)(p + 1);
 94a:	01078513          	addi	a0,a5,16
    }
}
 94e:	70e2                	ld	ra,56(sp)
 950:	7442                	ld	s0,48(sp)
 952:	7902                	ld	s2,32(sp)
 954:	69e2                	ld	s3,24(sp)
 956:	6121                	addi	sp,sp,64
 958:	8082                	ret
 95a:	74a2                	ld	s1,40(sp)
 95c:	6a42                	ld	s4,16(sp)
 95e:	6aa2                	ld	s5,8(sp)
 960:	6b02                	ld	s6,0(sp)
 962:	b7f5                	j	94e <malloc+0xdc>
