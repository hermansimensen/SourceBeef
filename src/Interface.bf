namespace SourceBeef
{
	using System;
	using System.Collections;

	static
	{
		public static String pluginName =  "Beefy Source Plugin\0";

		public struct InstantiateInterfaceFn;
		static CPlugin _plugin;
	   
		public static CPlugin *createPlugin(CPluginMethods methods)
		{
			_plugin.vtable = new CPluginVTable();
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
			return &_plugin;
		}

		static SamplePlugin samplePlugin;
		public static CPlugin* plugin = createPlugin(samplePlugin);
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
