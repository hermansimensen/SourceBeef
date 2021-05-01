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

	public class SamplePlugin : IPluginInterface, EventCallback
	{
		public bool Load(CreateInterfaceFn interfaceFactory, CreateInterfaceFn gameServerFactory)
		{
			//Add an event listener. 
			GameEventListener* listener = CreateEventListenerCallback(this);
			AddListener(listener, "player_spawn", true);
			AddListener(listener, "player_team", true);
			return true;
		}

		public void FireGameEvent(GameEvent* event)
		{
			String name = scope .(event.GetName());
			if(name.Equals("player_spawn"))
			{
				int userid = event.GetInt("userid");
			}

			if(name.Equals("player_team"))
			{
				int userid = event.GetInt("userid");
				int team = event.GetInt("team");

				Msg("Player with UserID %i jointed team %i", userid, team);
			}
		}

		public PLUGIN_RESULT ClientCommand(void* pEntity, CCommand* args)
		{
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
