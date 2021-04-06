namespace SourceBeef
{
	using System;
	using System.Collections;

	static
	{
		public static String pluginName =  "Beefy Source Plugin\0";

		public struct InstantiateInterfaceFn;
		static CPlugin _plugin;
		public static CPlugin *createPlugin()
		{
			_plugin.vtable = new CPluginVTable();
			_plugin.vtable.Load = => CPluginMethods.LoadFunc;
			_plugin.vtable.Unload = => CPluginMethods.UnloadFunc;
			_plugin.vtable.Pause = => CPluginMethods.PauseFunc;
			_plugin.vtable.UnPause = => CPluginMethods.UnPauseFunc;
			_plugin.vtable.GetPluginDescription = => CPluginMethods.GetPluginDescriptionFunc;
			_plugin.vtable.LevelInit = => CPluginMethods.LevelInitFunc;
			_plugin.vtable.ServerActivate = => CPluginMethods.ServerActivateFunc;
			_plugin.vtable.GameFrame = => CPluginMethods.GameFrameFunc;
			_plugin.vtable.LevelShutdown = => CPluginMethods.LevelShutdownFunc;
			_plugin.vtable.ClientActive = => CPluginMethods.ClientActiveFunc;
			_plugin.vtable.ClientDisconnect = => CPluginMethods.ClientDisconnectFunc;
			_plugin.vtable.ClientPutInServer = => CPluginMethods.ClientPutInServerFunc;
			_plugin.vtable.SetClientCommand = => CPluginMethods.SetClientCommandFunc;
			_plugin.vtable.ClientSettingsChanged = => CPluginMethods.ClientSettingsChangedFunc;
			_plugin.vtable.ClientConnect = => CPluginMethods.ClientConnectFunc;
			_plugin.vtable.ClientCommand = => CPluginMethods.ClientCommandFunc;
			_plugin.vtable.NetworkIDValidated = => CPluginMethods.NetworkIDValidatedFunc;
			_plugin.vtable.OnQueryCvarValueFinished = => CPluginMethods.OnQueryCvarValueFinishedFunc;
			_plugin.vtable.OnEdictAllocated = => CPluginMethods.OnEdictAllocatedFunc;
			_plugin.vtable.OnEdictFreed = => CPluginMethods.OnEdictFreedFunc;
			_plugin.vtable.FireGameEvent = => CPluginMethods.FireGameEventFunc;
			_plugin.vtable.GetCommandIndex = => CPluginMethods.GetCommandIndex;
			return &_plugin;
		}

		public static CPlugin* plugin = createPlugin();
	}

	class Interface
	{
		[Export, CLink]
		static public void* CreateInterface(char8* name, int* returncode)
		{
			return plugin;
		}

	}
}
