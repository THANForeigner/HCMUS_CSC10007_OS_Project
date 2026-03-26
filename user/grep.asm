
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
}

// matchstar: search for c*re at beginning of text
int
matchstar (int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do
    { // a * matches zero or more instances
      if (matchhere (re, text))
        return 1;
    }
  while (*text != '\0' && (*text++ == c || c == '.'));
  16:	fd250a13          	addi	s4,a0,-46
  1a:	001a3a13          	seqz	s4,s4
      if (matchhere (re, text))
  1e:	85a6                	mv	a1,s1
  20:	854e                	mv	a0,s3
  22:	02a000ef          	jal	4c <matchhere>
  26:	e911                	bnez	a0,3a <matchstar+0x3a>
  while (*text != '\0' && (*text++ == c || c == '.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb81                	beqz	a5,3c <matchstar+0x3c>
  2e:	0485                	addi	s1,s1,1
  30:	ff2787e3          	beq	a5,s2,1e <matchstar+0x1e>
  34:	fe0a15e3          	bnez	s4,1e <matchstar+0x1e>
  38:	a011                	j	3c <matchstar+0x3c>
        return 1;
  3a:	4505                	li	a0,1
  return 0;
}
  3c:	70a2                	ld	ra,40(sp)
  3e:	7402                	ld	s0,32(sp)
  40:	64e2                	ld	s1,24(sp)
  42:	6942                	ld	s2,16(sp)
  44:	69a2                	ld	s3,8(sp)
  46:	6a02                	ld	s4,0(sp)
  48:	6145                	addi	sp,sp,48
  4a:	8082                	ret

000000000000004c <matchhere>:
  if (re[0] == '\0')
  4c:	00054703          	lbu	a4,0(a0)
  50:	cf39                	beqz	a4,ae <matchhere+0x62>
{
  52:	1141                	addi	sp,sp,-16
  54:	e406                	sd	ra,8(sp)
  56:	e022                	sd	s0,0(sp)
  58:	0800                	addi	s0,sp,16
  5a:	87aa                	mv	a5,a0
  if (re[1] == '*')
  5c:	00154683          	lbu	a3,1(a0)
  60:	02a00613          	li	a2,42
  64:	02c68363          	beq	a3,a2,8a <matchhere+0x3e>
  if (re[0] == '$' && re[1] == '\0')
  68:	e681                	bnez	a3,70 <matchhere+0x24>
  6a:	fdc70693          	addi	a3,a4,-36
  6e:	c68d                	beqz	a3,98 <matchhere+0x4c>
  if (*text != '\0' && (re[0] == '.' || re[0] == *text))
  70:	0005c683          	lbu	a3,0(a1)
  return 0;
  74:	4501                	li	a0,0
  if (*text != '\0' && (re[0] == '.' || re[0] == *text))
  76:	c691                	beqz	a3,82 <matchhere+0x36>
  78:	02d70563          	beq	a4,a3,a2 <matchhere+0x56>
  7c:	fd270713          	addi	a4,a4,-46
  80:	c30d                	beqz	a4,a2 <matchhere+0x56>
}
  82:	60a2                	ld	ra,8(sp)
  84:	6402                	ld	s0,0(sp)
  86:	0141                	addi	sp,sp,16
  88:	8082                	ret
    return matchstar (re[0], re + 2, text);
  8a:	862e                	mv	a2,a1
  8c:	00250593          	addi	a1,a0,2
  90:	853a                	mv	a0,a4
  92:	f6fff0ef          	jal	0 <matchstar>
  96:	b7f5                	j	82 <matchhere+0x36>
    return *text == '\0';
  98:	0005c503          	lbu	a0,0(a1)
  9c:	00153513          	seqz	a0,a0
  a0:	b7cd                	j	82 <matchhere+0x36>
    return matchhere (re + 1, text + 1);
  a2:	0585                	addi	a1,a1,1
  a4:	00178513          	addi	a0,a5,1
  a8:	fa5ff0ef          	jal	4c <matchhere>
  ac:	bfd9                	j	82 <matchhere+0x36>
    return 1;
  ae:	4505                	li	a0,1
}
  b0:	8082                	ret

00000000000000b2 <match>:
{
  b2:	1101                	addi	sp,sp,-32
  b4:	ec06                	sd	ra,24(sp)
  b6:	e822                	sd	s0,16(sp)
  b8:	e426                	sd	s1,8(sp)
  ba:	e04a                	sd	s2,0(sp)
  bc:	1000                	addi	s0,sp,32
  be:	892a                	mv	s2,a0
  c0:	84ae                	mv	s1,a1
  if (re[0] == '^')
  c2:	00054703          	lbu	a4,0(a0)
  c6:	05e00793          	li	a5,94
  ca:	00f70c63          	beq	a4,a5,e2 <match+0x30>
      if (matchhere (re, text))
  ce:	85a6                	mv	a1,s1
  d0:	854a                	mv	a0,s2
  d2:	f7bff0ef          	jal	4c <matchhere>
  d6:	e911                	bnez	a0,ea <match+0x38>
  while (*text++ != '\0');
  d8:	0485                	addi	s1,s1,1
  da:	fff4c783          	lbu	a5,-1(s1)
  de:	fbe5                	bnez	a5,ce <match+0x1c>
  e0:	a031                	j	ec <match+0x3a>
    return matchhere (re + 1, text);
  e2:	0505                	addi	a0,a0,1
  e4:	f69ff0ef          	jal	4c <matchhere>
  e8:	a011                	j	ec <match+0x3a>
        return 1;
  ea:	4505                	li	a0,1
}
  ec:	60e2                	ld	ra,24(sp)
  ee:	6442                	ld	s0,16(sp)
  f0:	64a2                	ld	s1,8(sp)
  f2:	6902                	ld	s2,0(sp)
  f4:	6105                	addi	sp,sp,32
  f6:	8082                	ret

00000000000000f8 <grep>:
{
  f8:	711d                	addi	sp,sp,-96
  fa:	ec86                	sd	ra,88(sp)
  fc:	e8a2                	sd	s0,80(sp)
  fe:	e4a6                	sd	s1,72(sp)
 100:	e0ca                	sd	s2,64(sp)
 102:	fc4e                	sd	s3,56(sp)
 104:	f852                	sd	s4,48(sp)
 106:	f456                	sd	s5,40(sp)
 108:	f05a                	sd	s6,32(sp)
 10a:	ec5e                	sd	s7,24(sp)
 10c:	e862                	sd	s8,16(sp)
 10e:	e466                	sd	s9,8(sp)
 110:	e06a                	sd	s10,0(sp)
 112:	1080                	addi	s0,sp,96
 114:	8aaa                	mv	s5,a0
 116:	8cae                	mv	s9,a1
  m = 0;
 118:	4b01                	li	s6,0
  while ((n = read (fd, buf + m, sizeof (buf) - m - 1)) > 0)
 11a:	3ff00d13          	li	s10,1023
 11e:	00002b97          	auipc	s7,0x2
 122:	ef2b8b93          	addi	s7,s7,-270 # 2010 <buf>
      while ((q = strchr (p, '\n')) != 0)
 126:	49a9                	li	s3,10
              write (1, p, q + 1 - p);
 128:	4c05                	li	s8,1
  while ((n = read (fd, buf + m, sizeof (buf) - m - 1)) > 0)
 12a:	a82d                	j	164 <grep+0x6c>
          p = q + 1;
 12c:	00148913          	addi	s2,s1,1
      while ((q = strchr (p, '\n')) != 0)
 130:	85ce                	mv	a1,s3
 132:	854a                	mv	a0,s2
 134:	1dc000ef          	jal	310 <strchr>
 138:	84aa                	mv	s1,a0
 13a:	c11d                	beqz	a0,160 <grep+0x68>
          *q = 0;
 13c:	00048023          	sb	zero,0(s1)
          if (match (pattern, p))
 140:	85ca                	mv	a1,s2
 142:	8556                	mv	a0,s5
 144:	f6fff0ef          	jal	b2 <match>
 148:	d175                	beqz	a0,12c <grep+0x34>
              *q = '\n';
 14a:	01348023          	sb	s3,0(s1)
              write (1, p, q + 1 - p);
 14e:	00148613          	addi	a2,s1,1
 152:	4126063b          	subw	a2,a2,s2
 156:	85ca                	mv	a1,s2
 158:	8562                	mv	a0,s8
 15a:	3ae000ef          	jal	508 <write>
 15e:	b7f9                	j	12c <grep+0x34>
      if (m > 0)
 160:	03604463          	bgtz	s6,188 <grep+0x90>
  while ((n = read (fd, buf + m, sizeof (buf) - m - 1)) > 0)
 164:	416d063b          	subw	a2,s10,s6
 168:	016b85b3          	add	a1,s7,s6
 16c:	8566                	mv	a0,s9
 16e:	392000ef          	jal	500 <read>
 172:	02a05c63          	blez	a0,1aa <grep+0xb2>
      m += n;
 176:	00ab0a3b          	addw	s4,s6,a0
 17a:	8b52                	mv	s6,s4
      buf[m] = '\0';
 17c:	014b87b3          	add	a5,s7,s4
 180:	00078023          	sb	zero,0(a5)
      p = buf;
 184:	895e                	mv	s2,s7
      while ((q = strchr (p, '\n')) != 0)
 186:	b76d                	j	130 <grep+0x38>
          m -= p - buf;
 188:	00002797          	auipc	a5,0x2
 18c:	e8878793          	addi	a5,a5,-376 # 2010 <buf>
 190:	40f907b3          	sub	a5,s2,a5
 194:	40fa063b          	subw	a2,s4,a5
 198:	8b32                	mv	s6,a2
          memmove (buf, p, m);
 19a:	85ca                	mv	a1,s2
 19c:	00002517          	auipc	a0,0x2
 1a0:	e7450513          	addi	a0,a0,-396 # 2010 <buf>
 1a4:	292000ef          	jal	436 <memmove>
 1a8:	bf75                	j	164 <grep+0x6c>
}
 1aa:	60e6                	ld	ra,88(sp)
 1ac:	6446                	ld	s0,80(sp)
 1ae:	64a6                	ld	s1,72(sp)
 1b0:	6906                	ld	s2,64(sp)
 1b2:	79e2                	ld	s3,56(sp)
 1b4:	7a42                	ld	s4,48(sp)
 1b6:	7aa2                	ld	s5,40(sp)
 1b8:	7b02                	ld	s6,32(sp)
 1ba:	6be2                	ld	s7,24(sp)
 1bc:	6c42                	ld	s8,16(sp)
 1be:	6ca2                	ld	s9,8(sp)
 1c0:	6d02                	ld	s10,0(sp)
 1c2:	6125                	addi	sp,sp,96
 1c4:	8082                	ret

00000000000001c6 <main>:
{
 1c6:	7179                	addi	sp,sp,-48
 1c8:	f406                	sd	ra,40(sp)
 1ca:	f022                	sd	s0,32(sp)
 1cc:	ec26                	sd	s1,24(sp)
 1ce:	e84a                	sd	s2,16(sp)
 1d0:	e44e                	sd	s3,8(sp)
 1d2:	e052                	sd	s4,0(sp)
 1d4:	1800                	addi	s0,sp,48
  if (argc <= 1)
 1d6:	4785                	li	a5,1
 1d8:	04a7d663          	bge	a5,a0,224 <main+0x5e>
  pattern = argv[1];
 1dc:	0085ba03          	ld	s4,8(a1)
  if (argc <= 2)
 1e0:	4789                	li	a5,2
 1e2:	04a7db63          	bge	a5,a0,238 <main+0x72>
 1e6:	01058913          	addi	s2,a1,16
 1ea:	ffd5099b          	addiw	s3,a0,-3
 1ee:	02099793          	slli	a5,s3,0x20
 1f2:	01d7d993          	srli	s3,a5,0x1d
 1f6:	05e1                	addi	a1,a1,24
 1f8:	99ae                	add	s3,s3,a1
      if ((fd = open (argv[i], O_RDONLY)) < 0)
 1fa:	4581                	li	a1,0
 1fc:	00093503          	ld	a0,0(s2)
 200:	328000ef          	jal	528 <open>
 204:	84aa                	mv	s1,a0
 206:	04054063          	bltz	a0,246 <main+0x80>
      grep (pattern, fd);
 20a:	85aa                	mv	a1,a0
 20c:	8552                	mv	a0,s4
 20e:	eebff0ef          	jal	f8 <grep>
      close (fd);
 212:	8526                	mv	a0,s1
 214:	2fc000ef          	jal	510 <close>
  for (i = 2; i < argc; i++)
 218:	0921                	addi	s2,s2,8
 21a:	ff3910e3          	bne	s2,s3,1fa <main+0x34>
  exit (0);
 21e:	4501                	li	a0,0
 220:	2c8000ef          	jal	4e8 <exit>
      fprintf (2, "usage: grep pattern [file ...]\n");
 224:	00001597          	auipc	a1,0x1
 228:	8ac58593          	addi	a1,a1,-1876 # ad0 <malloc+0xf8>
 22c:	4509                	li	a0,2
 22e:	6c8000ef          	jal	8f6 <fprintf>
      exit (1);
 232:	4505                	li	a0,1
 234:	2b4000ef          	jal	4e8 <exit>
      grep (pattern, 0);
 238:	4581                	li	a1,0
 23a:	8552                	mv	a0,s4
 23c:	ebdff0ef          	jal	f8 <grep>
      exit (0);
 240:	4501                	li	a0,0
 242:	2a6000ef          	jal	4e8 <exit>
          printf ("grep: cannot open %s\n", argv[i]);
 246:	00093583          	ld	a1,0(s2)
 24a:	00001517          	auipc	a0,0x1
 24e:	8a650513          	addi	a0,a0,-1882 # af0 <malloc+0x118>
 252:	6ce000ef          	jal	920 <printf>
          exit (1);
 256:	4505                	li	a0,1
 258:	290000ef          	jal	4e8 <exit>

000000000000025c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start ()
{
 25c:	1141                	addi	sp,sp,-16
 25e:	e406                	sd	ra,8(sp)
 260:	e022                	sd	s0,0(sp)
 262:	0800                	addi	s0,sp,16
  extern int main ();
  main ();
 264:	f63ff0ef          	jal	1c6 <main>
  exit (0);
 268:	4501                	li	a0,0
 26a:	27e000ef          	jal	4e8 <exit>

000000000000026e <strcpy>:
}

char *
strcpy (char *s, const char *t)
{
 26e:	1141                	addi	sp,sp,-16
 270:	e406                	sd	ra,8(sp)
 272:	e022                	sd	s0,0(sp)
 274:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 276:	87aa                	mv	a5,a0
 278:	0585                	addi	a1,a1,1
 27a:	0785                	addi	a5,a5,1
 27c:	fff5c703          	lbu	a4,-1(a1)
 280:	fee78fa3          	sb	a4,-1(a5)
 284:	fb75                	bnez	a4,278 <strcpy+0xa>
    ;
  return os;
}
 286:	60a2                	ld	ra,8(sp)
 288:	6402                	ld	s0,0(sp)
 28a:	0141                	addi	sp,sp,16
 28c:	8082                	ret

000000000000028e <strcmp>:

int
strcmp (const char *p, const char *q)
{
 28e:	1141                	addi	sp,sp,-16
 290:	e406                	sd	ra,8(sp)
 292:	e022                	sd	s0,0(sp)
 294:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 296:	00054783          	lbu	a5,0(a0)
 29a:	cb91                	beqz	a5,2ae <strcmp+0x20>
 29c:	0005c703          	lbu	a4,0(a1)
 2a0:	00f71763          	bne	a4,a5,2ae <strcmp+0x20>
    p++, q++;
 2a4:	0505                	addi	a0,a0,1
 2a6:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 2a8:	00054783          	lbu	a5,0(a0)
 2ac:	fbe5                	bnez	a5,29c <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 2ae:	0005c503          	lbu	a0,0(a1)
}
 2b2:	40a7853b          	subw	a0,a5,a0
 2b6:	60a2                	ld	ra,8(sp)
 2b8:	6402                	ld	s0,0(sp)
 2ba:	0141                	addi	sp,sp,16
 2bc:	8082                	ret

00000000000002be <strlen>:

uint
strlen (const char *s)
{
 2be:	1141                	addi	sp,sp,-16
 2c0:	e406                	sd	ra,8(sp)
 2c2:	e022                	sd	s0,0(sp)
 2c4:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 2c6:	00054783          	lbu	a5,0(a0)
 2ca:	cf91                	beqz	a5,2e6 <strlen+0x28>
 2cc:	00150793          	addi	a5,a0,1
 2d0:	86be                	mv	a3,a5
 2d2:	0785                	addi	a5,a5,1
 2d4:	fff7c703          	lbu	a4,-1(a5)
 2d8:	ff65                	bnez	a4,2d0 <strlen+0x12>
 2da:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 2de:	60a2                	ld	ra,8(sp)
 2e0:	6402                	ld	s0,0(sp)
 2e2:	0141                	addi	sp,sp,16
 2e4:	8082                	ret
  for (n = 0; s[n]; n++)
 2e6:	4501                	li	a0,0
 2e8:	bfdd                	j	2de <strlen+0x20>

00000000000002ea <memset>:

void *
memset (void *dst, int c, uint n)
{
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e406                	sd	ra,8(sp)
 2ee:	e022                	sd	s0,0(sp)
 2f0:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
 2f2:	ca19                	beqz	a2,308 <memset+0x1e>
 2f4:	87aa                	mv	a5,a0
 2f6:	1602                	slli	a2,a2,0x20
 2f8:	9201                	srli	a2,a2,0x20
 2fa:	00a60733          	add	a4,a2,a0
    {
      cdst[i] = c;
 2fe:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 302:	0785                	addi	a5,a5,1
 304:	fee79de3          	bne	a5,a4,2fe <memset+0x14>
    }
  return dst;
}
 308:	60a2                	ld	ra,8(sp)
 30a:	6402                	ld	s0,0(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret

0000000000000310 <strchr>:

char *
strchr (const char *s, char c)
{
 310:	1141                	addi	sp,sp,-16
 312:	e406                	sd	ra,8(sp)
 314:	e022                	sd	s0,0(sp)
 316:	0800                	addi	s0,sp,16
  for (; *s; s++)
 318:	00054783          	lbu	a5,0(a0)
 31c:	cf81                	beqz	a5,334 <strchr+0x24>
    if (*s == c)
 31e:	00f58763          	beq	a1,a5,32c <strchr+0x1c>
  for (; *s; s++)
 322:	0505                	addi	a0,a0,1
 324:	00054783          	lbu	a5,0(a0)
 328:	fbfd                	bnez	a5,31e <strchr+0xe>
      return (char *)s;
  return 0;
 32a:	4501                	li	a0,0
}
 32c:	60a2                	ld	ra,8(sp)
 32e:	6402                	ld	s0,0(sp)
 330:	0141                	addi	sp,sp,16
 332:	8082                	ret
  return 0;
 334:	4501                	li	a0,0
 336:	bfdd                	j	32c <strchr+0x1c>

0000000000000338 <gets>:

char *
gets (char *buf, int max)
{
 338:	711d                	addi	sp,sp,-96
 33a:	ec86                	sd	ra,88(sp)
 33c:	e8a2                	sd	s0,80(sp)
 33e:	e4a6                	sd	s1,72(sp)
 340:	e0ca                	sd	s2,64(sp)
 342:	fc4e                	sd	s3,56(sp)
 344:	f852                	sd	s4,48(sp)
 346:	f456                	sd	s5,40(sp)
 348:	f05a                	sd	s6,32(sp)
 34a:	ec5e                	sd	s7,24(sp)
 34c:	e862                	sd	s8,16(sp)
 34e:	1080                	addi	s0,sp,96
 350:	8baa                	mv	s7,a0
 352:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 354:	892a                	mv	s2,a0
 356:	4481                	li	s1,0
    {
      cc = read (0, &c, 1);
 358:	faf40b13          	addi	s6,s0,-81
 35c:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;)
 35e:	8c26                	mv	s8,s1
 360:	0014899b          	addiw	s3,s1,1
 364:	84ce                	mv	s1,s3
 366:	0349d463          	bge	s3,s4,38e <gets+0x56>
      cc = read (0, &c, 1);
 36a:	8656                	mv	a2,s5
 36c:	85da                	mv	a1,s6
 36e:	4501                	li	a0,0
 370:	190000ef          	jal	500 <read>
      if (cc < 1)
 374:	00a05d63          	blez	a0,38e <gets+0x56>
        break;
      buf[i++] = c;
 378:	faf44783          	lbu	a5,-81(s0)
 37c:	00f90023          	sb	a5,0(s2)
      if (c == '\n' || c == '\r')
 380:	0905                	addi	s2,s2,1
 382:	ff678713          	addi	a4,a5,-10
 386:	c319                	beqz	a4,38c <gets+0x54>
 388:	17cd                	addi	a5,a5,-13
 38a:	fbf1                	bnez	a5,35e <gets+0x26>
      buf[i++] = c;
 38c:	8c4e                	mv	s8,s3
        break;
    }
  buf[i] = '\0';
 38e:	9c5e                	add	s8,s8,s7
 390:	000c0023          	sb	zero,0(s8)
  return buf;
}
 394:	855e                	mv	a0,s7
 396:	60e6                	ld	ra,88(sp)
 398:	6446                	ld	s0,80(sp)
 39a:	64a6                	ld	s1,72(sp)
 39c:	6906                	ld	s2,64(sp)
 39e:	79e2                	ld	s3,56(sp)
 3a0:	7a42                	ld	s4,48(sp)
 3a2:	7aa2                	ld	s5,40(sp)
 3a4:	7b02                	ld	s6,32(sp)
 3a6:	6be2                	ld	s7,24(sp)
 3a8:	6c42                	ld	s8,16(sp)
 3aa:	6125                	addi	sp,sp,96
 3ac:	8082                	ret

00000000000003ae <stat>:

int
stat (const char *n, struct stat *st)
{
 3ae:	1101                	addi	sp,sp,-32
 3b0:	ec06                	sd	ra,24(sp)
 3b2:	e822                	sd	s0,16(sp)
 3b4:	e04a                	sd	s2,0(sp)
 3b6:	1000                	addi	s0,sp,32
 3b8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open (n, O_RDONLY);
 3ba:	4581                	li	a1,0
 3bc:	16c000ef          	jal	528 <open>
  if (fd < 0)
 3c0:	02054263          	bltz	a0,3e4 <stat+0x36>
 3c4:	e426                	sd	s1,8(sp)
 3c6:	84aa                	mv	s1,a0
    return -1;
  r = fstat (fd, st);
 3c8:	85ca                	mv	a1,s2
 3ca:	176000ef          	jal	540 <fstat>
 3ce:	892a                	mv	s2,a0
  close (fd);
 3d0:	8526                	mv	a0,s1
 3d2:	13e000ef          	jal	510 <close>
  return r;
 3d6:	64a2                	ld	s1,8(sp)
}
 3d8:	854a                	mv	a0,s2
 3da:	60e2                	ld	ra,24(sp)
 3dc:	6442                	ld	s0,16(sp)
 3de:	6902                	ld	s2,0(sp)
 3e0:	6105                	addi	sp,sp,32
 3e2:	8082                	ret
    return -1;
 3e4:	57fd                	li	a5,-1
 3e6:	893e                	mv	s2,a5
 3e8:	bfc5                	j	3d8 <stat+0x2a>

00000000000003ea <atoi>:

int
atoi (const char *s)
{
 3ea:	1141                	addi	sp,sp,-16
 3ec:	e406                	sd	ra,8(sp)
 3ee:	e022                	sd	s0,0(sp)
 3f0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 3f2:	00054683          	lbu	a3,0(a0)
 3f6:	fd06879b          	addiw	a5,a3,-48
 3fa:	0ff7f793          	zext.b	a5,a5
 3fe:	4625                	li	a2,9
 400:	02f66963          	bltu	a2,a5,432 <atoi+0x48>
 404:	872a                	mv	a4,a0
  n = 0;
 406:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 408:	0705                	addi	a4,a4,1
 40a:	0025179b          	slliw	a5,a0,0x2
 40e:	9fa9                	addw	a5,a5,a0
 410:	0017979b          	slliw	a5,a5,0x1
 414:	9fb5                	addw	a5,a5,a3
 416:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 41a:	00074683          	lbu	a3,0(a4)
 41e:	fd06879b          	addiw	a5,a3,-48
 422:	0ff7f793          	zext.b	a5,a5
 426:	fef671e3          	bgeu	a2,a5,408 <atoi+0x1e>
  return n;
}
 42a:	60a2                	ld	ra,8(sp)
 42c:	6402                	ld	s0,0(sp)
 42e:	0141                	addi	sp,sp,16
 430:	8082                	ret
  n = 0;
 432:	4501                	li	a0,0
 434:	bfdd                	j	42a <atoi+0x40>

0000000000000436 <memmove>:

void *
memmove (void *vdst, const void *vsrc, int n)
{
 436:	1141                	addi	sp,sp,-16
 438:	e406                	sd	ra,8(sp)
 43a:	e022                	sd	s0,0(sp)
 43c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 43e:	02b57563          	bgeu	a0,a1,468 <memmove+0x32>
    {
      while (n-- > 0)
 442:	00c05f63          	blez	a2,460 <memmove+0x2a>
 446:	1602                	slli	a2,a2,0x20
 448:	9201                	srli	a2,a2,0x20
 44a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 44e:	872a                	mv	a4,a0
        *dst++ = *src++;
 450:	0585                	addi	a1,a1,1
 452:	0705                	addi	a4,a4,1
 454:	fff5c683          	lbu	a3,-1(a1)
 458:	fed70fa3          	sb	a3,-1(a4)
      while (n-- > 0)
 45c:	fee79ae3          	bne	a5,a4,450 <memmove+0x1a>
      src += n;
      while (n-- > 0)
        *--dst = *--src;
    }
  return vdst;
}
 460:	60a2                	ld	ra,8(sp)
 462:	6402                	ld	s0,0(sp)
 464:	0141                	addi	sp,sp,16
 466:	8082                	ret
      while (n-- > 0)
 468:	fec05ce3          	blez	a2,460 <memmove+0x2a>
      dst += n;
 46c:	00c50733          	add	a4,a0,a2
      src += n;
 470:	95b2                	add	a1,a1,a2
 472:	fff6079b          	addiw	a5,a2,-1
 476:	1782                	slli	a5,a5,0x20
 478:	9381                	srli	a5,a5,0x20
 47a:	fff7c793          	not	a5,a5
 47e:	97ba                	add	a5,a5,a4
        *--dst = *--src;
 480:	15fd                	addi	a1,a1,-1
 482:	177d                	addi	a4,a4,-1
 484:	0005c683          	lbu	a3,0(a1)
 488:	00d70023          	sb	a3,0(a4)
      while (n-- > 0)
 48c:	fef71ae3          	bne	a4,a5,480 <memmove+0x4a>
 490:	bfc1                	j	460 <memmove+0x2a>

0000000000000492 <memcmp>:

int
memcmp (const void *s1, const void *s2, uint n)
{
 492:	1141                	addi	sp,sp,-16
 494:	e406                	sd	ra,8(sp)
 496:	e022                	sd	s0,0(sp)
 498:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 49a:	c61d                	beqz	a2,4c8 <memcmp+0x36>
 49c:	1602                	slli	a2,a2,0x20
 49e:	9201                	srli	a2,a2,0x20
 4a0:	00c506b3          	add	a3,a0,a2
    {
      if (*p1 != *p2)
 4a4:	00054783          	lbu	a5,0(a0)
 4a8:	0005c703          	lbu	a4,0(a1)
 4ac:	00e79863          	bne	a5,a4,4bc <memcmp+0x2a>
        {
          return *p1 - *p2;
        }
      p1++;
 4b0:	0505                	addi	a0,a0,1
      p2++;
 4b2:	0585                	addi	a1,a1,1
  while (n-- > 0)
 4b4:	fed518e3          	bne	a0,a3,4a4 <memcmp+0x12>
    }
  return 0;
 4b8:	4501                	li	a0,0
 4ba:	a019                	j	4c0 <memcmp+0x2e>
          return *p1 - *p2;
 4bc:	40e7853b          	subw	a0,a5,a4
}
 4c0:	60a2                	ld	ra,8(sp)
 4c2:	6402                	ld	s0,0(sp)
 4c4:	0141                	addi	sp,sp,16
 4c6:	8082                	ret
  return 0;
 4c8:	4501                	li	a0,0
 4ca:	bfdd                	j	4c0 <memcmp+0x2e>

00000000000004cc <memcpy>:

void *
memcpy (void *dst, const void *src, uint n)
{
 4cc:	1141                	addi	sp,sp,-16
 4ce:	e406                	sd	ra,8(sp)
 4d0:	e022                	sd	s0,0(sp)
 4d2:	0800                	addi	s0,sp,16
  return memmove (dst, src, n);
 4d4:	f63ff0ef          	jal	436 <memmove>
}
 4d8:	60a2                	ld	ra,8(sp)
 4da:	6402                	ld	s0,0(sp)
 4dc:	0141                	addi	sp,sp,16
 4de:	8082                	ret

00000000000004e0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4e0:	4885                	li	a7,1
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4e8:	4889                	li	a7,2
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4f0:	488d                	li	a7,3
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4f8:	4891                	li	a7,4
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <read>:
.global read
read:
 li a7, SYS_read
 500:	4895                	li	a7,5
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <write>:
.global write
write:
 li a7, SYS_write
 508:	48c1                	li	a7,16
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <close>:
.global close
close:
 li a7, SYS_close
 510:	48d5                	li	a7,21
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <kill>:
.global kill
kill:
 li a7, SYS_kill
 518:	4899                	li	a7,6
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <exec>:
.global exec
exec:
 li a7, SYS_exec
 520:	489d                	li	a7,7
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <open>:
.global open
open:
 li a7, SYS_open
 528:	48bd                	li	a7,15
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 530:	48c5                	li	a7,17
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 538:	48c9                	li	a7,18
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 540:	48a1                	li	a7,8
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <link>:
.global link
link:
 li a7, SYS_link
 548:	48cd                	li	a7,19
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 550:	48d1                	li	a7,20
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 558:	48a5                	li	a7,9
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <dup>:
.global dup
dup:
 li a7, SYS_dup
 560:	48a9                	li	a7,10
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 568:	48ad                	li	a7,11
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 570:	48b1                	li	a7,12
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 578:	48b5                	li	a7,13
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 580:	48b9                	li	a7,14
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <trace>:
.global trace
trace:
 li a7, SYS_trace
 588:	48d9                	li	a7,22
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 590:	1101                	addi	sp,sp,-32
 592:	ec06                	sd	ra,24(sp)
 594:	e822                	sd	s0,16(sp)
 596:	1000                	addi	s0,sp,32
 598:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 59c:	4605                	li	a2,1
 59e:	fef40593          	addi	a1,s0,-17
 5a2:	f67ff0ef          	jal	508 <write>
}
 5a6:	60e2                	ld	ra,24(sp)
 5a8:	6442                	ld	s0,16(sp)
 5aa:	6105                	addi	sp,sp,32
 5ac:	8082                	ret

00000000000005ae <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5ae:	7139                	addi	sp,sp,-64
 5b0:	fc06                	sd	ra,56(sp)
 5b2:	f822                	sd	s0,48(sp)
 5b4:	f04a                	sd	s2,32(sp)
 5b6:	ec4e                	sd	s3,24(sp)
 5b8:	0080                	addi	s0,sp,64
 5ba:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5bc:	cac9                	beqz	a3,64e <printint+0xa0>
 5be:	01f5d79b          	srliw	a5,a1,0x1f
 5c2:	c7d1                	beqz	a5,64e <printint+0xa0>
    neg = 1;
    x = -xx;
 5c4:	40b005bb          	negw	a1,a1
    neg = 1;
 5c8:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 5ca:	fc040993          	addi	s3,s0,-64
  neg = 0;
 5ce:	86ce                	mv	a3,s3
  i = 0;
 5d0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5d2:	00000817          	auipc	a6,0x0
 5d6:	53e80813          	addi	a6,a6,1342 # b10 <digits>
 5da:	88ba                	mv	a7,a4
 5dc:	0017051b          	addiw	a0,a4,1
 5e0:	872a                	mv	a4,a0
 5e2:	02c5f7bb          	remuw	a5,a1,a2
 5e6:	1782                	slli	a5,a5,0x20
 5e8:	9381                	srli	a5,a5,0x20
 5ea:	97c2                	add	a5,a5,a6
 5ec:	0007c783          	lbu	a5,0(a5)
 5f0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5f4:	87ae                	mv	a5,a1
 5f6:	02c5d5bb          	divuw	a1,a1,a2
 5fa:	0685                	addi	a3,a3,1
 5fc:	fcc7ffe3          	bgeu	a5,a2,5da <printint+0x2c>
  if(neg)
 600:	00030c63          	beqz	t1,618 <printint+0x6a>
    buf[i++] = '-';
 604:	fd050793          	addi	a5,a0,-48
 608:	00878533          	add	a0,a5,s0
 60c:	02d00793          	li	a5,45
 610:	fef50823          	sb	a5,-16(a0)
 614:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 618:	02e05563          	blez	a4,642 <printint+0x94>
 61c:	f426                	sd	s1,40(sp)
 61e:	377d                	addiw	a4,a4,-1
 620:	00e984b3          	add	s1,s3,a4
 624:	19fd                	addi	s3,s3,-1
 626:	99ba                	add	s3,s3,a4
 628:	1702                	slli	a4,a4,0x20
 62a:	9301                	srli	a4,a4,0x20
 62c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 630:	0004c583          	lbu	a1,0(s1)
 634:	854a                	mv	a0,s2
 636:	f5bff0ef          	jal	590 <putc>
  while(--i >= 0)
 63a:	14fd                	addi	s1,s1,-1
 63c:	ff349ae3          	bne	s1,s3,630 <printint+0x82>
 640:	74a2                	ld	s1,40(sp)
}
 642:	70e2                	ld	ra,56(sp)
 644:	7442                	ld	s0,48(sp)
 646:	7902                	ld	s2,32(sp)
 648:	69e2                	ld	s3,24(sp)
 64a:	6121                	addi	sp,sp,64
 64c:	8082                	ret
  neg = 0;
 64e:	4301                	li	t1,0
 650:	bfad                	j	5ca <printint+0x1c>

0000000000000652 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 652:	711d                	addi	sp,sp,-96
 654:	ec86                	sd	ra,88(sp)
 656:	e8a2                	sd	s0,80(sp)
 658:	e4a6                	sd	s1,72(sp)
 65a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 65c:	0005c483          	lbu	s1,0(a1)
 660:	20048963          	beqz	s1,872 <vprintf+0x220>
 664:	e0ca                	sd	s2,64(sp)
 666:	fc4e                	sd	s3,56(sp)
 668:	f852                	sd	s4,48(sp)
 66a:	f456                	sd	s5,40(sp)
 66c:	f05a                	sd	s6,32(sp)
 66e:	ec5e                	sd	s7,24(sp)
 670:	e862                	sd	s8,16(sp)
 672:	8b2a                	mv	s6,a0
 674:	8a2e                	mv	s4,a1
 676:	8bb2                	mv	s7,a2
  state = 0;
 678:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 67a:	4901                	li	s2,0
 67c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 67e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 682:	06400c13          	li	s8,100
 686:	a00d                	j	6a8 <vprintf+0x56>
        putc(fd, c0);
 688:	85a6                	mv	a1,s1
 68a:	855a                	mv	a0,s6
 68c:	f05ff0ef          	jal	590 <putc>
 690:	a019                	j	696 <vprintf+0x44>
    } else if(state == '%'){
 692:	03598363          	beq	s3,s5,6b8 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 696:	0019079b          	addiw	a5,s2,1
 69a:	893e                	mv	s2,a5
 69c:	873e                	mv	a4,a5
 69e:	97d2                	add	a5,a5,s4
 6a0:	0007c483          	lbu	s1,0(a5)
 6a4:	1c048063          	beqz	s1,864 <vprintf+0x212>
    c0 = fmt[i] & 0xff;
 6a8:	0004879b          	sext.w	a5,s1
    if(state == 0){
 6ac:	fe0993e3          	bnez	s3,692 <vprintf+0x40>
      if(c0 == '%'){
 6b0:	fd579ce3          	bne	a5,s5,688 <vprintf+0x36>
        state = '%';
 6b4:	89be                	mv	s3,a5
 6b6:	b7c5                	j	696 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 6b8:	00ea06b3          	add	a3,s4,a4
 6bc:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 6c0:	1a060e63          	beqz	a2,87c <vprintf+0x22a>
      if(c0 == 'd'){
 6c4:	03878763          	beq	a5,s8,6f2 <vprintf+0xa0>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 6c8:	f9478693          	addi	a3,a5,-108
 6cc:	0016b693          	seqz	a3,a3
 6d0:	f9c60593          	addi	a1,a2,-100
 6d4:	e99d                	bnez	a1,70a <vprintf+0xb8>
 6d6:	ca95                	beqz	a3,70a <vprintf+0xb8>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6d8:	008b8493          	addi	s1,s7,8
 6dc:	4685                	li	a3,1
 6de:	4629                	li	a2,10
 6e0:	000ba583          	lw	a1,0(s7)
 6e4:	855a                	mv	a0,s6
 6e6:	ec9ff0ef          	jal	5ae <printint>
        i += 1;
 6ea:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ec:	8ba6                	mv	s7,s1
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 6ee:	4981                	li	s3,0
 6f0:	b75d                	j	696 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 6f2:	008b8493          	addi	s1,s7,8
 6f6:	4685                	li	a3,1
 6f8:	4629                	li	a2,10
 6fa:	000ba583          	lw	a1,0(s7)
 6fe:	855a                	mv	a0,s6
 700:	eafff0ef          	jal	5ae <printint>
 704:	8ba6                	mv	s7,s1
      state = 0;
 706:	4981                	li	s3,0
 708:	b779                	j	696 <vprintf+0x44>
      if(c1) c2 = fmt[i+2] & 0xff;
 70a:	9752                	add	a4,a4,s4
 70c:	00274583          	lbu	a1,2(a4)
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 710:	f9460713          	addi	a4,a2,-108
 714:	00173713          	seqz	a4,a4
 718:	8f75                	and	a4,a4,a3
 71a:	f9c58513          	addi	a0,a1,-100
 71e:	16051963          	bnez	a0,890 <vprintf+0x23e>
 722:	16070763          	beqz	a4,890 <vprintf+0x23e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 726:	008b8493          	addi	s1,s7,8
 72a:	4685                	li	a3,1
 72c:	4629                	li	a2,10
 72e:	000ba583          	lw	a1,0(s7)
 732:	855a                	mv	a0,s6
 734:	e7bff0ef          	jal	5ae <printint>
        i += 2;
 738:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 73a:	8ba6                	mv	s7,s1
      state = 0;
 73c:	4981                	li	s3,0
        i += 2;
 73e:	bfa1                	j	696 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 0);
 740:	008b8493          	addi	s1,s7,8
 744:	4681                	li	a3,0
 746:	4629                	li	a2,10
 748:	000ba583          	lw	a1,0(s7)
 74c:	855a                	mv	a0,s6
 74e:	e61ff0ef          	jal	5ae <printint>
 752:	8ba6                	mv	s7,s1
      state = 0;
 754:	4981                	li	s3,0
 756:	b781                	j	696 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 758:	008b8493          	addi	s1,s7,8
 75c:	4681                	li	a3,0
 75e:	4629                	li	a2,10
 760:	000ba583          	lw	a1,0(s7)
 764:	855a                	mv	a0,s6
 766:	e49ff0ef          	jal	5ae <printint>
        i += 1;
 76a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 76c:	8ba6                	mv	s7,s1
      state = 0;
 76e:	4981                	li	s3,0
 770:	b71d                	j	696 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 772:	008b8493          	addi	s1,s7,8
 776:	4681                	li	a3,0
 778:	4629                	li	a2,10
 77a:	000ba583          	lw	a1,0(s7)
 77e:	855a                	mv	a0,s6
 780:	e2fff0ef          	jal	5ae <printint>
        i += 2;
 784:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 786:	8ba6                	mv	s7,s1
      state = 0;
 788:	4981                	li	s3,0
        i += 2;
 78a:	b731                	j	696 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 78c:	008b8493          	addi	s1,s7,8
 790:	4681                	li	a3,0
 792:	4641                	li	a2,16
 794:	000ba583          	lw	a1,0(s7)
 798:	855a                	mv	a0,s6
 79a:	e15ff0ef          	jal	5ae <printint>
 79e:	8ba6                	mv	s7,s1
      state = 0;
 7a0:	4981                	li	s3,0
 7a2:	bdd5                	j	696 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7a4:	008b8493          	addi	s1,s7,8
 7a8:	4681                	li	a3,0
 7aa:	4641                	li	a2,16
 7ac:	000ba583          	lw	a1,0(s7)
 7b0:	855a                	mv	a0,s6
 7b2:	dfdff0ef          	jal	5ae <printint>
        i += 1;
 7b6:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7b8:	8ba6                	mv	s7,s1
      state = 0;
 7ba:	4981                	li	s3,0
 7bc:	bde9                	j	696 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7be:	008b8493          	addi	s1,s7,8
 7c2:	4681                	li	a3,0
 7c4:	4641                	li	a2,16
 7c6:	000ba583          	lw	a1,0(s7)
 7ca:	855a                	mv	a0,s6
 7cc:	de3ff0ef          	jal	5ae <printint>
        i += 2;
 7d0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 7d2:	8ba6                	mv	s7,s1
      state = 0;
 7d4:	4981                	li	s3,0
        i += 2;
 7d6:	b5c1                	j	696 <vprintf+0x44>
 7d8:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 7da:	008b8793          	addi	a5,s7,8
 7de:	8cbe                	mv	s9,a5
 7e0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7e4:	03000593          	li	a1,48
 7e8:	855a                	mv	a0,s6
 7ea:	da7ff0ef          	jal	590 <putc>
  putc(fd, 'x');
 7ee:	07800593          	li	a1,120
 7f2:	855a                	mv	a0,s6
 7f4:	d9dff0ef          	jal	590 <putc>
 7f8:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7fa:	00000b97          	auipc	s7,0x0
 7fe:	316b8b93          	addi	s7,s7,790 # b10 <digits>
 802:	03c9d793          	srli	a5,s3,0x3c
 806:	97de                	add	a5,a5,s7
 808:	0007c583          	lbu	a1,0(a5)
 80c:	855a                	mv	a0,s6
 80e:	d83ff0ef          	jal	590 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 812:	0992                	slli	s3,s3,0x4
 814:	34fd                	addiw	s1,s1,-1
 816:	f4f5                	bnez	s1,802 <vprintf+0x1b0>
        printptr(fd, va_arg(ap, uint64));
 818:	8be6                	mv	s7,s9
      state = 0;
 81a:	4981                	li	s3,0
 81c:	6ca2                	ld	s9,8(sp)
 81e:	bda5                	j	696 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 820:	008b8993          	addi	s3,s7,8
 824:	000bb483          	ld	s1,0(s7)
 828:	cc91                	beqz	s1,844 <vprintf+0x1f2>
        for(; *s; s++)
 82a:	0004c583          	lbu	a1,0(s1)
 82e:	c985                	beqz	a1,85e <vprintf+0x20c>
          putc(fd, *s);
 830:	855a                	mv	a0,s6
 832:	d5fff0ef          	jal	590 <putc>
        for(; *s; s++)
 836:	0485                	addi	s1,s1,1
 838:	0004c583          	lbu	a1,0(s1)
 83c:	f9f5                	bnez	a1,830 <vprintf+0x1de>
        if((s = va_arg(ap, char*)) == 0)
 83e:	8bce                	mv	s7,s3
      state = 0;
 840:	4981                	li	s3,0
 842:	bd91                	j	696 <vprintf+0x44>
          s = "(null)";
 844:	00000497          	auipc	s1,0x0
 848:	2c448493          	addi	s1,s1,708 # b08 <malloc+0x130>
        for(; *s; s++)
 84c:	02800593          	li	a1,40
 850:	b7c5                	j	830 <vprintf+0x1de>
        putc(fd, '%');
 852:	85be                	mv	a1,a5
 854:	855a                	mv	a0,s6
 856:	d3bff0ef          	jal	590 <putc>
      state = 0;
 85a:	4981                	li	s3,0
 85c:	bd2d                	j	696 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 85e:	8bce                	mv	s7,s3
      state = 0;
 860:	4981                	li	s3,0
 862:	bd15                	j	696 <vprintf+0x44>
 864:	6906                	ld	s2,64(sp)
 866:	79e2                	ld	s3,56(sp)
 868:	7a42                	ld	s4,48(sp)
 86a:	7aa2                	ld	s5,40(sp)
 86c:	7b02                	ld	s6,32(sp)
 86e:	6be2                	ld	s7,24(sp)
 870:	6c42                	ld	s8,16(sp)
    }
  }
}
 872:	60e6                	ld	ra,88(sp)
 874:	6446                	ld	s0,80(sp)
 876:	64a6                	ld	s1,72(sp)
 878:	6125                	addi	sp,sp,96
 87a:	8082                	ret
      if(c0 == 'd'){
 87c:	06400713          	li	a4,100
 880:	e6e789e3          	beq	a5,a4,6f2 <vprintf+0xa0>
      } else if(c0 == 'l' && c1 == 'd'){
 884:	f9478693          	addi	a3,a5,-108
 888:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 88c:	85b2                	mv	a1,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 88e:	4701                	li	a4,0
      } else if(c0 == 'u'){
 890:	07500513          	li	a0,117
 894:	eaa786e3          	beq	a5,a0,740 <vprintf+0xee>
      } else if(c0 == 'l' && c1 == 'u'){
 898:	f8b60513          	addi	a0,a2,-117
 89c:	e119                	bnez	a0,8a2 <vprintf+0x250>
 89e:	ea069de3          	bnez	a3,758 <vprintf+0x106>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 8a2:	f8b58513          	addi	a0,a1,-117
 8a6:	e119                	bnez	a0,8ac <vprintf+0x25a>
 8a8:	ec0715e3          	bnez	a4,772 <vprintf+0x120>
      } else if(c0 == 'x'){
 8ac:	07800513          	li	a0,120
 8b0:	eca78ee3          	beq	a5,a0,78c <vprintf+0x13a>
      } else if(c0 == 'l' && c1 == 'x'){
 8b4:	f8860613          	addi	a2,a2,-120
 8b8:	e219                	bnez	a2,8be <vprintf+0x26c>
 8ba:	ee0695e3          	bnez	a3,7a4 <vprintf+0x152>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 8be:	f8858593          	addi	a1,a1,-120
 8c2:	e199                	bnez	a1,8c8 <vprintf+0x276>
 8c4:	ee071de3          	bnez	a4,7be <vprintf+0x16c>
      } else if(c0 == 'p'){
 8c8:	07000713          	li	a4,112
 8cc:	f0e786e3          	beq	a5,a4,7d8 <vprintf+0x186>
      } else if(c0 == 's'){
 8d0:	07300713          	li	a4,115
 8d4:	f4e786e3          	beq	a5,a4,820 <vprintf+0x1ce>
      } else if(c0 == '%'){
 8d8:	02500713          	li	a4,37
 8dc:	f6e78be3          	beq	a5,a4,852 <vprintf+0x200>
        putc(fd, '%');
 8e0:	02500593          	li	a1,37
 8e4:	855a                	mv	a0,s6
 8e6:	cabff0ef          	jal	590 <putc>
        putc(fd, c0);
 8ea:	85a6                	mv	a1,s1
 8ec:	855a                	mv	a0,s6
 8ee:	ca3ff0ef          	jal	590 <putc>
      state = 0;
 8f2:	4981                	li	s3,0
 8f4:	b34d                	j	696 <vprintf+0x44>

00000000000008f6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8f6:	715d                	addi	sp,sp,-80
 8f8:	ec06                	sd	ra,24(sp)
 8fa:	e822                	sd	s0,16(sp)
 8fc:	1000                	addi	s0,sp,32
 8fe:	e010                	sd	a2,0(s0)
 900:	e414                	sd	a3,8(s0)
 902:	e818                	sd	a4,16(s0)
 904:	ec1c                	sd	a5,24(s0)
 906:	03043023          	sd	a6,32(s0)
 90a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 90e:	8622                	mv	a2,s0
 910:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 914:	d3fff0ef          	jal	652 <vprintf>
}
 918:	60e2                	ld	ra,24(sp)
 91a:	6442                	ld	s0,16(sp)
 91c:	6161                	addi	sp,sp,80
 91e:	8082                	ret

0000000000000920 <printf>:

void
printf(const char *fmt, ...)
{
 920:	711d                	addi	sp,sp,-96
 922:	ec06                	sd	ra,24(sp)
 924:	e822                	sd	s0,16(sp)
 926:	1000                	addi	s0,sp,32
 928:	e40c                	sd	a1,8(s0)
 92a:	e810                	sd	a2,16(s0)
 92c:	ec14                	sd	a3,24(s0)
 92e:	f018                	sd	a4,32(s0)
 930:	f41c                	sd	a5,40(s0)
 932:	03043823          	sd	a6,48(s0)
 936:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 93a:	00840613          	addi	a2,s0,8
 93e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 942:	85aa                	mv	a1,a0
 944:	4505                	li	a0,1
 946:	d0dff0ef          	jal	652 <vprintf>
}
 94a:	60e2                	ld	ra,24(sp)
 94c:	6442                	ld	s0,16(sp)
 94e:	6125                	addi	sp,sp,96
 950:	8082                	ret

0000000000000952 <free>:
static Header base;
static Header *freep;

void
free (void *ap)
{
 952:	1141                	addi	sp,sp,-16
 954:	e406                	sd	ra,8(sp)
 956:	e022                	sd	s0,0(sp)
 958:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 95a:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 95e:	00001797          	auipc	a5,0x1
 962:	6a27b783          	ld	a5,1698(a5) # 2000 <freep>
 966:	a039                	j	974 <free+0x22>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 968:	6398                	ld	a4,0(a5)
 96a:	00e7e463          	bltu	a5,a4,972 <free+0x20>
 96e:	00e6ea63          	bltu	a3,a4,982 <free+0x30>
{
 972:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 974:	fed7fae3          	bgeu	a5,a3,968 <free+0x16>
 978:	6398                	ld	a4,0(a5)
 97a:	00e6e463          	bltu	a3,a4,982 <free+0x30>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 97e:	fee7eae3          	bltu	a5,a4,972 <free+0x20>
      break;
  if (bp + bp->s.size == p->s.ptr)
 982:	ff852583          	lw	a1,-8(a0)
 986:	6390                	ld	a2,0(a5)
 988:	02059813          	slli	a6,a1,0x20
 98c:	01c85713          	srli	a4,a6,0x1c
 990:	9736                	add	a4,a4,a3
 992:	02e60563          	beq	a2,a4,9bc <free+0x6a>
    {
      bp->s.size += p->s.ptr->s.size;
      bp->s.ptr = p->s.ptr->s.ptr;
 996:	fec53823          	sd	a2,-16(a0)
    }
  else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp)
 99a:	4790                	lw	a2,8(a5)
 99c:	02061593          	slli	a1,a2,0x20
 9a0:	01c5d713          	srli	a4,a1,0x1c
 9a4:	973e                	add	a4,a4,a5
 9a6:	02e68263          	beq	a3,a4,9ca <free+0x78>
    {
      p->s.size += bp->s.size;
      p->s.ptr = bp->s.ptr;
 9aa:	e394                	sd	a3,0(a5)
    }
  else
    p->s.ptr = bp;
  freep = p;
 9ac:	00001717          	auipc	a4,0x1
 9b0:	64f73a23          	sd	a5,1620(a4) # 2000 <freep>
}
 9b4:	60a2                	ld	ra,8(sp)
 9b6:	6402                	ld	s0,0(sp)
 9b8:	0141                	addi	sp,sp,16
 9ba:	8082                	ret
      bp->s.size += p->s.ptr->s.size;
 9bc:	4618                	lw	a4,8(a2)
 9be:	9f2d                	addw	a4,a4,a1
 9c0:	fee52c23          	sw	a4,-8(a0)
      bp->s.ptr = p->s.ptr->s.ptr;
 9c4:	6398                	ld	a4,0(a5)
 9c6:	6310                	ld	a2,0(a4)
 9c8:	b7f9                	j	996 <free+0x44>
      p->s.size += bp->s.size;
 9ca:	ff852703          	lw	a4,-8(a0)
 9ce:	9f31                	addw	a4,a4,a2
 9d0:	c798                	sw	a4,8(a5)
      p->s.ptr = bp->s.ptr;
 9d2:	ff053683          	ld	a3,-16(a0)
 9d6:	bfd1                	j	9aa <free+0x58>

00000000000009d8 <malloc>:
  return freep;
}

void *
malloc (uint nbytes)
{
 9d8:	7139                	addi	sp,sp,-64
 9da:	fc06                	sd	ra,56(sp)
 9dc:	f822                	sd	s0,48(sp)
 9de:	f04a                	sd	s2,32(sp)
 9e0:	ec4e                	sd	s3,24(sp)
 9e2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof (Header) - 1) / sizeof (Header) + 1;
 9e4:	02051993          	slli	s3,a0,0x20
 9e8:	0209d993          	srli	s3,s3,0x20
 9ec:	09bd                	addi	s3,s3,15
 9ee:	0049d993          	srli	s3,s3,0x4
 9f2:	2985                	addiw	s3,s3,1
 9f4:	894e                	mv	s2,s3
  if ((prevp = freep) == 0)
 9f6:	00001517          	auipc	a0,0x1
 9fa:	60a53503          	ld	a0,1546(a0) # 2000 <freep>
 9fe:	c905                	beqz	a0,a2e <malloc+0x56>
    {
      base.s.ptr = freep = prevp = &base;
      base.s.size = 0;
    }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 a00:	611c                	ld	a5,0(a0)
    {
      if (p->s.size >= nunits)
 a02:	4798                	lw	a4,8(a5)
 a04:	09377663          	bgeu	a4,s3,a90 <malloc+0xb8>
 a08:	f426                	sd	s1,40(sp)
 a0a:	e852                	sd	s4,16(sp)
 a0c:	e456                	sd	s5,8(sp)
 a0e:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 a10:	8a4e                	mv	s4,s3
 a12:	6705                	lui	a4,0x1
 a14:	00e9f363          	bgeu	s3,a4,a1a <malloc+0x42>
 a18:	6a05                	lui	s4,0x1
 a1a:	000a0b1b          	sext.w	s6,s4
  p = sbrk (nu * sizeof (Header));
 a1e:	004a1a1b          	slliw	s4,s4,0x4
              p->s.size = nunits;
            }
          freep = prevp;
          return (void *)(p + 1);
        }
      if (p == freep)
 a22:	00001497          	auipc	s1,0x1
 a26:	5de48493          	addi	s1,s1,1502 # 2000 <freep>
  if (p == (char *)-1)
 a2a:	5afd                	li	s5,-1
 a2c:	a83d                	j	a6a <malloc+0x92>
 a2e:	f426                	sd	s1,40(sp)
 a30:	e852                	sd	s4,16(sp)
 a32:	e456                	sd	s5,8(sp)
 a34:	e05a                	sd	s6,0(sp)
      base.s.ptr = freep = prevp = &base;
 a36:	00002797          	auipc	a5,0x2
 a3a:	9da78793          	addi	a5,a5,-1574 # 2410 <base>
 a3e:	00001717          	auipc	a4,0x1
 a42:	5cf73123          	sd	a5,1474(a4) # 2000 <freep>
 a46:	e39c                	sd	a5,0(a5)
      base.s.size = 0;
 a48:	0007a423          	sw	zero,8(a5)
      if (p->s.size >= nunits)
 a4c:	b7d1                	j	a10 <malloc+0x38>
            prevp->s.ptr = p->s.ptr;
 a4e:	6398                	ld	a4,0(a5)
 a50:	e118                	sd	a4,0(a0)
 a52:	a899                	j	aa8 <malloc+0xd0>
  hp->s.size = nu;
 a54:	01652423          	sw	s6,8(a0)
  free ((void *)(hp + 1));
 a58:	0541                	addi	a0,a0,16
 a5a:	ef9ff0ef          	jal	952 <free>
  return freep;
 a5e:	6088                	ld	a0,0(s1)
        if ((p = morecore (nunits)) == 0)
 a60:	c125                	beqz	a0,ac0 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 a62:	611c                	ld	a5,0(a0)
      if (p->s.size >= nunits)
 a64:	4798                	lw	a4,8(a5)
 a66:	03277163          	bgeu	a4,s2,a88 <malloc+0xb0>
      if (p == freep)
 a6a:	6098                	ld	a4,0(s1)
 a6c:	853e                	mv	a0,a5
 a6e:	fef71ae3          	bne	a4,a5,a62 <malloc+0x8a>
  p = sbrk (nu * sizeof (Header));
 a72:	8552                	mv	a0,s4
 a74:	afdff0ef          	jal	570 <sbrk>
  if (p == (char *)-1)
 a78:	fd551ee3          	bne	a0,s5,a54 <malloc+0x7c>
          return 0;
 a7c:	4501                	li	a0,0
 a7e:	74a2                	ld	s1,40(sp)
 a80:	6a42                	ld	s4,16(sp)
 a82:	6aa2                	ld	s5,8(sp)
 a84:	6b02                	ld	s6,0(sp)
 a86:	a03d                	j	ab4 <malloc+0xdc>
 a88:	74a2                	ld	s1,40(sp)
 a8a:	6a42                	ld	s4,16(sp)
 a8c:	6aa2                	ld	s5,8(sp)
 a8e:	6b02                	ld	s6,0(sp)
          if (p->s.size == nunits)
 a90:	fae90fe3          	beq	s2,a4,a4e <malloc+0x76>
              p->s.size -= nunits;
 a94:	4137073b          	subw	a4,a4,s3
 a98:	c798                	sw	a4,8(a5)
              p += p->s.size;
 a9a:	02071693          	slli	a3,a4,0x20
 a9e:	01c6d713          	srli	a4,a3,0x1c
 aa2:	97ba                	add	a5,a5,a4
              p->s.size = nunits;
 aa4:	0137a423          	sw	s3,8(a5)
          freep = prevp;
 aa8:	00001717          	auipc	a4,0x1
 aac:	54a73c23          	sd	a0,1368(a4) # 2000 <freep>
          return (void *)(p + 1);
 ab0:	01078513          	addi	a0,a5,16
    }
}
 ab4:	70e2                	ld	ra,56(sp)
 ab6:	7442                	ld	s0,48(sp)
 ab8:	7902                	ld	s2,32(sp)
 aba:	69e2                	ld	s3,24(sp)
 abc:	6121                	addi	sp,sp,64
 abe:	8082                	ret
 ac0:	74a2                	ld	s1,40(sp)
 ac2:	6a42                	ld	s4,16(sp)
 ac4:	6aa2                	ld	s5,8(sp)
 ac6:	6b02                	ld	s6,0(sp)
 ac8:	b7f5                	j	ab4 <malloc+0xdc>
