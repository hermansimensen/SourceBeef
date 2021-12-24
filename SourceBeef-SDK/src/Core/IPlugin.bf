namespace SourceBeef
{
	using System;

	[CRepr]
	struct PluginInfo : IDisposable
	{
		private String mName;
		private String mVersion;
		private String mAuthor;
		private String mWebsite;

		public void Dispose()
		{
			if(mName != null) delete mName;
			if(mVersion != null) delete mVersion;
			if(mAuthor != null) delete mAuthor;
			if(mWebsite != null) delete mWebsite;
		}

		public String Name
		{
			get;set mut;
		}

		public String Version
		{
			get { return mVersion; }
			set mut { mVersion = value;}
		}

		public String Author
		{
			get { return mAuthor; }
			set mut { mAuthor = value;}
		}

		public String Website
		{
			get { return mWebsite; }
			set mut { mWebsite = value;}
		}

	}

	enum PluginResult
	{
		Continue = 0, // keep going
		Override, // run the game dll function but use our return value instead
		Stop, // don't run the game dll function at all
	}

	[CRepr]
	struct CCommand
	{

		public int32		m_nArgc;
		public int32		m_nArgv0Size;
		public char8[512]	m_pArgSBuffer;
		public char8[512]	m_pArgvBuffer;
		public char8[64]	m_ppArgv;
		public cmd_source_t m_source;
	}
	
	enum EQueryCvarValueStatus
	{
		ValueIntact=0,	// It got the value fine.
		CvarNotFound=1,
		NotACvar=2,		// There's a ConCommand, but it's not a ConVar.
		CvarProtected=3	// The cvar was marked with FCVAR_SERVER_CAN_NOT_QUERY, so the server is not allowed to have its value.
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
	}

	abstract class IPlugin
	{
		public PluginInfo info = .();

		/*
		 * Gets called when the plugin is about to load.
		 * Return false to stop plugin from loading.
		 * This is NOT DllMain, you can implement DLLMain yourself if needed.
		 */
		public virtual bool OnLoad() { return true; }

		/*
		 *	Gets called when the plugin is unloaded from the system. 
		 */
		public virtual void OnUnload() {}

		/*
		 *	This returns a struct with your plugins name and version information.
		 */
		public virtual PluginInfo GetPluginInfo() { return info; }

		/*
		 *	Gets called when the server initites a level
		 */
		public virtual void OnLevelInit(char8* pMapName) {}

		/*
		 *	Gets called when the server shuts down a level
		 */
		public virtual void OnLevelShutdown() {}

		public virtual void OnServerActivate(edict_t* pEdictList, int32 edictCount, int32 clientMax) {}

		public virtual void OnGameFrame(bool simulating) {}

		public virtual void OnClientActive(edict_t* entity) {}

		/*
		 *  This function is only available in newer games like CSGO.
		 */
		public virtual void OnClientFullyConnect(edict_t* entity) {}

		public virtual void OnClientDisconnect(edict_t* entity) {}

		public virtual void OnClientPutInServer(edict_t* entity, char8* playername) {}

		public virtual PluginResult OnClientConnect(ref bool bAllowConnect, void* pEntity, char8* pszName, char8* pszAddress, char8 *reject, int32 maxrejectlen) { return .Continue; }

		public virtual PluginResult OnClientCommand(edict_t* pEntity, CCommand* args) { return .Continue; }

		public virtual PluginResult OnNetworkIDValidated(char8 *pszUserName, char8 *pszNetworkID) { return .Continue; }

		public virtual void OnQueryCvarValueFinished(void* iCookie, edict_t* pPlayerEntity, EQueryCvarValueStatus eStatus, char8 *pCvarName, char8 *pCvarValue) {}
	}

	struct VContainer<T> where T : IPlugin
	{
		public VTable<T>* table;
		public static T myInst;

		public this(T inst)
		{
			myInst = inst;
			table = new .();
		}

		public void DeleteInstance()
		{
			delete (IPlugin) myInst;
		}

		public static bool Load() { return myInst.OnLoad(); }
		public static void Unload() { myInst.OnUnload(); }
		public static PluginInfo PluginInfo() { return myInst.GetPluginInfo(); }
		public static void LevelInit(char8* pMapName) { myInst.OnLevelInit(pMapName); }
		public static void LevelShutdown() { myInst.OnLevelShutdown(); }
		public static void ServerActivate(edict_t* pEdictList, int32 edictCount, int32 clientMax) { myInst.OnServerActivate(pEdictList, edictCount, clientMax); }
		public static void GameFrame(bool simulating) { myInst.OnGameFrame(simulating); }
		public static void ClientActive(edict_t* entity) { myInst.OnClientActive(entity); }
		public static void ClientFullyConnect(edict_t* entity) { myInst.OnClientFullyConnect(entity); }
		public static void ClientDisconnect(edict_t* entity) { myInst.OnClientDisconnect(entity); }
		public static void ClientPutInServer(edict_t* entity, char8* playername) { myInst.OnClientPutInServer(entity, playername); }
		public static PluginResult ClientConnect(ref bool bAllowConnect, void* pEntity, char8* pszName, char8* pszAddress, char8 *reject, int32 maxrejectlen) { return myInst.OnClientConnect(ref bAllowConnect, pEntity, pszName, pszAddress, reject, maxrejectlen); }
		public static PluginResult ClientCommand(edict_t* pEntity, CCommand* args) { return myInst.OnClientCommand(pEntity, args); }
		public static PluginResult NetworkIDValidated(char8 *pszUserName, char8 *pszNetworkID) { return myInst.OnNetworkIDValidated(pszUserName, pszNetworkID); }
		public static void OnQueryCvarValueFinished(void* iCookie, edict_t* pPlayerEntity, EQueryCvarValueStatus eStatus, char8 *pCvarName, char8 *pCvarValue) { myInst.OnQueryCvarValueFinished(iCookie, pPlayerEntity, eStatus, pCvarName, pCvarValue); }

		[CRepr]
		public struct VTable<T>
		{
			public this()
			{
				Load = => VContainer<T>.Load;
				Unload = => VContainer<T>.Unload;
				PluginInfo = => VContainer<T>.PluginInfo;
				LevelInit = => VContainer<T>.LevelInit;
				LevelShutdown = => VContainer<T>.LevelShutdown;
				ServerActivate = => VContainer<T>.ServerActivate;
				GameFrame = => VContainer<T>.GameFrame;
				ClientActive = => VContainer<T>.ClientActive;
				ClientFullyConnect = => VContainer<T>.ClientFullyConnect;
				ClientDisconnect = => VContainer<T>.ClientDisconnect;
				ClientPutInServer = => VContainer<T>.ClientPutInServer;
				ClientConnect = => VContainer<T>.ClientConnect;
				ClientCommand = => VContainer<T>.ClientCommand;
				NetworkIDValidated = => VContainer<T>.NetworkIDValidated;
				OnQueryCvarValueFinished = => VContainer<T>.OnQueryCvarValueFinished;
			}

			public function bool() Load;
			public function void() Unload;
			public function PluginInfo() PluginInfo;
			public function void(char8* pMapName) LevelInit;
			public function void() LevelShutdown;
			public function void(edict_t* pEdictList, int32 edictCount, int32 clientMax) ServerActivate;
			public function void(bool simulating) GameFrame;
			public function void(edict_t* entity) ClientActive;
			public function void(edict_t* entity) ClientFullyConnect;
			public function void(edict_t* entity) ClientDisconnect;
			public function void(edict_t* entity, char8* playername) ClientPutInServer;
			public function PluginResult(ref bool bAllowConnect, void* pEntity, char8* pszName, char8* pszAddress, char8 *reject, int32 maxrejectlen) ClientConnect;
			public function PluginResult(edict_t* pEntity, CCommand* args) ClientCommand;
			public function PluginResult(char8 *pszUserName, char8 *pszNetworkID) NetworkIDValidated;
			public function void(void* iCookie, edict_t* pPlayerEntity, EQueryCvarValueStatus eStatus, char8 *pCvarName, char8 *pCvarValue) OnQueryCvarValueFinished;
		}
	}

	[AttributeUsage(.Class)]
	public struct ExportPluginAttribute : Attribute, IComptimeTypeApply
	{
		[Comptime]
		public void ApplyToType(Type type)
		{
			String name = scope .();
			type.GetName(name);

			String instLine = scope .();
			instLine.Append(name);
			instLine.Append(" inst = new .();\n");

			String returnLine = scope String("\treturn new .(inst);\n");

			Compiler.EmitTypeBody(type, "[CLink, Export]\n");
		    Compiler.EmitTypeBody(type, "public static VContainer<IPlugin>* CreateInstance()\n{\n");
			Compiler.EmitTypeBody(type, instLine);
			Compiler.EmitTypeBody(type, returnLine);
			Compiler.EmitTypeBody(type, "}\n");

			Compiler.EmitTypeBody(type, "[CLink, Export]\n");
			Compiler.EmitTypeBody(type, "public static int32 GetInterfaceVersion() { return 1; }");
		}
	}
}
