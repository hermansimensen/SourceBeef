namespace SourceBeef
{
	using System;
	using System.IO;

	static
	{
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
	struct CPluginVTable<T>
	{
		public function bool LoadFunc(T this, void* interfaceFactory, void* gameServerFactory);
		public LoadFunc Load;

		public function void UnloadFunc(T this);
		public UnloadFunc Unload;

		
		public function void PauseFunc(T this);
		public PauseFunc Pause;

		
		public function void UnPauseFunc(T this);
		public UnPauseFunc UnPause;

		
		public function void* GetPluginDescriptionFunc(T this);
		public GetPluginDescriptionFunc GetPluginDescription;

		
		public function void LevelInitFunc(T this, char8* mapname);
		public LevelInitFunc LevelInit;

		
		public function void ServerActivateFunc(T this, edict_t pEdictList, int edictCount, int clientMax);
		public ServerActivateFunc ServerActivate;

		
		public function void GameFrameFunc(T this, bool simulating);
		public GameFrameFunc GameFrame;

		
		public function void LevelShutdownFunc(T this);
		public LevelShutdownFunc LevelShutdown;

		
		public function void ClientActiveFunc(T this, edict_t entity);
		public ClientActiveFunc ClientActive;

		
		public function void ClientDisconnectFunc(T this, edict_t pEntity);
		public ClientDisconnectFunc ClientDisconnect;

		
		public function void ClientPutInServerFunc(T this, edict_t pEntity, char8* playername);
		public ClientPutInServerFunc ClientPutInServer;

		
		public function void SetClientCommandFunc(T this, int index);
		public SetClientCommandFunc SetClientCommand;

		
		public function void ClientSettingsChangedFunc(T this, edict_t pEdict);
		public ClientSettingsChangedFunc ClientSettingsChanged;

		
		public function PLUGIN_RESULT ClientConnectFunc(T this, bool *bAllowConnect, edict_t *pEntity, char8 *pszName, char8 *pszAddress, char8 *reject, int maxrejectlen );
		public ClientConnectFunc ClientConnect;

		
		public function PLUGIN_RESULT ClientCommandFunc(T this, edict_t *pEntity, CCommand args );
		public ClientCommandFunc ClientCommand;

		// A user has had their network id setup and validated
		public function PLUGIN_RESULT NetworkIDValidatedFunc(T this, char8 *pszUserName, char8 *pszNetworkID );
		public NetworkIDValidatedFunc NetworkIDValidated;

		// This is called when a query from IServerPluginHelpers::StartQueryCvarValue is finished.
		// iCookie is the value returned by IServerPluginHelpers::StartQueryCvarValue.
		// Added with version 2 of the interface.
		
		public function void OnQueryCvarValueFinishedFunc(T this);
		public OnQueryCvarValueFinishedFunc OnQueryCvarValueFinished;

		// added with version 3 of the interface.
		
		public function void OnEdictAllocatedFunc(T this, edict_t *edict);
		public OnEdictAllocatedFunc OnEdictAllocated;

		public function void OnEdictFreedFunc(T this, edict_t *edict);	
		public OnEdictFreedFunc OnEdictFreed;

		public function void FireGameEventFunc(T this, KeyValues * event);
		public FireGameEventFunc FireGameEvent;

		public function int GetCommandIndexFunc(T this);
		public GetCommandIndexFunc GetCommandIndex;
	}

	[CRepr]

	struct CPlugin<T>
	{
		public CPluginVTable<T>* vtable;
	}

	interface IPluginInterface
	{
		public bool Load(void* interfaceFactory, void* gameServerFactory)
		{
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
