/* Generated by Nim Compiler v0.13.0 */
/*   (c) 2015 Andreas Rumpf */
/* The generated code is subject to the original license. */
/* Compiled for: Linux, amd64, gcc */
/* Command for C compiler:
   gcc -c  -w  -I/home/tamura/.choosenim/toolchains/nim-0.13.0/lib -o /home/tamura/project/atcoder/src/nimcache/stdlib_tables.o /home/tamura/project/atcoder/src/nimcache/stdlib_tables.c */
#define NIM_INTBITS 64

#include "nimbase.h"
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
struct  TGenericSeq  {
NI len;
NI reserved;
};
struct  NimStringDesc  {
  TGenericSeq Sup;
NIM_CHAR data[SEQ_DECL_SIZE];
};
static N_INLINE(NIM_BOOL, isempty_118259)(NI hcode);
static N_INLINE(void, nimFrame)(TFrame* s);
N_NOINLINE(void, stackoverflow_22201)(void);
static N_INLINE(void, popFrame)(void);
static N_INLINE(NIM_BOOL, isfilled_118263)(NI hcode);
static N_INLINE(NIM_BOOL, mustrehash_118268)(NI length, NI counter);
N_NIMCALL(void, failedassertimpl_89116)(NimStringDesc* msg);
N_NIMCALL(NI, mulInt)(NI a, NI b);
static N_INLINE(NI, subInt)(NI a, NI b);
N_NOINLINE(void, raiseOverflow)(void);
static N_INLINE(NI, nexttry_118401)(NI h, NI maxhash);
static N_INLINE(NI, addInt)(NI a, NI b);
static N_INLINE(NI, rightsize_118532)(NI count);
N_NIMCALL(NI, nextpoweroftwo_110227)(NI x);
static N_INLINE(NI, divInt)(NI a, NI b);
N_NOINLINE(void, raiseDivByZero)(void);
STRING_LITERAL(TMP315, "\012  counter < length ", 20);
extern TFrame* frameptr_19436;

static N_INLINE(void, nimFrame)(TFrame* s) {
	NI LOC1;
	LOC1 = 0;
	{
		if (!(frameptr_19436 == NIM_NIL)) goto LA4;
		LOC1 = ((NI) 0);
	}
	goto LA2;
	LA4: ;
	{
		LOC1 = ((NI) ((NI16)((*frameptr_19436).calldepth + ((NI16) 1))));
	}
	LA2: ;
	(*s).calldepth = ((NI16) (LOC1));
	(*s).prev = frameptr_19436;
	frameptr_19436 = s;
	{
		if (!((*s).calldepth == ((NI16) 2000))) goto LA9;
		stackoverflow_22201();
	}
	LA9: ;
}

static N_INLINE(void, popFrame)(void) {
	frameptr_19436 = (*frameptr_19436).prev;
}

static N_INLINE(NIM_BOOL, isempty_118259)(NI hcode) {
	NIM_BOOL result;
	nimfr("isEmpty", "tableimpl.nim")
	result = 0;
	nimln(15, "tableimpl.nim");
	result = (hcode == ((NI) 0));
	popFrame();
	return result;
}

static N_INLINE(NIM_BOOL, isfilled_118263)(NI hcode) {
	NIM_BOOL result;
	nimfr("isFilled", "tableimpl.nim")
	result = 0;
	nimln(18, "tableimpl.nim");
	nimln(349, "system.nim");
	result = !((hcode == ((NI) 0)));
	popFrame();
	return result;
}

static N_INLINE(NI, subInt)(NI a, NI b) {
	NI result;
{	result = 0;
	result = (NI)((NU64)(a) - (NU64)(b));
	{
		NIM_BOOL LOC3;
		LOC3 = 0;
		LOC3 = (((NI) 0) <= (NI)(result ^ a));
		if (LOC3) goto LA4;
		LOC3 = (((NI) 0) <= (NI)(result ^ (NI)((NU64) ~(b))));
		LA4: ;
		if (!LOC3) goto LA5;
		goto BeforeRet;
	}
	LA5: ;
	raiseOverflow();
	}BeforeRet: ;
	return result;
}

static N_INLINE(NIM_BOOL, mustrehash_118268)(NI length, NI counter) {
	NIM_BOOL result;
	NIM_BOOL LOC5;
	NI TMP316;
	NI TMP317;
	NI TMP318;
	nimfr("mustRehash", "tableimpl.nim")
	result = 0;
	nimln(24, "tableimpl.nim");
	{
		if (!!((counter < length))) goto LA3;
		failedassertimpl_89116(((NimStringDesc*) &TMP315));
	}
	LA3: ;
	nimln(25, "tableimpl.nim");
	LOC5 = 0;
	TMP316 = mulInt(length, ((NI) 2));
	TMP317 = mulInt(counter, ((NI) 3));
	LOC5 = ((NI)(TMP316) < (NI)(TMP317));
	if (LOC5) goto LA6;
	TMP318 = subInt(length, counter);
	LOC5 = ((NI)(TMP318) < ((NI) 4));
	LA6: ;
	result = LOC5;
	popFrame();
	return result;
}

static N_INLINE(NI, addInt)(NI a, NI b) {
	NI result;
{	result = 0;
	result = (NI)((NU64)(a) + (NU64)(b));
	{
		NIM_BOOL LOC3;
		LOC3 = 0;
		LOC3 = (((NI) 0) <= (NI)(result ^ a));
		if (LOC3) goto LA4;
		LOC3 = (((NI) 0) <= (NI)(result ^ b));
		LA4: ;
		if (!LOC3) goto LA5;
		goto BeforeRet;
	}
	LA5: ;
	raiseOverflow();
	}BeforeRet: ;
	return result;
}

static N_INLINE(NI, nexttry_118401)(NI h, NI maxhash) {
	NI result;
	NI TMP319;
	nimfr("nextTry", "tableimpl.nim")
	result = 0;
	nimln(28, "tableimpl.nim");
	TMP319 = addInt(h, ((NI) 1));
	result = (NI)((NI)(TMP319) & maxhash);
	popFrame();
	return result;
}

static N_INLINE(NI, divInt)(NI a, NI b) {
	NI result;
{	result = 0;
	{
		if (!(b == ((NI) 0))) goto LA3;
		raiseDivByZero();
	}
	LA3: ;
	{
		NIM_BOOL LOC7;
		LOC7 = 0;
		LOC7 = (a == ((NI) (IL64(-9223372036854775807) - IL64(1))));
		if (!(LOC7)) goto LA8;
		LOC7 = (b == ((NI) -1));
		LA8: ;
		if (!LOC7) goto LA9;
		raiseOverflow();
	}
	LA9: ;
	result = (NI)(a / b);
	goto BeforeRet;
	}BeforeRet: ;
	return result;
}

static N_INLINE(NI, rightsize_118532)(NI count) {
	NI result;
	NI TMP320;
	NI TMP321;
	NI TMP322;
	nimfr("rightSize", "tables.nim")
	result = 0;
	nimln(95, "tables.nim");
	TMP320 = mulInt(((NI) (count)), ((NI) 3));
	TMP321 = divInt(((NI) ((NI)(TMP320))), ((NI) 2));
	TMP322 = addInt(((NI) ((NI)(TMP321))), ((NI) 4));
	result = nextpoweroftwo_110227(((NI) ((NI)(TMP322))));
	popFrame();
	return result;
}
NIM_EXTERNC N_NOINLINE(void, stdlib_tablesInit000)(void) {
	nimfr("tables", "tables.nim")
	popFrame();
}

NIM_EXTERNC N_NOINLINE(void, stdlib_tablesDatInit000)(void) {
}

