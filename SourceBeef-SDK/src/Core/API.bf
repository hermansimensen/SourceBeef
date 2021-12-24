namespace SourceBeef
{
	using System;
	enum EngineVersion
	{
		Engine_Unknown,
		Engine_CSS,
		Engine_CSGO
	}

	public static class API
	{
		private static void* mAPILib;

		private static function EngineVersion GetEngineVersionFunc();
		private static GetEngineVersionFunc GetEngineVersionInternal;

		private static function void MsgFunc(char8* message, ...);
		private static MsgFunc MsgFuncInternal;

		private static function CGlobalVars* GetGlobalsFunc();
		private static GetGlobalsFunc GetGlobalsInternal;

		private static void LoadSBAPIBinary()
		{
			var workDir = scope String();
			System.IO.Directory.GetCurrentDirectory(workDir);

			for(var directory in System.IO.Directory.EnumerateDirectories(workDir))
			{
				var name = scope String();
				directory.GetFileName(name);

				if(name.Equals("cstrike"))
				{
					#if BF_PLATFORM_WINDOWS
						workDir.Append("/cstrike/addons/sourcebeef/bin/SourceBeefAPI.dll");
					#elif BF_PLATFRORM_LINUX
						workDir.Append("/cstrike/addons/sourcebeef/bin/SourceBeefAPI.so");
					#endif
					break;
				}
				else if(name.Equals("csgo"))
				{
					#if BF_PLATFORM_WINDOWS
						workDir.Append("/csgo/addons/sourcebeef/bin/SourceBeefAPI.dll");
					#elif BF_PLATFRORM_LINUX
						workDir.Append("/csgo/addons/sourcebeef/bin/SourceBeefAPI.so");
					#endif
					break;
				}
			}

			mAPILib = System.Internal.LoadSharedLibrary(workDir);
		}

		public static this()
		{
			LoadSBAPIBinary();

			GetEngineVersionInternal = (.) System.Internal.GetSharedProcAddress(mAPILib, "GetEngineVersion");
			MsgFuncInternal = (.) System.Internal.GetSharedProcAddress(mAPILib, "GetMsgFunc");
			GetGlobalsInternal = (.) System.Internal.GetSharedProcAddress(mAPILib, "GetGlobals");
		}

		public static EngineVersion GetEngineVersion()
		{
			return GetEngineVersionInternal();
		}

		public static void Msg(StringView message, params Object[] args)
		{
			String str = scope String(256);
			str.AppendF(message, params args);
			MsgFuncInternal(str.CStr());
		}

		public static CGlobalVars* GetGlobalVars()
		{
			return GetGlobalsInternal();
		}
	}


}
