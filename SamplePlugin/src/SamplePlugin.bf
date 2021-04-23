namespace SamplePlugin
{
	using SourceBeef;
	using static SourceBeef.SourceBeefAPI; //You can do this to omit specifying the SourceBeefAPI class when accessing its helper functions. 
	using System;

	static
	{
		public static SamplePlugin thisPlugin = new SamplePlugin();
		public static CPlugin<SamplePlugin> plugin = CreatePlugin<SamplePlugin>(thisPlugin);
	}

	public class SamplePlugin : IPluginInterface
	{
		public bool Load(CreateInterfaceFn interfaceFactory, CreateInterfaceFn gameServerFactory)
		{
			SourceBeefAPI.Initiate(interfaceFactory, gameServerFactory); //You need to initiate the SourceBeef API before you can use any of its calls.

			Msg("[SamplePlugin] SamplePlugin is now loaded \n");
			return true;
		}

		public char8* GetPluginDescription()
		{
			return "My Sample Plugin, version 1.0.0";
		}

		public void GameFrame(bool simulating)
		{
			CGlobalVars* globals = gpGlobals;

			Msg("%f %f\n", globals.interval_per_tick, globals.curtime);
		}

		public void ClientPutInServer(edict_t pEntity, char8* playername)
		{
			int client = IndexOfEdict(pEntity);
			Msg("[SamplePlugin] Client %s has connected to the server. Client index = %i \n", playername, client);
		}
	}

	public class Interface
	{
		[Export, CLink]
		static public CPlugin<SamplePlugin>* CreateInterface(char8* name, int* returncode)
		{
			return &plugin;
		} 
	}
}
