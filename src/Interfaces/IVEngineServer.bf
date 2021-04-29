#pragma warning disable 4204

namespace SourceBeef
{
	using System;

	struct VEngineServer
	{
		public void **calltable;

		[Inline]
		public void ChangeLevel(char8* s1, char8* s2)
		{
			function void(System.Object this, char8* s1, char8* s2) ChangeLevelFunc = (.)calltable[0];
			ChangeLevelFunc(System.Internal.UnsafeCastToObject(&this), s1, s2);
		}

		[Inline]
		public int IsMapValid(char8* filename)
		{
			function int(System.Object this, char8* fn) IsMapValidFunc = (.)calltable[1];
			return IsMapValidFunc(System.Internal.UnsafeCastToObject(&this), filename);
		}

		[Inline]
		public bool IsDedicatedServer()
		{
			function bool(System.Object this) IsDedicatedServerFunc = (.)calltable[2];
			return IsDedicatedServerFunc(System.Internal.UnsafeCastToObject(&this));
		}

		[Inline]
		public int IsInEditMode()
		{
			function int(System.Object this) IsInEditModeFunc = (.)calltable[3];
			return IsInEditModeFunc(System.Internal.UnsafeCastToObject(&this));
		}

		[Inline]
		public int PrecacheModel(char8* s, bool preload)
		{
			function int(System.Object this, char8* str, bool pre) PrecacheModelFunc = (.)calltable[4];
			return PrecacheModelFunc(System.Internal.UnsafeCastToObject(&this), s, preload);
		}

		[Inline]
		public int PrecacheSentenceFile(char8* s, bool preload)
		{
			function int(System.Object this, char8* str, bool pre) PrecacheSentenceFunc = (.)calltable[5];
			return PrecacheSentenceFunc(System.Internal.UnsafeCastToObject(&this), s, preload);
		}

		[Inline]
		public int PrecacheDecal(char8* s, bool preload)
		{
			function int(System.Object this, char8* str, bool pre) PrecacheDecalFunc = (.)calltable[6];
			return PrecacheDecalFunc(System.Internal.UnsafeCastToObject(&this), s, preload);
		}

		[Inline]
		public int PrecacheGeneric(char8* s, bool preload)
		{
			function int(System.Object this, char8* str, bool pre) PrecacheGenericFunc = (.)calltable[7];
			return PrecacheGenericFunc(System.Internal.UnsafeCastToObject(&this), s, preload);
		}

		[Inline]
		public bool IsModelPrecached(char8* s)
		{
			function bool(System.Object this, char8* str) IsModelPrecachedFunc = (.)calltable[8];
			return IsModelPrecachedFunc(System.Internal.UnsafeCastToObject(&this), s);
		}

		[Inline]
		public bool IsDecalPrecached(char8* s)
		{
			function bool(System.Object this, char8* str) IsDecalPrecachedFunc = (.)calltable[9];
			return IsDecalPrecachedFunc(System.Internal.UnsafeCastToObject(&this), s);
		}

		[Inline]
		public bool IsGenericPrecached(char8* s)
		{
			function bool(System.Object this, char8* str) IsGenericPrecachedFunc = (.)calltable[10];
			return IsGenericPrecachedFunc(System.Internal.UnsafeCastToObject(&this), s);
		}

		[Inline]
		public int IndexOfEdict(void* edict)
		{
			function int(System.Object this, void* pEdict) IndexOfEdictFunc = (.)calltable[18];
			return IndexOfEdictFunc(System.Internal.UnsafeCastToObject(&this), edict);
		}

		
		[Inline]
		public void* PEntityOfEntIndex( int iEntIndex )
		{
			function void*(System.Object this, int pEdict) IndexOfEdictFunc = (.)calltable[19];
			return IndexOfEdictFunc(System.Internal.UnsafeCastToObject(&this), iEntIndex);
		}
	}
}
