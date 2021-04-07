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
		public bool Load(void* interfaceFactory, void* gameServerFactory)
		{
			Msg("[SamplePlugin] SamplePlugin is now loaded");
			return true;
		}

		public void* GetPluginDescription()
		{
			return "My Sample Plugin, version 1.0.0";
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
