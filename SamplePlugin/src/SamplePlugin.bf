namespace SamplePlugin
{
	using SourceBeef;
	using System;

	static
	{
		public static SamplePlugin thisPlugin = new SamplePlugin();
		public static CPlugin<SamplePlugin> plugin = CreatePlugin<SamplePlugin>(thisPlugin);
	}

	public class SamplePlugin : IPluginInterface
	{
		VEngineServer *engineServer = new VEngineServer();

		public bool Load(CreateInterfaceFn interfaceFactory, CreateInterfaceFn gameServerFactory)
		{
			IFaceReturn retCode = ?;

			engineServer = (VEngineServer*)interfaceFactory("VEngineServer023", &retCode);

			if(retCode == .IFACE_FAILED)
			{
				Error("Could not find the VEngineServer023 interface");
				return false;
			}

			Msg("[SamplePlugin] SamplePlugin is now loaded %p \n");
			return true;
		}

		public void* GetPluginDescription()
		{
			return "My Sample Plugin, version 1.0.0";
		}

		public void ClientPutInServer(edict_t pEntity, char8* playername)
		{
			int client = engineServer.IndexOfEdict(pEntity);

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
