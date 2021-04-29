#pragma warning disable 4204

namespace SourceBeef
{
	using System;
	[CRepr]
	struct GameEventManager
	{
		void** calltable;

		[Inline]
		public bool AddListener(GameEventListener *listener, char8* event, bool isServerSide)
 		{
			 function bool(System.Object this, GameEventListener* ln, char8* evnt, bool isServer) AddListenerFunc = (.)calltable[3];
			 return AddListenerFunc(System.Internal.UnsafeCastToObject(&this), listener, event, isServerSide);
		}

	}
}
