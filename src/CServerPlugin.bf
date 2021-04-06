namespace SourceBeef
{
	using System;
	using System.IO;

	static
	{
		struct CreateInterfaceFn;
		struct edict_t;
		struct CCommand;
		struct KeyValues;
	}

	enum PLUGIN_RESULT
	{
		PLUGIN_CONTINUE = 0, // keep going
		PLUGIN_OVERRIDE, // run the game dll function but use our return value instead
		PLUGIN_STOP, // don't run the game dll function at all
	}

	[CRepr]
	struct CPluginVTable
	{
		public function bool LoadFunc(CPluginMethods this, void* interfaceFactory, void* gameServerFactory);
		public LoadFunc Load; //still don't know

		public function void UnloadFunc(CPluginMethods this);
		public UnloadFunc Unload;

		
		public function void PauseFunc(CPluginMethods this);
		public PauseFunc Pause;

		
		public function void UnPauseFunc(CPluginMethods this);
		public UnPauseFunc UnPause;

		
		public function void* GetPluginDescriptionFunc(CPluginMethods this);
		public GetPluginDescriptionFunc GetPluginDescription;

		
		public function void LevelInitFunc(CPluginMethods this, char8* mapname);
		public LevelInitFunc LevelInit;

		
		public function void ServerActivateFunc(CPluginMethods this, edict_t pEdictList, int edictCount, int clientMax);
		public ServerActivateFunc ServerActivate;

		
		public function void GameFrameFunc(CPluginMethods this, bool simulating);
		public GameFrameFunc GameFrame;

		
		public function void LevelShutdownFunc(CPluginMethods this);
		public LevelShutdownFunc LevelShutdown;

		
		public function void ClientActiveFunc(CPluginMethods this, edict_t entity);
		public ClientActiveFunc ClientActive;

		
		public function void ClientDisconnectFunc(CPluginMethods this, edict_t pEntity);
		public ClientDisconnectFunc ClientDisconnect;

		
		public function void ClientPutInServerFunc(CPluginMethods this, edict_t pEntity, char8* playername);
		public ClientPutInServerFunc ClientPutInServer;

		
		public function void SetClientCommandFunc(CPluginMethods this, int index);
		public SetClientCommandFunc SetClientCommand;

		
		public function void ClientSettingsChangedFunc(CPluginMethods this, edict_t pEdict);
		public ClientSettingsChangedFunc ClientSettingsChanged;

		
		public function PLUGIN_RESULT ClientConnectFunc(CPluginMethods this, bool *bAllowConnect, edict_t *pEntity, char8 *pszName, char8 *pszAddress, char8 *reject, int maxrejectlen );
		public ClientConnectFunc ClientConnect;

		
		public function PLUGIN_RESULT ClientCommandFunc(CPluginMethods this, edict_t *pEntity, CCommand args );
		public ClientCommandFunc ClientCommand;

		// A user has had their network id setup and validated
		
		public function PLUGIN_RESULT NetworkIDValidatedFunc(CPluginMethods this, char8 *pszUserName, char8 *pszNetworkID );
		public NetworkIDValidatedFunc NetworkIDValidated;

		// This is called when a query from IServerPluginHelpers::StartQueryCvarValue is finished.
		// iCookie is the value returned by IServerPluginHelpers::StartQueryCvarValue.
		// Added with version 2 of the interface.
		
		public function void OnQueryCvarValueFinishedFunc(CPluginMethods this);
		public OnQueryCvarValueFinishedFunc OnQueryCvarValueFinished;

		// added with version 3 of the interface.
		
		public function void OnEdictAllocatedFunc(CPluginMethods this, edict_t *edict);
		public OnEdictAllocatedFunc OnEdictAllocated;

		public function void OnEdictFreedFunc(CPluginMethods this, edict_t *edict);	
		public OnEdictFreedFunc OnEdictFreed;

		public function void FireGameEventFunc(CPluginMethods this, KeyValues * event);
		public FireGameEventFunc FireGameEvent;

		public function int GetCommandIndexFunc(CPluginMethods this);
		public GetCommandIndexFunc GetCommandIndex;
	}

	[CRepr]
	struct CPlugin
	{
		public CPluginVTable *vtable;
	}

	abstract class CPluginMethods
	{
	    public bool Load(void* interfaceFactory, void* gameServerFactory)
		{
			Warning("Plugin has loaded! %i \n",  69);
			Msg("This is a message \n");
			return true; 
		}
		
		public void Unload()
		{

		}
		
		public void Pause()
		{

		}
		
		public void UnPause()
		{

		}
		
		public void* GetPluginDescription()
		{
			return "My Plugin";
		}

		public void LevelInit(char8* mapname)
		{

		}
		
		public void ServerActivate(edict_t pEdictList, int edictCount, int clientMax)
		{


		}

		public void GameFrame(bool simulating)
		{

		}
		
		public void LevelShutdown()
		{

		}

		
		public void ClientActive(edict_t entity)
		{


		}
		
		public void ClientDisconnect(edict_t pEntity)
		{

		}

		public void ClientPutInServer(edict_t pEntity, char8* playername)
		{


		}
		
		public void SetClientCommand(int index)
		{

		}
		
		public void ClientSettingsChanged(edict_t pEdict)
		{

		}
		
		public PLUGIN_RESULT ClientConnect(bool *bAllowConnect, edict_t *pEntity, char8 *pszName, char8 *pszAddress, char8 *reject, int maxrejectlen)
		{
			return .PLUGIN_CONTINUE;
		}
		
		public PLUGIN_RESULT ClientCommand(edict_t *pEntity, CCommand args )
		{
			return .PLUGIN_CONTINUE;
		}
		
		public PLUGIN_RESULT NetworkIDValidated(char8 *pszUserName, char8 *pszNetworkID)
		{
			return .PLUGIN_CONTINUE;
		}
		
		public void OnQueryCvarValueFinished()
		{

		}
		
		public void OnEdictAllocated(edict_t *edict)
		{

		}

		public void OnEdictFreed(edict_t *edict)
		{

		}
		
		public void FireGameEvent(KeyValues * event)
		{
		}

		public int GetCommandIndex()
		{
			return 0;
		}
	}
}
