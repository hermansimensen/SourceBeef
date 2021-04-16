##pragma warning disable 4204

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
		public int IndexOfEdict(edict_t edict)
		{
			function int(System.Object this, edict_t pEdict) IndexOfEdictFunc = (.)calltable[18];
			return IndexOfEdictFunc(System.Internal.UnsafeCastToObject(&this), edict);
		}
	}
}
