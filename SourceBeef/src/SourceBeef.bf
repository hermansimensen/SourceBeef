namespace SourceBeef
{
	using System;
	using System.Collections;
	using System.IO;

	static
	{
		function void* LogFunc(char8* message, ...);
		public static ServerPlugin VSP;

		function VContainer<IPlugin>* GetPluginCallbacks();

		[CRepr]
		struct BeefPlugin
		{
			public PluginInfo mInfo;
			public VContainer<IPlugin> callbacks;
			public bool bIsDisabled;
			public int32 mInterfaceVersion;
		}
	}

	[AlwaysInclude]
	public static class SourceBeef
	{
		public static List<BeefPlugin> mPluginList = new .();
		private static void* mAPILib;

		public static this()
		{
			LoadPlugins(); //Lets iterate through our plugins and load them into the process.

			VSP = new ServerPlugin();
		}

		public static ~this()
		{
			delete VSP;
		}

		/*
		 *	The game will call this function to get the vtable of our VSP, this happens in CPlugin::Load in sv_plugin.cpp
		 */
		[Export, CLink]
		static public VTableContainer* CreateInterface(char8* name, int32* returncode)
		{
			return &VSP.mTable;
		}

		public static void LoadPlugins()
		{
			let workingDir = scope String();
			Directory.GetCurrentDirectory(workingDir);

			bool bCSGO = (API.GetEngineVersion() == .Engine_CSGO);

			if(bCSGO) {workingDir.Append("/csgo/addons/sourcebeef/plugins"); } else { workingDir.Append("/cstrike/addons/sourcebeef/plugins"); }

			for(var dirEntry in Directory.EnumerateFiles(workingDir))
			{
				String fileName = scope .();
				dirEntry.GetFileName(fileName);

				if(fileName.EndsWith(".dll") || fileName.EndsWith(".so"))
				{
					String filePath = scope .();
					dirEntry.GetFilePath(filePath);

					void* handle = Internal.LoadSharedLibrary(filePath);

					GetPluginCallbacks test = (.)Internal.GetSharedProcAddress(handle, "CreateInstance");

					function int32() GetInterfaceVersion;

					GetInterfaceVersion = (.)Internal.GetSharedProcAddress(handle, "GetInterfaceVersion");

					VContainer<IPlugin> pluginFuncs = *test();

					BeefPlugin plugin = .();
					plugin.bIsDisabled = false;
					plugin.callbacks = pluginFuncs;
					plugin.mInfo = pluginFuncs.table.PluginInfo();
					plugin.mInterfaceVersion = GetInterfaceVersion();

					mPluginList.Add(plugin);
				}
			}
		}
	}
}
