namespace SourceBeef
{
	using System;

	public static
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

	public class Tier0
	{
		[Import("tier0.dll"), LinkName("Warning")]
		public static extern void Warning_C(char8* format, void* varArgs);

		[Import("tier0.dll"), LinkName("Msg")]
		public static extern void Msg_C(char8* format, void* varArgs);

		[Import("tier0.dll"), LinkName("Error")]
		public static extern void Error_C(char8* format, void* varArgs);
	}
}
