namespace SourceBeef
{
	using System;
	using System.IO;

	static
	{

		struct IServerEntity;

		[CRepr]
		struct edict_t
		{
			void* ptr;
		}

		enum cmd_source_t
		{
			// Added to the console buffer by gameplay code.  Generally unrestricted.
			kCommandSrcCode,

			// Sent from code via engine->ClientCmd, which is restricted to commands visible
			// via FCVAR_CLIENTCMD_CAN_EXECUTE.
			kCommandSrcClientCmd,

			// Typed in at the console or via a user key-bind.  Generally unrestricted, although
			// the client will throttle commands sent to the server this way to 16 per second.
			kCommandSrcUserInput,

			// Came in over a net connection as a clc_stringcmd
			// host_client will be valid during this state.
			//
			// Restricted to FCVAR_GAMEDLL commands (but not convars) and special non-ConCommand
			// server commands hardcoded into gameplay code (e.g. "joingame")
			kCommandSrcNetClient,

			// Received from the server as the client
			//
			// Restricted to commands with FCVAR_SERVER_CAN_EXECUTE
			kCommandSrcNetServer,

			// Being played back from a demo file
			//
			// Not currently restricted by convar flag, but some commands manually ignore calls
			// from this source.  FIXME: Should be heavily restricted as demo commands can come
			// from untrusted sources.
			kCommandSrcDemoFile,

			// Invalid value used when cleared
			kCommandSrcInvalid = -1
		};

		[CRepr]
		struct CCommand
		{

			public int		m_nArgc;
			public int		m_nArgv0Size;
			public char8[64]	m_pArgSBuffer;
			public char8[512]	m_pArgvBuffer;
			public char8*[64] m_ppArgv;
			public cmd_source_t m_source;
		}
		struct KeyValues;

		enum IFaceReturn
		{
			IFACE_OK = 0,
			IFACE_FAILED
		};

		function void* CreateInterfaceFn(char8* test, IFaceReturn* returncode);
	}

	enum PLUGIN_RESULT
	{
		PLUGIN_CONTINUE = 0, // keep going
		PLUGIN_OVERRIDE, // run the game dll function but use our return value instead
		PLUGIN_STOP, // don't run the game dll function at all
	}

	public class CPluginBridge : IPluginInterface
	{
		public static IPluginInterface pluginInst;
		public CPlugin<CPluginBridge> pluginCallback;

		public this(IPluginInterface pluginInstance)
		{
			pluginInst = pluginInstance;
			pluginCallback = GetPluginCallback<CPluginBridge>(this);
		}

		public CPlugin<T> GetPluginCallback<T>(T methods) where T : IPluginInterface
		{
			CPlugin<T> _plugin;
			_plugin.vtable = new CPluginVTable<T>();
			_plugin.vtable.Load = => methods.Load;
			_plugin.vtable.Unload = => methods.Unload;
			_plugin.vtable.Pause = => methods.Pause;
			_plugin.vtable.UnPause = => methods.UnPause;
			_plugin.vtable.GetPluginDescription = => methods.GetPluginDescription;
			_plugin.vtable.LevelInit = => methods.LevelInit;
			_plugin.vtable.ServerActivate = => methods.ServerActivate;
			_plugin.vtable.GameFrame = => methods.GameFrame;
			_plugin.vtable.LevelShutdown = => methods.LevelShutdown;
			_plugin.vtable.ClientActive = => methods.ClientActive;
			_plugin.vtable.ClientDisconnect = => methods.ClientDisconnect;
			_plugin.vtable.ClientPutInServer = => methods.ClientPutInServer;
			_plugin.vtable.SetClientCommand = => methods.SetClientCommand;
			_plugin.vtable.ClientSettingsChanged = => methods.ClientSettingsChanged;
			_plugin.vtable.ClientConnect = => methods.ClientConnect;
			_plugin.vtable.ClientCommand = => methods.ClientCommand;
			_plugin.vtable.NetworkIDValidated = => methods.NetworkIDValidated;
			_plugin.vtable.OnQueryCvarValueFinished = => methods.OnQueryCvarValueFinished;
			_plugin.vtable.OnEdictAllocated = => methods.OnEdictAllocated;
			_plugin.vtable.OnEdictFreed = => methods.OnEdictFreed;
			_plugin.vtable.FireGameEvent = => methods.FireGameEvent;
			_plugin.vtable.GetCommandIndex = => methods.GetCommandIndex;

			return _plugin;
		}

		public bool Load(CreateInterfaceFn interfaceFactory, CreateInterfaceFn gameServerFactory)
		{
			return pluginInst.Load(interfaceFactory, gameServerFactory);
		}

		public void Unload()
		{
			pluginInst.Unload();
		}

		public void Pause()
		{
			pluginInst.Pause();
		}

		public void UnPause()
		{
			pluginInst.UnPause();
		}

		public char8* GetPluginDescription()
		{
			return pluginInst.GetPluginDescription();
		}

		public void LevelInit(char8* mapname)
		{
			pluginInst.LevelInit(mapname);
		}

		public void ServerActivate(edict_t pEdictList, int edictCount, int clientMax)
		{
			pluginInst.ServerActivate(pEdictList, edictCount, clientMax);
		}

		public void GameFrame(bool simulating)
		{
			pluginInst.GameFrame(simulating);
		}

		public void LevelShutdown()
		{
			pluginInst.LevelShutdown();
		}

		public void ClientActive(edict_t entity)
		{
			pluginInst.ClientActive(entity);
		}

		public void ClientDisconnect(edict_t pEntity)
		{
			pluginInst.ClientDisconnect(pEntity);
		}

		public void ClientPutInServer(void* pEntity, char8* playername)
		{
			pluginInst.ClientPutInServer(pEntity, playername);
		}

		public void SetClientCommand(int index)
		{
			pluginInst.SetClientCommand(index);
		}

		public void ClientSettingsChanged(edict_t pEdict)
		{
			pluginInst.ClientSettingsChanged(pEdict);
		}

		public PLUGIN_RESULT ClientConnect(bool *bAllowConnect, edict_t *pEntity, char8 *pszName, char8 *pszAddress, char8 *reject, int maxrejectlen)
		{
			return pluginInst.ClientConnect(bAllowConnect, pEntity, pszName, pszAddress, reject, maxrejectlen);
		}

		public PLUGIN_RESULT ClientCommand(void* pEntity, CCommand* args )
		{
			return pluginInst.ClientCommand(pEntity, args);
		}

		public PLUGIN_RESULT NetworkIDValidated(char8 *pszUserName, char8 *pszNetworkID)
		{
			return pluginInst.NetworkIDValidated(pszUserName, pszNetworkID);
		}

		public void OnQueryCvarValueFinished()
		{
			pluginInst.OnQueryCvarValueFinished();
		}

		public void OnEdictAllocated(edict_t *edict)
		{
			pluginInst.OnEdictAllocated(edict);
		}

		public void OnEdictFreed(edict_t *edict)
		{
			pluginInst.OnEdictFreed(edict);
		}

		public void FireGameEvent(KeyValues * event)
		{
			pluginInst.FireGameEvent(event);
		}

		public int GetCommandIndex()
		{
			return 0;
		}
	}

	[CRepr]
	struct CPluginVTable<T>
	{
		public function bool LoadFunc(T this, CreateInterfaceFn interfaceFactory, CreateInterfaceFn gameServerFactory); 
		public LoadFunc Load;

		public function void UnloadFunc(T this);
		public UnloadFunc Unload;

		
		public function void PauseFunc(T this);
		public PauseFunc Pause;

		
		public function void UnPauseFunc(T this);
		public UnPauseFunc UnPause;

		
		public function char8* GetPluginDescriptionFunc(T this);
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

		
		public function void ClientPutInServerFunc(T this, void* pEntity, char8* playername);
		public ClientPutInServerFunc ClientPutInServer;

		
		public function void SetClientCommandFunc(T this, int index);
		public SetClientCommandFunc SetClientCommand;

		
		public function void ClientSettingsChangedFunc(T this, edict_t pEdict);
		public ClientSettingsChangedFunc ClientSettingsChanged;

		
		public function PLUGIN_RESULT ClientConnectFunc(T this, bool *bAllowConnect, edict_t *pEntity, char8 *pszName, char8 *pszAddress, char8 *reject, int maxrejectlen );
		public ClientConnectFunc ClientConnect;

		
		public function PLUGIN_RESULT ClientCommandFunc(T this, void* pEntity, CCommand *args );
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
		public bool Load(CreateInterfaceFn interfaceFactory, CreateInterfaceFn gameServerFactory)
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

		public char8* GetPluginDescription()
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

		public void ClientPutInServer(void* pEntity, char8* playername)
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

		public PLUGIN_RESULT ClientCommand(void* pEntity, CCommand *args )
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