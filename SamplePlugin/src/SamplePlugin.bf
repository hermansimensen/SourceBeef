namespace SamplePlugin
{
	using SourceBeef;
	using static SourceBeef.SourceBeefAPI; //You can do this to omit specifying the SourceBeefAPI class when accessing its helper functions. 
	using System;

	static
	{
		public static SamplePlugin myPlugin = new SamplePlugin(); //This is the instance of your plugin.
		public static CPluginBridge pluginBridge = new CPluginBridge(myPlugin); //This is a bridge between the game and your plugin. Your plugin instance must be passed in here. 
	}

	public class SamplePlugin : IPluginInterface
	{

		public bool Load(CreateInterfaceFn interfaceFactory, CreateInterfaceFn gameServerFactory)
		{
			SourceBeefAPI.Initiate(interfaceFactory, gameServerFactory); //You must initiate the API before using any of its helper functions

			return true;
		}

		public PLUGIN_RESULT ClientCommand(void* pEntity, CCommand* args)
		{
			String buffer = scope .();
			args.m_pArgSBuffer.ToString(buffer);

			if(buffer.Contains("jointeam"))
			{
				Msg("0x%X\n", PEntityOfEntIndex(IndexOfEdict(pEntity)) );
				PlayerInfo* playerinfo = GetPlayerInfo(pEntity);
				char8* name = playerinfo.GetName();
				int team = playerinfo.GetTeamIndex();

				Vector vector = playerinfo.GetAbsOrigin();

				Msg("[SamplePlugin] %s joined team %i.\n", name, team);
			}
			return .PLUGIN_CONTINUE;
		}

		public char8* GetPluginDescription()
		{
			return "My Sample Plugin, version 1.0.0";
		}
	
		public void GameFrame(bool simulating)
		{

		}

		public void ClientPutInServer(void* pEntity, char8* playername)
		{
			int client = IndexOfEdict(pEntity);

			Msg("[SamplePlugin] Client %s has connected to the server. Client index = %i \n", playername, client);
		}
	}


	//Your plugin must export a function called CreateInterface, which the game will call to retrieve the interface of your plugin. 
	public class Interface
	{
		[Export, CLink]
		static public CPlugin<CPluginBridge>* CreateInterface(char8* name, int* returncode)
		{
			return &pluginBridge.pluginCallback;
		} 
	}
}
