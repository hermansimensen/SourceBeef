namespace SourceBeef
{
	using System;
	static
	{
		static SourceBeefAPI sourceBeefAPI;
		public static CGlobalVars* gpGlobals;

		enum EngineVersion
		{
			Engine_CSS,
			Engine_CSGO
		}
	}

	static class SourceBeefAPI
	{
		public static PlayerInfoManager *playerInfoManager;
		public static VEngineServer *vEngineServer;
		public static GameEventManager *gameEventManager;
		static IFaceReturn retCode;


		static CreateInterfaceFn gameServerFactory;
		static CreateInterfaceFn interfaceFactory;

		private static EngineVersion engineVersion;

		public static void Initiate(CreateInterfaceFn interfaceF, CreateInterfaceFn gameServerF)
		{
			interfaceFactory = interfaceF;
			gameServerFactory = gameServerF;
			DetectGame();
			RegisterInterfaces();

			gpGlobals = playerInfoManager.GetGlobalVars();
		}

		public static EngineVersion GetEngineVersion()
		{
			return engineVersion;
		}

		private static void DetectGame()
		{
			String workingDir = scope String();

			System.IO.Directory.GetCurrentDirectory(workingDir);

			for (var dirEntry in System.IO.Directory.EnumerateDirectories(workingDir))
			{
				let dirName = scope String();
				dirEntry.GetFilePath(dirName);

				if(dirName.Contains("cstrike"))
				{
					engineVersion = .Engine_CSS;
				}
				else if (dirName.Contains("csgo"))
				{
					engineVersion = .Engine_CSGO;
				}
			}
			return;
		}

		private static void RegisterInterfaces()
		{
			playerInfoManager = (PlayerInfoManager*) gameServerFactory("PlayerInfoManager002", &retCode);

			if(retCode == .IFACE_FAILED)
			{
				Error("Could not get PlayerInfoManager002 interface.");
				return;
			}

			vEngineServer = (VEngineServer*) interfaceFactory("VEngineServer023", &retCode);

			if(retCode == .IFACE_FAILED)
			{
				Error("Could not get VEngineServer023 interface.");
				return;
			}

			gameEventManager = (GameEventManager*) interfaceFactory("GAMEEVENTSMANAGER002", &retCode);

			if(retCode == .IFACE_FAILED)
			{
				Error("Could not get GAMEEVENTSMANAGER002 interface.");
				return;
			}
		}

		/*
		 *	Here is where we expose some helper functions to the plugin so manual hooking of interfaces isn't needed.
		 */

		public static int IndexOfEdict(void* pEdict)
		{
			return vEngineServer.IndexOfEdict(pEdict);
		}

		public static void* PEntityOfEntIndex( int iEntIndex )
		{
			return vEngineServer.PEntityOfEntIndex(iEntIndex);
		}

		public static PlayerInfo* GetPlayerInfo(void* pEdict)
		{
			return (PlayerInfo*) playerInfoManager.GetPlayerInfo(pEdict);
		}

		public static bool AddListener(GameEventListener *listener, char8* event, bool isServerSide)
		{
			return gameEventManager.AddListener(listener, event, isServerSide);
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
