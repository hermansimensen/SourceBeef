namespace SourceBeefAPI
{
	using SourceBeef;
	using System;

	public static class Exports
	{
		private static EngineVersion mEngineVersion;
		private static void* mTier0Lib;

		private static PlayerInfoManager* mPlayerInfoManager;
		private static void* mCGlobals;

		function void MsgFunc(char8* message, ...);
		private static MsgFunc mTier0Msg;

#if BF_PLATFORM_WINDOWS
		public const String TIER0_BIN = "tier0.dll";
#elif BF_PLATFORM_LINUX
		public const String TIER0_BIN = "tier0.so";
#endif

		enum IFaceReturn
		{
			IFACE_OK = 0,
			IFACE_FAILED
		};

		public static this()
		{
			DetectEngine();

			InitiatePlayerInfoManager();
		}

		private static void InitiatePlayerInfoManager()
		{
			IFaceReturn ret; 
			mPlayerInfoManager = (.) CreateInterfaceServer("PlayerInfoManager002", &ret);
			mCGlobals = mPlayerInfoManager.GetGlobalVars();
		}

		private static void DetectEngine()
		{
			var workDir = scope String();
			System.IO.Directory.GetCurrentDirectory(workDir);

			for(var directory in System.IO.Directory.EnumerateDirectories(workDir))
			{
				var name = scope String();
				directory.GetFileName(name);

				if(name.Equals("cstrike"))
				{
					mEngineVersion = .Engine_CSS;
					break;
				}
				else if(name.Equals("csgo"))
				{
					mEngineVersion = .Engine_CSGO;
					break;
				}
			}
		}

		[Import("server.dll"), LinkName("CreateInterface")]
		public static extern void* CreateInterfaceServer(char8* name, IFaceReturn* returncode);

		[Import("engine.dll"), LinkName("F(IEngineAPI * *)")]
		public static extern void* CreateInterfaceEngine(char8* name, IFaceReturn* returncode);

		[Export, CLink]
		public static EngineVersion GetEngineVersion()
		{
			return mEngineVersion;
		}

		[Export, CLink]
		public static void GetMsgFunc(char8* message)
		{
			if(mTier0Lib == null)
			{
				let workingDir = scope String();
				System.IO.Directory.GetCurrentDirectory(workingDir);
				workingDir.Append("/bin/" + TIER0_BIN);
				mTier0Lib = System.Internal.LoadSharedLibrary(workingDir);
				mTier0Msg = (.) System.Internal.GetSharedProcAddress(mTier0Lib, "Msg");
			}
			mTier0Msg(message);
		}

		[Export, CLink]
		public static void* GetGlobals()
		{
			return mCGlobals;
		}


	}
}