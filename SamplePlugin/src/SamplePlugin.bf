namespace SamplePlugin
{
	using SourceBeef;
	using static SourceBeef.SourceBeefAPI;
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
			Msg("[SamplePlugin] SamplePlugin is now loaded \n");
			return true;
		}

		public void* GetPluginDescription()
		{
			return "My Sample Plugin, version 1.0.0";
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
