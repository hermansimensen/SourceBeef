namespace SourceBeef
{
    using System;
 
  	public static
    {
        [NoDiscard]
        public static GameEventListener* CreateEventListenerCallback(EventCallback instance)
        {
            return new GameEventListener(instance);
        }
    }
 
    interface EventCallback
    {
        void FireGameEvent(GameEvent* event);
    }
 
 
	[CRepr]
	struct GameEventListener
	{
		[CallingConvention(.Cdecl)]
	    public function void DestructFunc(GameEventListener this);
		[CallingConvention(.Cdecl)]
	    public function void FireEventFunc(GameEventListener this, GameEvent* event);

	    [CRepr]
	    struct GameEventListenerVTable
	    {
	        public DestructFunc Destruct;
	        public FireEventFunc FireEventFunc;

	        public this(DestructFunc d, FireEventFunc f)
	        {
	            Destruct = d;
	            FireEventFunc = f;
	        }
	    }

		[CallingConvention(.Cdecl)]
	    void FireEvent(GameEvent* event)
	    {
	        instance.FireGameEvent(event);
	    }


		[CallingConvention(.Cdecl)]
		void Destruct()
		{
			
		}

	    private static GameEventListenerVTable s_vtbl = .(=> Destruct, => FireEvent);

	    private GameEventListenerVTable* vtable = &s_vtbl;
	  	public EventCallback pad = null;
		public static EventCallback instance;

	    public this(EventCallback cb)
	    {
	        instance = cb;
	    }
	}
}
