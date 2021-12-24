namespace SourceBeef
{
	using System;

	static
	{
		public const char8* VERSION_STRING = "0.1";
	}

	[CRepr]
	public struct IServerPluginCallbacks;

	[CRepr] //This version of the interface is used for older games (i.e CS:S)
	struct VTableOld : IServerPluginCallbacks
	{
		public this(ServerPlugin plugin)
		{

			Load = => plugin.Load;
			Unload = => plugin.Unload;
			Pause = => plugin.Pause;
			UnPause = => plugin.UnPause;
			GetPluginDescription = => plugin.GetPluginDescription;
			LevelInit = => plugin.LevelInit;
			ServerActivate = => plugin.ServerActivate;
			GameFrame = => plugin.GameFrame;
			LevelShutdown = => plugin.LevelShutdown;
			ClientActive = => plugin.ClientActive;
			ClientDisconnect = => plugin.ClientDisconnect;
			ClientPutInServer = => plugin.ClientPutInServer;
			SetClientCommand = => plugin.SetClientCommand;
			ClientSettingsChanged = => plugin.ClientSettingsChanged;
			ClientConnect = => plugin.ClientConnect;
			ClientCommand = => plugin.ClientCommand;
			NetworkIDValidated = => plugin.NetworkIDValidated;
			OnQueryCvarValueFinished = => plugin.OnQueryCvarValueFinished;
			OnEdictAllocated = => plugin.OnEdictAllocated;
			OnEdictFreed = => plugin.OnEdictFreed;
		}

		public function bool LoadFunc(ServerPlugin this, void* interfaceFactory, void* gameServerFactory);
 		public LoadFunc Load;

		public function void UnloadFunc(ServerPlugin this);
		public UnloadFunc Unload;


		public function void PauseFunc(ServerPlugin this);
		public PauseFunc Pause;


		public function void UnPauseFunc(ServerPlugin this);
		public UnPauseFunc UnPause;


		public function char8* GetPluginDescriptionFunc(ServerPlugin this);
		public GetPluginDescriptionFunc GetPluginDescription;


		public function void LevelInitFunc(ServerPlugin this, char8* mapname);
		public LevelInitFunc LevelInit;


		public function void ServerActivateFunc(ServerPlugin this, edict_t* pEdictList, int32 edictCount, int32 clientMax);
		public ServerActivateFunc ServerActivate;


		public function void GameFrameFunc(ServerPlugin this, bool simulating);
		public GameFrameFunc GameFrame;


		public function void LevelShutdownFunc(ServerPlugin this);
		public LevelShutdownFunc LevelShutdown;


		public function void ClientActiveFunc(ServerPlugin this, edict_t* entity);
		public ClientActiveFunc ClientActive;


		public function void ClientDisconnectFunc(ServerPlugin this, edict_t* pEntity);
		public ClientDisconnectFunc ClientDisconnect;


		public function void ClientPutInServerFunc(ServerPlugin this, edict_t* pEntity, char8* playername);
		public ClientPutInServerFunc ClientPutInServer;


		public function void SetClientCommandFunc(ServerPlugin this, int32 index);
		public SetClientCommandFunc SetClientCommand;


		public function void ClientSettingsChangedFunc(ServerPlugin this, edict_t* pEdict);
		public ClientSettingsChangedFunc ClientSettingsChanged;


		public function PluginResult ClientConnectFunc(ServerPlugin this, bool *bAllowConnect, edict_t* pEntity, char8 *pszName, char8 *pszAddress, char8 *reject, int32 maxrejectlen);
		public ClientConnectFunc ClientConnect;


		public function PluginResult ClientCommandFunc(ServerPlugin this, edict_t* pEntity, CCommand* args);
		public ClientCommandFunc ClientCommand;

		// A user has had their network id setup and validated
		public function PluginResult NetworkIDValidatedFunc(ServerPlugin this, char8 *pszUserName, char8 *pszNetworkID);
		public NetworkIDValidatedFunc NetworkIDValidated;

		// This is called when a query from IServerPluginHelpers::StartQueryCvarValue is finished.
		// iCookie is the value returned by IServerPluginHelpers::StartQueryCvarValue.
		// Added with version 2 of the interface.

		public function void OnQueryCvarValueFinishedFunc(ServerPlugin this, void* iCookie, edict_t* pPlayerEntity, EQueryCvarValueStatus eStatus, char8 *pCvarName, char8 *pCvarValue);
		public OnQueryCvarValueFinishedFunc OnQueryCvarValueFinished;

		// added with version 3 of the interface.

		public function void OnEdictAllocatedFunc(ServerPlugin this, edict_t* edict);
		public OnEdictAllocatedFunc OnEdictAllocated;

		public function void OnEdictFreedFunc(ServerPlugin this, edict_t* edict);	
		public OnEdictFreedFunc OnEdictFreed;
	}

	[CRepr] //This version of the interface is used for older games (i.e CS:S)
	struct VTableNew : IServerPluginCallbacks
	{
		public this(ServerPlugin plugin)
		{
			Load = => plugin.Load;
			Unload = => plugin.Unload;
			Pause = => plugin.Pause;
			UnPause = => plugin.UnPause;
			GetPluginDescription = => plugin.GetPluginDescription;
			LevelInit = => plugin.LevelInit;
			ServerActivate = => plugin.ServerActivate;
			GameFrame = => plugin.GameFrame;
			LevelShutdown = => plugin.LevelShutdown;
			ClientActive = => plugin.ClientActive;
			ClientFullyConnect = => plugin.ClientFullyConnect;
			ClientDisconnect = => plugin.ClientDisconnect;
			ClientPutInServer = => plugin.ClientPutInServer;
			SetClientCommand = => plugin.SetClientCommand;
			ClientSettingsChanged = => plugin.ClientSettingsChanged;
			ClientConnect = => plugin.ClientConnect;
			ClientCommand = => plugin.ClientCommand;
			NetworkIDValidated = => plugin.NetworkIDValidated;
			OnQueryCvarValueFinished = => plugin.OnQueryCvarValueFinished;
			OnEdictAllocated = => plugin.OnEdictAllocated;
			OnEdictFreed = => plugin.OnEdictFreed;
			BNetworkCryptKeyCheckRequired = => plugin.BNetworkCryptKeyCheckRequired;
			BNetworkCryptKeyValidate = => plugin.BNetworkCryptKeyValidate;

		}

		public function bool LoadFunc(ServerPlugin this, void* interfaceFactory, void* gameServerFactory);
		public LoadFunc Load;

		public function void UnloadFunc(ServerPlugin this);
		public UnloadFunc Unload;


		public function void PauseFunc(ServerPlugin this);
		public PauseFunc Pause;


		public function void UnPauseFunc(ServerPlugin this);
		public UnPauseFunc UnPause;


		public function char8* GetPluginDescriptionFunc(ServerPlugin this);
		public GetPluginDescriptionFunc GetPluginDescription;


		public function void LevelInitFunc(ServerPlugin this, char8* mapname);
		public LevelInitFunc LevelInit;


		public function void ServerActivateFunc(ServerPlugin this, edict_t* pEdictList, int32 edictCount, int32 clientMax);
		public ServerActivateFunc ServerActivate;


		public function void GameFrameFunc(ServerPlugin this, bool simulating);
		public GameFrameFunc GameFrame;


		public function void LevelShutdownFunc(ServerPlugin this);
		public LevelShutdownFunc LevelShutdown;


		public function void ClientActiveFunc(ServerPlugin this, edict_t* entity);
		public ClientActiveFunc ClientActive;

		public function void ClientFullyConnectFunc(ServerPlugin this, edict_t* entity);
		public ClientFullyConnectFunc ClientFullyConnect;

		public function void ClientDisconnectFunc(ServerPlugin this, edict_t* pEntity);
		public ClientDisconnectFunc ClientDisconnect;


		public function void ClientPutInServerFunc(ServerPlugin this, edict_t* pEntity, char8* playername);
		public ClientPutInServerFunc ClientPutInServer;


		public function void SetClientCommandFunc(ServerPlugin this, int32 index);
		public SetClientCommandFunc SetClientCommand;


		public function void ClientSettingsChangedFunc(ServerPlugin this, edict_t* pEdict);
		public ClientSettingsChangedFunc ClientSettingsChanged;


		public function PluginResult ClientConnectFunc(ServerPlugin this, bool *bAllowConnect, edict_t* pEntity, char8 *pszName, char8 *pszAddress, char8 *reject, int32 maxrejectlen);
		public ClientConnectFunc ClientConnect;


		public function PluginResult ClientCommandFunc(ServerPlugin this, edict_t* pEntity, CCommand* args);
		public ClientCommandFunc ClientCommand;

		// A user has had their network id setup and validated
		public function PluginResult NetworkIDValidatedFunc(ServerPlugin this, char8 *pszUserName, char8 *pszNetworkID);
		public NetworkIDValidatedFunc NetworkIDValidated;

		// This is called when a query from IServerPluginHelpers::StartQueryCvarValue is finished.
		// iCookie is the value returned by IServerPluginHelpers::StartQueryCvarValue.
		// Added with version 2 of the interface.

		public function void OnQueryCvarValueFinishedFunc(ServerPlugin this, void* iCookie, edict_t* pPlayerEntity, EQueryCvarValueStatus eStatus, char8 *pCvarName, char8 *pCvarValue);
		public OnQueryCvarValueFinishedFunc OnQueryCvarValueFinished;

		// added with version 3 of the interface.

		public function void OnEdictAllocatedFunc(ServerPlugin this, edict_t* edict);
		public OnEdictAllocatedFunc OnEdictAllocated;

		public function void OnEdictFreedFunc(ServerPlugin this, edict_t* edict);	
		public OnEdictFreedFunc OnEdictFreed;

		public function bool BNetworkCryptKeyCheckRequiredFunc(ServerPlugin this, uint32 unFromIP, uint16 usFromPort, uint32 unAccountIdProvidedByClient, bool bClientWantsToUseCryptKey);
		public BNetworkCryptKeyCheckRequiredFunc BNetworkCryptKeyCheckRequired;

		public function bool BNetworkCryptKeyValidateFunc(ServerPlugin this, uint32 unFromIP, uint16 usFromPort, uint32 unAccountIdProvidedByClient, int nEncryptionKeyIndexFromClient, int numEncryptedBytesFromClient, uint8 *pbEncryptedBufferFromClient, uint8 *pbPlainTextKeyForNetchan);
		public BNetworkCryptKeyValidateFunc BNetworkCryptKeyValidate;
	}

	[CRepr]
	struct VTableContainer
	{
		public IServerPluginCallbacks* table;

		public this(ServerPlugin plugin, EngineVersion engineVersion)
		{
			if(engineVersion == .Engine_CSS)
			{
				table = new VTableOld(plugin);
			}
			else if(engineVersion == .Engine_CSGO)
			{
				table = new VTableNew(plugin);
			} else
			{
				table = ?;
			}
			
		}
	}

	class ServerPlugin
	{
		public VTableContainer mTable;

		public this()
		{
			mTable = .(this, API.GetEngineVersion());
		}

		public bool Load(void* ecx, void* test)
		{
			for(var plugin in SourceBeef.mPluginList)
			{
				bool ret = plugin.callbacks.table.Load();
				if(!ret)
				{
					SourceBeef.mPluginList.Remove(plugin);
					API.Msg("[SourceBeef] Skipping plugin {}, version: {} \n", plugin.mInfo.Name, plugin.mInfo.Version);
				} else
				{
					API.Msg("[SourceBeef] Loading plugin {}, version: {} \n", plugin.mInfo.Name, plugin.mInfo.Version);
				}
			}
			
			return true;
		}

		public void Unload()
		{
			for(var plugin in SourceBeef.mPluginList)
			{
				plugin.callbacks.table.Unload();
				plugin.callbacks.DeleteInstance();
				SourceBeef.mPluginList.Remove(plugin);
			} 
		}	

		public void Pause()
		{
			for(var plugin in SourceBeef.mPluginList)
			{
				plugin.bIsDisabled = true;
			}
		}

		public void UnPause()
		{
			for(var plugin in SourceBeef.mPluginList)
			{
				plugin.bIsDisabled = false;
			}
		}

		public char8* GetPluginDescription()
		{
			return "SourceBeef - " + VERSION_STRING;
		}

		public void LevelInit(char8* pMapName)
		{
			for(var plugin in SourceBeef.mPluginList)
			{
				plugin.callbacks.table.LevelInit(pMapName);
			}
		}

		public void ServerActivate(edict_t* pEdictList, int32 edictCount, int32 clientMax)
		{
			for(var plugin in SourceBeef.mPluginList)
			{
				plugin.callbacks.table.ServerActivate(pEdictList, edictCount, clientMax);
			}
		}

		public void GameFrame(bool simulating)
		{
			for(var plugin in SourceBeef.mPluginList)
			{
				plugin.callbacks.table.GameFrame(simulating);
			}
		}

		public void LevelShutdown()
		{
			for(var plugin in SourceBeef.mPluginList)
			{
				plugin.callbacks.table.LevelShutdown();
			}
		}

		public void ClientActive(edict_t* pEntity)
		{
			for(var plugin in SourceBeef.mPluginList)
			{
				plugin.callbacks.table.ClientActive(pEntity);
			}
		}

		public void ClientFullyConnect(edict_t* pEntity)
		{
			for(var plugin in SourceBeef.mPluginList)
			{
				plugin.callbacks.table.ClientFullyConnect(pEntity);
			}
		}

		public void ClientDisconnect(edict_t* pEntity)
		{
			for(var plugin in SourceBeef.mPluginList)
			{
				plugin.callbacks.table.ClientDisconnect(pEntity);
			}
		}

		public void ClientPutInServer(edict_t* pEntity, char8* playername)
		{
			for(var plugin in SourceBeef.mPluginList)
			{
				plugin.callbacks.table.ClientPutInServer(pEntity, playername);
			}
		}

		public void SetClientCommand(int32 index)
		{

		}

		public void ClientSettingsChanged(edict_t* pEdict)
		{

		}

		public PluginResult ClientConnect(bool *bAllowConnect, edict_t* pEntity, char8* pszName, char8* pszAddress, char8 *reject, int32 maxrejectlen)
		{
			PluginResult result = .Continue;

			bool AllowConnect = true;
			bool Override = false;

			for(var plugin in SourceBeef.mPluginList)
			{
				if(!plugin.bIsDisabled)
				{
					result = plugin.callbacks.table.ClientConnect(ref AllowConnect, pEntity, pszName, pszAddress, reject, maxrejectlen);
					if(result == .Stop)
					{
						*bAllowConnect = AllowConnect;
						return result;
					}

					if(result == .Override)
					{
						Override = true;
					}
				}
			}

			if(Override)
			{
				return .Override;
			}

			return result; 
		}

		public PluginResult ClientCommand(edict_t* pEntity, CCommand* args)
		{
			PluginResult result = .Continue;
			bool Override = false;

			for(var plugin in SourceBeef.mPluginList)
			{
				if(!plugin.bIsDisabled)
				{
					result = plugin.callbacks.table.ClientCommand(pEntity, args);
					if(result == .Stop)
					{
						return result;
					}

					if(result == .Override)
					{
						Override = true;
					}
				}
			}

			if(Override)
			{
				return .Override;
			}

			return result; 
		}

		public PluginResult NetworkIDValidated(char8* pszUserName, char8* pszNetworkID)
		{
			PluginResult result = .Continue;
			bool Override = false;

			for(var plugin in SourceBeef.mPluginList)
			{
				if(!plugin.bIsDisabled)
				{
					result = plugin.callbacks.table.NetworkIDValidated(pszUserName, pszNetworkID);
					if(result == .Stop)
					{
						return result;
					}

					if(result == .Override)
					{
						Override = true;
					}
				}
			}

			if(Override)
			{
				return .Override;
			}

			return result; 
		}

		public void OnQueryCvarValueFinished(void* iCookie, edict_t* pPlayerEntity, EQueryCvarValueStatus eStatus, char8 *pCvarName, char8 *pCvarValue)
		{
			for(var plugin in SourceBeef.mPluginList)
			{
				plugin.callbacks.table.OnQueryCvarValueFinished(iCookie, pPlayerEntity, eStatus, pCvarName, pCvarValue);
			}
		}

		public void	OnEdictAllocated(edict_t* edict)
		{

		}

		public void OnEdictFreed(edict_t* edict )
		{

		}

		public bool	BNetworkCryptKeyCheckRequired(uint32 unFromIP, uint16 usFromPort, uint32 unAccountIdProvidedByClient, bool bClientWantsToUseCryptKey)
		{
			return true;
		}

		public bool	BNetworkCryptKeyValidate(uint32 unFromIP, uint16 usFromPort, uint32 unAccountIdProvidedByClient, int nEncryptionKeyIndexFromClient, int numEncryptedBytesFromClient, uint8 *pbEncryptedBufferFromClient, uint8 *pbPlainTextKeyForNetchan)
		{
			return true;
		} 
	}
}


