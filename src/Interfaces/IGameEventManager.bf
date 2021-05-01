#pragma warning disable 4204

namespace SourceBeef
{
	using System;

	[CRepr]
	struct GameEventManager
	{
		void** calltable;

		[Inline]
		public bool AddListener(GameEventListener *listener, char8* event, bool isServerSide) mut
 		{
			 function bool(void* this, GameEventListener *ln, char8* evnt, bool isServer) AddListenerFunc = (.)calltable[3];
			 return AddListenerFunc(&this, listener, event, isServerSide);
		}
	}
}
