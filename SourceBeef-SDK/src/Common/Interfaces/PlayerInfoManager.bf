#pragma warning disable 4204

namespace SourceBeef
{
	using System;

	[CRepr]
	struct PlayerInfoManager
	{
		public void** calltable;

		[Inline]
		public void* GetPlayerInfo(void* pEntity) mut
		{
			function void*(System.Object this, void* ent) GetPlayerInfoFunc = (.)calltable[0];
			return GetPlayerInfoFunc(System.Internal.UnsafeCastToObject(&this), pEntity);
		}

		[Inline]
		public void* GetGlobalVars()
		{
			function void*(System.Object this) GetGlobalVarsFunc = (.)calltable[1];
			return GetGlobalVarsFunc(System.Internal.UnsafeCastToObject(&this));
		}

	}
}
