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
			function void*(System.Object this) GetGlobalVarsFunc = (.)calltable[1];
			return (CGlobalVars*)GetGlobalVarsFunc(System.Internal.UnsafeCastToObject(&this));
		}

	}
}
