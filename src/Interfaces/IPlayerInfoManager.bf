#pragma warning disable 4204

namespace SourceBeef
{
	using System;
	struct PlayerInfoManager
	{
		public void** calltable;

		[Inline]
		public CGlobalVars* GetGlobalVars()
		{
			function CGlobalVars*(System.Object this) GetGlobalVarsFunc = (.)calltable[1];
			return GetGlobalVarsFunc(System.Internal.UnsafeCastToObject(&this));
		}

	}
}
