namespace SourceBeef
{
	using System;

	public static
	{
#if BF_PLATFORM_WINDOWS
		private const String TIER0_MODULE = "tier0.dll";
#elif BF_PLATFORM_LINUX
		private static String TIER0_MODULE = "libtier0.so";
#endif

		[Import(TIER0_MODULE), CLink]
		public static extern void Warning(char8* format, ...);

		[Import(TIER0_MODULE), CLink]
		public static extern void Msg(char8* format, ...);

		[Import(TIER0_MODULE), CLink]
		public static extern void Error(char8* format, ...);
	}
}
