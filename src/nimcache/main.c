/* Generated by Nim Compiler v0.13.0 */
/*   (c) 2015 Andreas Rumpf */
/* The generated code is subject to the original license. */
/* Compiled for: Linux, amd64, gcc */
/* Command for C compiler:
   gcc -c  -w  -I/home/tamura/.choosenim/toolchains/nim-0.13.0/lib -o /home/tamura/project/atcoder/src/nimcache/main.o /home/tamura/project/atcoder/src/nimcache/main.c */
#define NIM_INTBITS 64

#include "nimbase.h"
#include <stdio.h>
#include <string.h>
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef struct TY122006 TY122006;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct Cell47905 Cell47905;
typedef struct Cellseq47921 Cellseq47921;
typedef struct Gcheap50218 Gcheap50218;
typedef struct Gcstack50216 Gcstack50216;
typedef struct Cellset47917 Cellset47917;
typedef struct Pagedesc47913 Pagedesc47913;
typedef struct Memregion30088 Memregion30088;
typedef struct Smallchunk30040 Smallchunk30040;
typedef struct Llchunk30082 Llchunk30082;
typedef struct Bigchunk30042 Bigchunk30042;
typedef struct Intset30014 Intset30014;
typedef struct Trunk30010 Trunk30010;
typedef struct Avlnode30086 Avlnode30086;
typedef struct Gcstat50214 Gcstat50214;
typedef struct TY122431 TY122431;
typedef struct Factable122414 Factable122414;
typedef struct Basechunk30038 Basechunk30038;
typedef struct Freecell30030 Freecell30030;
struct  TGenericSeq  {
NI len;
NI reserved;
};
struct  NimStringDesc  {
  TGenericSeq Sup;
NIM_CHAR data[SEQ_DECL_SIZE];
};
typedef struct {
N_NIMCALL_PTR(NimStringDesc*, ClPrc) (void* ClEnv);
void* ClEnv;
} TY122002;
struct  TY122006  {
NI HEX3Astate;
NimStringDesc* s122004;
NimStringDesc* HEX3Atmp122012;
NI last97798;
NI first98020;
};
typedef N_NIMCALL_PTR(void, TY3489) (void* p, NI op);
typedef N_NIMCALL_PTR(void*, TY3494) (void* p);
struct  TNimType  {
NI size;
NU8 kind;
NU8 flags;
TNimType* base;
TNimNode* node;
void* finalizer;
TY3489 marker;
TY3494 deepcopy;
};
struct  TNimNode  {
NU8 kind;
NI offset;
TNimType* typ;
NCSTRING name;
NI len;
TNimNode** sons;
};
struct  Cell47905  {
NI refcount;
TNimType* typ;
};
struct  Cellseq47921  {
NI len;
NI cap;
Cell47905** d;
};
struct  Cellset47917  {
NI counter;
NI max;
Pagedesc47913* head;
Pagedesc47913** data;
};
typedef Smallchunk30040* TY30103[512];
typedef Trunk30010* Trunkbuckets30012[256];
struct  Intset30014  {
Trunkbuckets30012 data;
};
struct  Memregion30088  {
NI minlargeobj;
NI maxlargeobj;
TY30103 freesmallchunks;
Llchunk30082* llmem;
NI currmem;
NI maxmem;
NI freemem;
NI lastsize;
Bigchunk30042* freechunkslist;
Intset30014 chunkstarts;
Avlnode30086* root;
Avlnode30086* deleted;
Avlnode30086* last;
Avlnode30086* freeavlnodes;
};
struct  Gcstat50214  {
NI stackscans;
NI cyclecollections;
NI maxthreshold;
NI maxstacksize;
NI maxstackcells;
NI cycletablesize;
NI64 maxpause;
};
struct  Gcheap50218  {
Gcstack50216* stack;
void* stackbottom;
NI cyclethreshold;
Cellseq47921 zct;
Cellseq47921 decstack;
Cellset47917 cycleroots;
Cellseq47921 tempstack;
NI recgclock;
Memregion30088 region;
Gcstat50214 stat;
};
typedef N_NIMCALL_PTR(NI, TY122021) (void);
typedef N_CLOSURE_PTR(NimStringDesc*, TMP329) (void);
struct  Factable122414  {
TY122431* fa;
TY122431* fi;
};
struct  Gcstack50216  {
Gcstack50216* prev;
Gcstack50216* next;
void* starts;
void* pos;
NI maxstacksize;
};
typedef NI TY30019[8];
struct  Pagedesc47913  {
Pagedesc47913* next;
NI key;
TY30019 bits;
};
struct  Basechunk30038  {
NI prevsize;
NI size;
NIM_BOOL used;
};
struct  Smallchunk30040  {
  Basechunk30038 Sup;
Smallchunk30040* next;
Smallchunk30040* prev;
Freecell30030* freelist;
NI free;
NI acc;
NF data;
};
struct  Llchunk30082  {
NI size;
NI acc;
Llchunk30082* next;
};
struct  Bigchunk30042  {
  Basechunk30038 Sup;
Bigchunk30042* next;
Bigchunk30042* prev;
NI align;
NF data;
};
struct  Trunk30010  {
Trunk30010* next;
NI key;
TY30019 bits;
};
typedef Avlnode30086* TY30093[2];
struct  Avlnode30086  {
TY30093 link;
NI key;
NI upperbound;
NI level;
};
struct  Freecell30030  {
Freecell30030* next;
NI zerofield;
};
struct TY122431 {
  TGenericSeq Sup;
  NI data[SEQ_DECL_SIZE];
};
N_NIMCALL(void, nimGCvisit)(void* d, NI op);
N_NIMCALL(void, TMP324)(void* p, NI op);
N_NIMCALL(void*, newObj)(TNimType* typ, NI size);
N_CLOSURE(NimStringDesc*, HEX3Aanonymous_122001)(void* ClEnv);
N_NIMCALL(NimStringDesc*, readall_15463)(FILE* file);
static N_INLINE(void, asgnRefNoCycle)(void** dest, void* src);
static N_INLINE(Cell47905*, usrtocell_51840)(void* usr);
static N_INLINE(void, nimFrame)(TFrame* s);
N_NOINLINE(void, stackoverflow_22201)(void);
static N_INLINE(void, popFrame)(void);
static N_INLINE(void, rtladdzct_53401)(Cell47905* c);
N_NOINLINE(void, addzct_51817)(Cellseq47921* s, Cell47905* c);
N_NOINLINE(void, raiseIndexError)(void);
static N_INLINE(NI, addInt)(NI a, NI b);
N_NOINLINE(void, raiseOverflow)(void);
static N_INLINE(NI, subInt)(NI a, NI b);
N_NIMCALL(NimStringDesc*, copyStrLast)(NimStringDesc* s, NI start_80210, NI last);
N_NIMCALL(NimStringDesc*, copyStrLast)(NimStringDesc* s, NI first, NI last);
N_NIMCALL(NimStringDesc*, copyString)(NimStringDesc* src);
static N_INLINE(void, asgnRef)(void** dest, void* src);
static N_INLINE(void, incref_54219)(Cell47905* c);
static N_INLINE(NIM_BOOL, canbecycleroot_51858)(Cell47905* c);
static N_INLINE(void, rtladdcycleroot_52620)(Cell47905* c);
N_NOINLINE(void, incl_48647)(Cellset47917* s, Cell47905* cell);
static N_INLINE(void, decref_53801)(Cell47905* c);
N_NIMCALL(NI, HEX3Aanonymous_122020)(void);
N_NIMCALL(NI, nsuParseInt)(NimStringDesc* s);
N_NIMCALL(NI, HEX5E_122262)(NI x_122266, NI y_122268);
static N_INLINE(NI, modInt)(NI a, NI b);
N_NOINLINE(void, raiseDivByZero)(void);
N_NIMCALL(NI, HEX2A_122233)(NI a, NI b);
N_NIMCALL(NI, tofin_122206)(NI a);
N_NIMCALL(NI, mulInt)(NI a, NI b);
N_NIMCALL(TY122431*, repeat_122424)(NI x, NI n);
N_NIMCALL(TY122431*, newseq_122434)(NI len);
N_NIMCALL(NI, toint_122214)(NI a);
N_NIMCALL(NI, HEX2B_122219)(NI a, NI b);
N_NIMCALL(NI, HEX2D_122226)(NI a, NI b);
N_NIMCALL(void, HEX2BHEX3D_122240)(NI* a, NI b);
N_NIMCALL(void, HEX2DHEX3D_122245)(NI* a, NI b);
N_NIMCALL(void, HEX2AHEX3D_122250)(NI* a, NI b);
N_NIMCALL(NI, HEX2F_122255)(NI a, NI b);
N_NIMCALL(void, HEX2FHEX3D_122408)(NI* a, NI b);
N_NIMCALL(void, initfactable_122418)(NI n, Factable122414* Result);
static N_INLINE(NI, chckRange)(NI i, NI a, NI b);
N_NOINLINE(void, raiseRangeError)(NI64 val);
N_NIMCALL(void, genericSeqAssign)(void* dest, void* src_84404, TNimType* mt);
N_NIMCALL(void, unsureAsgnRef)(void** dest, void* src);
N_NIMCALL(NI, nck_122631)(Factable122414 ft, NI n, NI r);
N_NOINLINE(void, chckNil)(void* p);
N_NIMCALL(void, genericReset)(void* dest, TNimType* mt);
N_NIMCALL(NimStringDesc*, nimIntToStr)(NI x);
static N_INLINE(void, initStackBottomWith)(void* locals);
N_NOINLINE(void, setStackBottom)(void* thestackbottom);
NIM_EXTERNC N_NOINLINE(void, systemInit000)(void);
NIM_EXTERNC N_NOINLINE(void, systemDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_sequtilsInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_sequtilsDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_parseutilsInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_parseutilsDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_strutilsInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_strutilsDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_timesInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_timesDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_mathInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_mathDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_algorithmInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_algorithmDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_etcprivInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_etcprivDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_hashesInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_hashesDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_tablesInit000)(void);
NIM_EXTERNC N_NOINLINE(void, stdlib_tablesDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, mainInit000)(void);
NIM_EXTERNC N_NOINLINE(void, mainDatInit000)(void);
TY122002 get_122019;
TNimType NTI122006; /* object */
extern TNimType NTI104; /* int */
TNimType NTI122008; /* range -1..1(int) */
extern TNimType NTI138; /* string */
TNimType NTI122005; /* ref object */
extern TFrame* frameptr_19436;
extern Gcheap50218 gch_50259;
TY122021 read_122023;
extern TNimType NTI122431; /* seq[fin] */
NI n_122801;
NI m_122802;
NI k_122803;
Factable122414 ft_122805;
TNimType NTI122414; /* FacTable */
N_NIMCALL(void, TMP324)(void* p, NI op) {
	TY122006* a;
	a = (TY122006*)p;
	nimGCvisit((void*)(*a).s122004, op);
	nimGCvisit((void*)(*a).HEX3Atmp122012, op);
}

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

static N_INLINE(Cell47905*, usrtocell_51840)(void* usr) {
	Cell47905* result;
	nimfr("usrToCell", "gc.nim")
	result = 0;
	nimln(131, "gc.nim");
	result = ((Cell47905*) ((NI)((NU64)(((NI) (usr))) - (NU64)(((NI)sizeof(Cell47905))))));
	popFrame();
	return result;
}

static N_INLINE(void, rtladdzct_53401)(Cell47905* c) {
	nimfr("rtlAddZCT", "gc.nim")
	nimln(212, "gc.nim");
	addzct_51817((&gch_50259.zct), c);
	popFrame();
}

static N_INLINE(void, asgnRefNoCycle)(void** dest, void* src) {
	nimfr("asgnRefNoCycle", "gc.nim")
	nimln(264, "gc.nim");
	{
		Cell47905* c;
		nimln(349, "system.nim");
		if (!!((src == NIM_NIL))) goto LA3;
		nimln(265, "gc.nim");
		c = usrtocell_51840(src);
		nimln(182, "gc.nim");
		(*c).refcount += ((NI) 8);
	}
	LA3: ;
	nimln(267, "gc.nim");
	{
		Cell47905* c;
		nimln(349, "system.nim");
		if (!!(((*dest) == NIM_NIL))) goto LA7;
		nimln(268, "gc.nim");
		c = usrtocell_51840((*dest));
		nimln(269, "gc.nim");
		{
			nimln(180, "gc.nim");
			(*c).refcount -= ((NI) 8);
			nimln(181, "gc.nim");
			if (!((NU64)((*c).refcount) < (NU64)(((NI) 8)))) goto LA11;
			nimln(270, "gc.nim");
			rtladdzct_53401(c);
		}
		LA11: ;
	}
	LA7: ;
	nimln(271, "gc.nim");
	(*dest) = src;
	popFrame();
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

N_CLOSURE(NimStringDesc*, HEX3Aanonymous_122001)(void* ClEnv) {
	NimStringDesc* result;
	TY122006* HEX3Aenvp_122009;
	nimfr(":anonymous", "main.nim")
{	result = 0;
	HEX3Aenvp_122009 = (TY122006*) ClEnv;
	switch ((*HEX3Aenvp_122009).HEX3Astate) {
	case -1: goto BeforeRet;
	case 0: goto STATE0;
	case 1: goto STATE1;
	}
	STATE0: ;
	{
		nimln(3, "main.nim");
		asgnRefNoCycle((void**) (&(*HEX3Aenvp_122009).HEX3Atmp122012), readall_15463(stdin));
		nimln(371, "strutils.nim");
		(*HEX3Aenvp_122009).last97798 = ((NI) 0);
		{
			nimln(373, "strutils.nim");
			while (1) {
				if (!((*HEX3Aenvp_122009).last97798 < ((*HEX3Aenvp_122009).HEX3Atmp122012 ? (*HEX3Aenvp_122009).HEX3Atmp122012->Sup.len : 0))) goto LA3;
				{
					nimln(374, "strutils.nim");
					while (1) {
						NI TMP325;
						nimln(1098, "system.nim");
						if ((NU)((*HEX3Aenvp_122009).last97798) > (NU)((*HEX3Aenvp_122009).HEX3Atmp122012->Sup.len)) raiseIndexError();
						if (!(((NU8)((*HEX3Aenvp_122009).HEX3Atmp122012->data[(*HEX3Aenvp_122009).last97798])) == ((NU8)(32)) || ((NU8)((*HEX3Aenvp_122009).HEX3Atmp122012->data[(*HEX3Aenvp_122009).last97798])) == ((NU8)(9)) || ((NU8)((*HEX3Aenvp_122009).HEX3Atmp122012->data[(*HEX3Aenvp_122009).last97798])) == ((NU8)(11)) || ((NU8)((*HEX3Aenvp_122009).HEX3Atmp122012->data[(*HEX3Aenvp_122009).last97798])) == ((NU8)(13)) || ((NU8)((*HEX3Aenvp_122009).HEX3Atmp122012->data[(*HEX3Aenvp_122009).last97798])) == ((NU8)(10)) || ((NU8)((*HEX3Aenvp_122009).HEX3Atmp122012->data[(*HEX3Aenvp_122009).last97798])) == ((NU8)(12)))) goto LA5;
						nimln(374, "strutils.nim");
						TMP325 = addInt((*HEX3Aenvp_122009).last97798, ((NI) 1));
						(*HEX3Aenvp_122009).last97798 = (NI)(TMP325);
					} LA5: ;
				}
				nimln(375, "strutils.nim");
				(*HEX3Aenvp_122009).first98020 = (*HEX3Aenvp_122009).last97798;
				{
					nimln(376, "strutils.nim");
					while (1) {
						NIM_BOOL LOC8;
						NI TMP326;
						LOC8 = 0;
						LOC8 = ((*HEX3Aenvp_122009).last97798 < ((*HEX3Aenvp_122009).HEX3Atmp122012 ? (*HEX3Aenvp_122009).HEX3Atmp122012->Sup.len : 0));
						if (!(LOC8)) goto LA9;
						nimln(1104, "system.nim");
						if ((NU)((*HEX3Aenvp_122009).last97798) > (NU)((*HEX3Aenvp_122009).HEX3Atmp122012->Sup.len)) raiseIndexError();
						LOC8 = !((((NU8)((*HEX3Aenvp_122009).HEX3Atmp122012->data[(*HEX3Aenvp_122009).last97798])) == ((NU8)(32)) || ((NU8)((*HEX3Aenvp_122009).HEX3Atmp122012->data[(*HEX3Aenvp_122009).last97798])) == ((NU8)(9)) || ((NU8)((*HEX3Aenvp_122009).HEX3Atmp122012->data[(*HEX3Aenvp_122009).last97798])) == ((NU8)(11)) || ((NU8)((*HEX3Aenvp_122009).HEX3Atmp122012->data[(*HEX3Aenvp_122009).last97798])) == ((NU8)(13)) || ((NU8)((*HEX3Aenvp_122009).HEX3Atmp122012->data[(*HEX3Aenvp_122009).last97798])) == ((NU8)(10)) || ((NU8)((*HEX3Aenvp_122009).HEX3Atmp122012->data[(*HEX3Aenvp_122009).last97798])) == ((NU8)(12))));
						LA9: ;
						if (!LOC8) goto LA7;
						nimln(376, "strutils.nim");
						TMP326 = addInt((*HEX3Aenvp_122009).last97798, ((NI) 1));
						(*HEX3Aenvp_122009).last97798 = (NI)(TMP326);
					} LA7: ;
				}
				nimln(377, "strutils.nim");
				{
					NI TMP327;
					NI TMP328;
					TMP327 = subInt((*HEX3Aenvp_122009).last97798, ((NI) 1));
					if (!((*HEX3Aenvp_122009).first98020 <= (NI)(TMP327))) goto LA12;
					nimln(378, "strutils.nim");
					TMP328 = subInt((*HEX3Aenvp_122009).last97798, ((NI) 1));
					asgnRefNoCycle((void**) (&(*HEX3Aenvp_122009).s122004), copyStrLast((*HEX3Aenvp_122009).HEX3Atmp122012, (*HEX3Aenvp_122009).first98020, (NI)(TMP328)));
					nimln(3, "main.nim");
					(*HEX3Aenvp_122009).HEX3Astate = ((NI) 1);
					result = copyString((*HEX3Aenvp_122009).s122004);
					goto BeforeRet;
					STATE1: ;
				}
				LA12: ;
			} LA3: ;
		}
	}
	(*HEX3Aenvp_122009).HEX3Astate = ((NI) -1);
	}BeforeRet: ;
	popFrame();
	return result;
}

static N_INLINE(NIM_BOOL, canbecycleroot_51858)(Cell47905* c) {
	NIM_BOOL result;
	nimfr("canBeCycleRoot", "gc.nim")
	result = 0;
	nimln(134, "gc.nim");
	nimln(1104, "system.nim");
	result = !((((*(*c).typ).flags &(1U<<((NU)(((NU8) 1))&7U)))!=0));
	popFrame();
	return result;
}

static N_INLINE(void, rtladdcycleroot_52620)(Cell47905* c) {
	nimfr("rtlAddCycleRoot", "gc.nim")
	nimln(202, "gc.nim");
	{
		nimln(349, "system.nim");
		nimln(147, "gc.nim");
		if (!!((((NI) ((NI)((*c).refcount & ((NI) 3)))) == ((NI) 3)))) goto LA3;
		nimln(152, "gc.nim");
		(*c).refcount = (NI)((NI)((*c).refcount & ((NI) -4)) | ((NI) 3));
		nimln(204, "gc.nim");
		incl_48647((&gch_50259.cycleroots), c);
	}
	LA3: ;
	popFrame();
}

static N_INLINE(void, incref_54219)(Cell47905* c) {
	nimfr("incRef", "gc.nim")
	nimln(229, "gc.nim");
	(*c).refcount = (NI)((NU64)((*c).refcount) + (NU64)(((NI) 8)));
	nimln(232, "gc.nim");
	{
		NIM_BOOL LOC3;
		LOC3 = 0;
		LOC3 = canbecycleroot_51858(c);
		if (!LOC3) goto LA4;
		nimln(233, "gc.nim");
		rtladdcycleroot_52620(c);
	}
	LA4: ;
	popFrame();
}

static N_INLINE(void, decref_53801)(Cell47905* c) {
	nimfr("decRef", "gc.nim")
	nimln(219, "gc.nim");
	{
		nimln(180, "gc.nim");
		(*c).refcount -= ((NI) 8);
		nimln(181, "gc.nim");
		if (!((NU64)((*c).refcount) < (NU64)(((NI) 8)))) goto LA3;
		nimln(220, "gc.nim");
		rtladdzct_53401(c);
	}
	goto LA1;
	LA3: ;
	{
		NIM_BOOL LOC6;
		nimln(221, "gc.nim");
		LOC6 = 0;
		LOC6 = canbecycleroot_51858(c);
		if (!LOC6) goto LA7;
		nimln(224, "gc.nim");
		rtladdcycleroot_52620(c);
	}
	goto LA1;
	LA7: ;
	LA1: ;
	popFrame();
}

static N_INLINE(void, asgnRef)(void** dest, void* src) {
	nimfr("asgnRef", "gc.nim")
	nimln(257, "gc.nim");
	{
		Cell47905* LOC5;
		nimln(349, "system.nim");
		if (!!((src == NIM_NIL))) goto LA3;
		nimln(257, "gc.nim");
		LOC5 = 0;
		LOC5 = usrtocell_51840(src);
		incref_54219(LOC5);
	}
	LA3: ;
	nimln(258, "gc.nim");
	{
		Cell47905* LOC10;
		nimln(349, "system.nim");
		if (!!(((*dest) == NIM_NIL))) goto LA8;
		nimln(258, "gc.nim");
		LOC10 = 0;
		LOC10 = usrtocell_51840((*dest));
		decref_53801(LOC10);
	}
	LA8: ;
	nimln(259, "gc.nim");
	(*dest) = src;
	popFrame();
}

N_NIMCALL(NI, HEX3Aanonymous_122020)(void) {
	NI result;
	NimStringDesc* LOC1;
	nimfr(":anonymous", "main.nim")
	result = 0;
	nimln(4, "main.nim");
	LOC1 = 0;
	LOC1 = get_122019.ClPrc(get_122019.ClEnv);
	result = nsuParseInt(LOC1);
	popFrame();
	return result;
}

N_NIMCALL(NI, toint_122214)(NI a) {
	NI result;
	nimfr("toInt", "main.nim")
	result = 0;
	nimln(13, "main.nim");
	result = a;
	popFrame();
	return result;
}

static N_INLINE(NI, modInt)(NI a, NI b) {
	NI result;
{	result = 0;
	{
		if (!(b == ((NI) 0))) goto LA3;
		raiseDivByZero();
	}
	LA3: ;
	result = (NI)(a % b);
	goto BeforeRet;
	}BeforeRet: ;
	return result;
}

N_NIMCALL(NI, tofin_122206)(NI a) {
	NI result;
	NI TMP331;
	NI TMP332;
	NI TMP333;
	nimfr("toFin", "main.nim")
	result = 0;
	nimln(12, "main.nim");
	TMP331 = modInt(a, ((NI) 1000000007));
	TMP332 = addInt(((NI) ((NI)(TMP331))), ((NI) 1000000007));
	TMP333 = modInt(((NI) ((NI)(TMP332))), ((NI) 1000000007));
	result = ((NI) ((NI)(TMP333)));
	popFrame();
	return result;
}

N_NIMCALL(NI, HEX2A_122233)(NI a, NI b) {
	NI result;
	NI TMP334;
	nimfr("*", "main.nim")
	result = 0;
	nimln(16, "main.nim");
	TMP334 = mulInt(a, b);
	result = tofin_122206((NI)(TMP334));
	popFrame();
	return result;
}

N_NIMCALL(void, HEX2AHEX3D_122250)(NI* a, NI b) {
	nimfr("*=", "main.nim")
	nimln(19, "main.nim");
	(*a) = HEX2A_122233((*a), b);
	popFrame();
}

N_NIMCALL(NI, HEX2B_122219)(NI a, NI b) {
	NI result;
	NI TMP337;
	nimfr("+", "main.nim")
	result = 0;
	nimln(14, "main.nim");
	TMP337 = addInt(a, b);
	result = tofin_122206((NI)(TMP337));
	popFrame();
	return result;
}

N_NIMCALL(NI, HEX2D_122226)(NI a, NI b) {
	NI result;
	NI TMP338;
	nimfr("-", "main.nim")
	result = 0;
	nimln(15, "main.nim");
	TMP338 = subInt(a, b);
	result = tofin_122206((NI)(TMP338));
	popFrame();
	return result;
}

N_NIMCALL(void, HEX2BHEX3D_122240)(NI* a, NI b) {
	nimfr("+=", "main.nim")
	nimln(17, "main.nim");
	(*a) = HEX2B_122219((*a), b);
	popFrame();
}

N_NIMCALL(void, HEX2DHEX3D_122245)(NI* a, NI b) {
	nimfr("-=", "main.nim")
	nimln(18, "main.nim");
	(*a) = HEX2D_122226((*a), b);
	popFrame();
}

N_NIMCALL(NI, HEX2F_122255)(NI a, NI b) {
	NI result;
	NI LOC1;
	NI LOC2;
	nimfr("/", "main.nim")
	result = 0;
	nimln(20, "main.nim");
	LOC1 = 0;
	LOC1 = tofin_122206(((NI) 1000000005));
	LOC2 = 0;
	LOC2 = HEX5E_122262(b, LOC1);
	result = HEX2A_122233(a, LOC2);
	popFrame();
	return result;
}

N_NIMCALL(void, HEX2FHEX3D_122408)(NI* a, NI b) {
	nimfr("/=", "main.nim")
	nimln(21, "main.nim");
	(*a) = HEX2F_122255((*a), b);
	popFrame();
}

static N_INLINE(NI, chckRange)(NI i, NI a, NI b) {
	NI result;
{	result = 0;
	{
		NIM_BOOL LOC3;
		LOC3 = 0;
		LOC3 = (a <= i);
		if (!(LOC3)) goto LA4;
		LOC3 = (i <= b);
		LA4: ;
		if (!LOC3) goto LA5;
		result = i;
		goto BeforeRet;
	}
	goto LA1;
	LA5: ;
	{
		raiseRangeError(((NI64) (i)));
	}
	LA1: ;
	}BeforeRet: ;
	return result;
}

N_NIMCALL(void, initfactable_122418)(NI n, Factable122414* Result) {
	TY122431* fa;
	NI TMP339;
	TY122431* fi;
	NI TMP340;
	NI LOC5;
	Factable122414 LOC10;
	nimfr("initFacTable", "main.nim")
	nimln(25, "main.nim");
	TMP339 = addInt(((NI) (n)), ((NI) 1));
	fa = repeat_122424(((NI) 1), ((NI) ((NI)(TMP339))));
	TMP340 = addInt(((NI) (n)), ((NI) 1));
	fi = repeat_122424(((NI) 1), ((NI) ((NI)(TMP340))));
	{
		NI i_122503;
		NI res_122621;
		i_122503 = 0;
		nimln(1874, "system.nim");
		res_122621 = ((NI) 2);
		{
			nimln(1875, "system.nim");
			while (1) {
				NI TMP341;
				NI LOC4;
				NI TMP342;
				NI TMP343;
				if (!(res_122621 <= ((NI) (n)))) goto LA3;
				nimln(1876, "system.nim");
				i_122503 = ((NI)chckRange(res_122621, ((NI) 0), ((NI) IL64(9223372036854775807))));
				nimln(26, "main.nim");
				if ((NU)(i_122503) >= (NU)(fa->Sup.len)) raiseIndexError();
				TMP341 = subInt(((NI) (i_122503)), ((NI) 1));
				if ((NU)((NI)(TMP341)) >= (NU)(fa->Sup.len)) raiseIndexError();
				LOC4 = 0;
				LOC4 = toint_122214(fa->data[(NI)(TMP341)]);
				TMP342 = mulInt(LOC4, ((NI) (i_122503)));
				fa->data[i_122503] = tofin_122206((NI)(TMP342));
				nimln(1895, "system.nim");
				TMP343 = addInt(res_122621, ((NI) 1));
				res_122621 = (NI)(TMP343);
			} LA3: ;
		}
	}
	nimln(27, "main.nim");
	if ((NU)(n) >= (NU)(fi->Sup.len)) raiseIndexError();
	LOC5 = 0;
	LOC5 = tofin_122206(((NI) 1));
	if ((NU)(n) >= (NU)(fa->Sup.len)) raiseIndexError();
	fi->data[n] = HEX2F_122255(LOC5, fa->data[n]);
	{
		NI i_122614;
		NI res_122627;
		i_122614 = 0;
		nimln(1862, "system.nim");
		res_122627 = ((NI) (n));
		{
			nimln(1863, "system.nim");
			while (1) {
				NI TMP344;
				NI LOC9;
				NI TMP345;
				NI TMP346;
				nimln(353, "system.nim");
				if (!(((NI) 3) <= res_122627)) goto LA8;
				nimln(1864, "system.nim");
				i_122614 = ((NI)chckRange(res_122627, ((NI) 0), ((NI) IL64(9223372036854775807))));
				nimln(28, "main.nim");
				TMP344 = subInt(((NI) (i_122614)), ((NI) 1));
				if ((NU)((NI)(TMP344)) >= (NU)(fi->Sup.len)) raiseIndexError();
				if ((NU)(i_122614) >= (NU)(fi->Sup.len)) raiseIndexError();
				LOC9 = 0;
				LOC9 = toint_122214(fi->data[i_122614]);
				TMP345 = mulInt(LOC9, ((NI) (i_122614)));
				fi->data[(NI)(TMP344)] = tofin_122206((NI)(TMP345));
				nimln(1865, "system.nim");
				TMP346 = subInt(res_122627, ((NI) 1));
				res_122627 = (NI)(TMP346);
			} LA8: ;
		}
	}
	memset((void*)(&LOC10), 0, sizeof(LOC10));
	memset((void*)(&LOC10), 0, sizeof(LOC10));
	genericSeqAssign((&LOC10.fa), fa, (&NTI122431));
	genericSeqAssign((&LOC10.fi), fi, (&NTI122431));
	unsureAsgnRef((void**) (&(*Result).fa), LOC10.fa);
	unsureAsgnRef((void**) (&(*Result).fi), LOC10.fi);
	popFrame();
}

N_NIMCALL(NI, nck_122631)(Factable122414 ft, NI n, NI r) {
	NI result;
	NI LOC1;
	nimfr("nCk", "main.nim")
	result = 0;
	nimln(31, "main.nim");
	LOC1 = 0;
	{
		NIM_BOOL LOC4;
		NIM_BOOL LOC5;
		LOC4 = 0;
		LOC5 = 0;
		LOC5 = (n < r);
		if (LOC5) goto LA6;
		LOC5 = (n < ((NI) 0));
		LA6: ;
		LOC4 = LOC5;
		if (LOC4) goto LA7;
		LOC4 = (r < ((NI) 0));
		LA7: ;
		if (!LOC4) goto LA8;
		LOC1 = ((NI) 0);
	}
	goto LA2;
	LA8: ;
	{
		NI LOC11;
		NI TMP347;
		NI LOC12;
		nimln(32, "main.nim");
		if ((NU)(n) >= (NU)(ft.fa->Sup.len)) raiseIndexError();
		if ((NU)(r) >= (NU)(ft.fi->Sup.len)) raiseIndexError();
		LOC11 = 0;
		LOC11 = HEX2A_122233(ft.fa->data[n], ft.fi->data[r]);
		TMP347 = subInt(n, r);
		if ((NU)((NI)(TMP347)) >= (NU)(ft.fi->Sup.len)) raiseIndexError();
		LOC12 = 0;
		LOC12 = HEX2A_122233(LOC11, ft.fi->data[(NI)(TMP347)]);
		LOC1 = toint_122214(LOC12);
	}
	LA2: ;
	result = tofin_122206(LOC1);
	popFrame();
	return result;
}

static N_INLINE(void, initStackBottomWith)(void* locals) {
	setStackBottom(locals);
}
void PreMainInner() {
	systemInit000();
	stdlib_sequtilsDatInit000();
	stdlib_parseutilsDatInit000();
	stdlib_strutilsDatInit000();
	stdlib_timesDatInit000();
	stdlib_mathDatInit000();
	stdlib_algorithmDatInit000();
	stdlib_etcprivDatInit000();
	stdlib_hashesDatInit000();
	stdlib_tablesDatInit000();
	mainDatInit000();
	stdlib_sequtilsInit000();
	stdlib_parseutilsInit000();
	stdlib_strutilsInit000();
	stdlib_timesInit000();
	stdlib_mathInit000();
	stdlib_algorithmInit000();
	stdlib_etcprivInit000();
	stdlib_hashesInit000();
	stdlib_tablesInit000();
}

void PreMain() {
	void (*volatile inner)();
	systemDatInit000();
	inner = PreMainInner;
	initStackBottomWith((void *)&inner);
	(*inner)();
}

int cmdCount;
char** cmdLine;
char** gEnv;
N_CDECL(void, NimMainInner)(void) {
	mainInit000();
}

N_CDECL(void, NimMain)(void) {
	void (*volatile inner)();
	PreMain();
	inner = NimMainInner;
	initStackBottomWith((void *)&inner);
	(*inner)();
}

int main(int argc, char** args, char** env) {
	cmdLine = args;
	cmdCount = argc;
	gEnv = env;
	NimMain();
	return nim_program_result;
}

NIM_EXTERNC N_NOINLINE(void, mainInit000)(void) {
	TY122006* HEX3Aanonymous_122201;
	TY122002 LOC1;
	NI LOC2;
	NI LOC3;
	NimStringDesc* LOC4;
	nimfr("main", "main.nim")
	nimln(3, "main.nim");
	HEX3Aanonymous_122201 = 0;
	nimln(198, "system.nim");
	HEX3Aanonymous_122201 = (TY122006*) newObj((&NTI122005), sizeof(TY122006));
	memset((void*)(&LOC1), 0, sizeof(LOC1));
	LOC1.ClPrc = HEX3Aanonymous_122001; LOC1.ClEnv = HEX3Aanonymous_122201;
	asgnRef((void**) (&get_122019.ClEnv), LOC1.ClEnv);
	get_122019.ClPrc = LOC1.ClPrc;
	nimln(4, "main.nim");
	read_122023 = HEX3Aanonymous_122020;
	nimln(34, "main.nim");
	n_122801 = read_122023();
	m_122802 = read_122023();
	k_122803 = read_122023();
	nimln(35, "main.nim");
	chckNil((void*)(&ft_122805));
	genericReset((void*)(&ft_122805), (&NTI122414));
	initfactable_122418(((NI) 200000), (&ft_122805));
	nimln(37, "main.nim");
	LOC2 = 0;
	LOC2 = nck_122631(ft_122805, ((NI) 200000), ((NI) 100000));
	LOC3 = 0;
	LOC3 = toint_122214(LOC2);
	LOC4 = 0;
	LOC4 = nimIntToStr(LOC3);
	printf("%s\012", LOC4? (LOC4)->data:"nil");
	fflush(stdout);
	popFrame();
}

NIM_EXTERNC N_NOINLINE(void, mainDatInit000)(void) {
static TNimNode* TMP323[5];
static TNimNode* TMP348[2];
static TNimNode TMP138[9];
NTI122006.size = sizeof(TY122006);
NTI122006.kind = 18;
NTI122006.base = 0;
NTI122006.flags = 2;
TMP323[0] = &TMP138[1];
NTI122008.size = sizeof(NI);
NTI122008.kind = 20;
NTI122008.base = (&NTI104);
NTI122008.flags = 3;
TMP138[1].kind = 1;
TMP138[1].offset = offsetof(TY122006, HEX3Astate);
TMP138[1].typ = (&NTI122008);
TMP138[1].name = ":state";
TMP323[1] = &TMP138[2];
TMP138[2].kind = 1;
TMP138[2].offset = offsetof(TY122006, s122004);
TMP138[2].typ = (&NTI138);
TMP138[2].name = "s122004";
TMP323[2] = &TMP138[3];
TMP138[3].kind = 1;
TMP138[3].offset = offsetof(TY122006, HEX3Atmp122012);
TMP138[3].typ = (&NTI138);
TMP138[3].name = ":tmp122012";
TMP323[3] = &TMP138[4];
TMP138[4].kind = 1;
TMP138[4].offset = offsetof(TY122006, last97798);
TMP138[4].typ = (&NTI104);
TMP138[4].name = "last97798";
TMP323[4] = &TMP138[5];
TMP138[5].kind = 1;
TMP138[5].offset = offsetof(TY122006, first98020);
TMP138[5].typ = (&NTI104);
TMP138[5].name = "first98020";
TMP138[0].len = 5; TMP138[0].kind = 2; TMP138[0].sons = &TMP323[0];
NTI122006.node = &TMP138[0];
NTI122005.size = sizeof(TY122006*);
NTI122005.kind = 22;
NTI122005.base = (&NTI122006);
NTI122005.flags = 2;
NTI122005.marker = TMP324;
NTI122414.size = sizeof(Factable122414);
NTI122414.kind = 18;
NTI122414.base = 0;
NTI122414.flags = 2;
TMP348[0] = &TMP138[7];
TMP138[7].kind = 1;
TMP138[7].offset = offsetof(Factable122414, fa);
TMP138[7].typ = (&NTI122431);
TMP138[7].name = "fa";
TMP348[1] = &TMP138[8];
TMP138[8].kind = 1;
TMP138[8].offset = offsetof(Factable122414, fi);
TMP138[8].typ = (&NTI122431);
TMP138[8].name = "fi";
TMP138[6].len = 2; TMP138[6].kind = 2; TMP138[6].sons = &TMP348[0];
NTI122414.node = &TMP138[6];
}

