namespace SourceBeef
{
	using System;

	static
	{
		public static void Warning(String sInput, ...)
		{
			VarArgs vaArgs = .();
			vaArgs.Start!();
			Tier0.Warning_C(sInput.CStr(), vaArgs.ToVAList());
			vaArgs.End!();
		}

		public static void Msg(String sInput, ...)
		{
			VarArgs vaArgs = .();
			vaArgs.Start!();
			Tier0.Msg_C(sInput.CStr(), vaArgs.ToVAList());
			vaArgs.End!();
		}

		public static void Error(String sInput, ...)
		{
			VarArgs vaArgs = .();
			vaArgs.Start!();
			Tier0.Error_C(sInput.CStr(), vaArgs.ToVAList());
			vaArgs.End!();
		}
	}

	class Tier0
	{
		[Import("tier0.dll"), LinkName("WarningV")]
		public static extern void Warning_C(char8* format, void* varArgs);

		[Import("tier0.dll"), LinkName("MsgV")]
		public static extern void Msg_C(char8* format, void* varArgs);

		[Import("tier0.dll"), LinkName("ErrorV")]
		public static extern void Error_C(char8* format, void* varArgs);

	}
}
