namespace SourceBeef
{
	using System;

 	static
	{
#if BF_PLATFORM_WINDOWS
		public const String TIER0_MODULE = "tier0.dll";
#elif BF_PLATFORM_LINUX
		public static String TIER0_MODULE = "libtier0.so";
#endif

		[Import(TIER0_MODULE), CLink]
		public static extern void Warning(char8* format, ...);

		[Import(TIER0_MODULE), CLink]
		public static extern void Msg(char8* format, ...);

		[Import(TIER0_MODULE), CLink]
		public static extern void Error(char8* format, ...);

	}
}
