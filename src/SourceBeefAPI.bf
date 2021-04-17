namespace SourceBeef
{
	using System;
	static
	{
		static SourceBeefAPI sourceBeefAPI;
		public static CGlobalVars* gpGlobals;
	}

	static class SourceBeefAPI
	{
		public static PlayerInfoManager *playerInfoManager;
		public static VEngineServer *vEngineServer;
		
		[Import("server.dll"), CLink]
		public static extern void* CreateInterface(char8* name, IFaceReturn* returnCode);

		[Import("engine.dll"), LinkName("CreateInterface")]
		public static extern void* CreateInterfaceEngine(char8* name, IFaceReturn* returnCode);

		static IFaceReturn retCode;

		public static this()
		{
			playerInfoManager = (PlayerInfoManager*) CreateInterface("PlayerInfoManager002", &retCode);

			if(retCode == .IFACE_FAILED)
			{
				Error("Could not get PlayerInfoManager002 interface.");
				return;
			}

			vEngineServer = (VEngineServer*) CreateInterfaceEngine("VEngineServer023", &retCode);

			if(retCode == .IFACE_FAILED)
			{
				Error("Could not get VEngineServer023 interface.");
				return;
			}

			gpGlobals = playerInfoManager.GetGlobalVars();
		}

		/*
		 *	Here is where we expose some helper functions to the plugin so manual hooking of interfaces isn't needed.
		 */

		public static int IndexOfEdict(edict_t pEdict)
		{
			return vEngineServer.IndexOfEdict(pEdict);
		}

		/*
		 * Precache calls.
		 */

		public static int PrecacheModel(char8* s, bool preload)
		{
			return vEngineServer.PrecacheModel(s, preload);
		}

		public static int PrecacheSentenceFile(char8* s, bool preload)
		{
			return vEngineServer.PrecacheSentenceFile(s, preload);
		}

		public static int PrecacheDecal(char8* s, bool preload)
		{
			return vEngineServer.PrecacheDecal(s, preload);
		}

		public static int PrecacheGeneric(char8* s, bool preload)
		{
			return vEngineServer.PrecacheGeneric(s, preload);
		}

		public static bool IsModelPrecached(char8* s)
		{
			return vEngineServer.IsModelPrecached(s);
		}

		public static bool IsDecalPrecached(char8* s)
		{
			return vEngineServer.IsDecalPrecached(s);
		}

		public static bool IsGenericPrecached(char8* s)
		{
			return vEngineServer.IsGenericPrecached(s);
		}

		/*
		 *	End of precache calls. 
		 */ 
	}
}
