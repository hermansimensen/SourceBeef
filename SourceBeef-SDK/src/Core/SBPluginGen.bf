namespace System
{
	extension Compiler
	{
		public class BeefPluginGen : Generator
		{
			public override String Name => "SourceBeef Plugin";

			public new override void InitUI()
			{
				AddEdit("name", "Class name", "SBPlugin");
				AddEdit("pname", "Plugin name", "");
				AddEdit("author", "Plugin author", "");
				AddEdit("website", "Plugin website", "");
			}

			public override void Generate(String outFileName, String outText, ref Flags generateFlags)
			{
				var name = mParams["name"];
				var pname = mParams["pname"];
				var author = mParams["author"];
				var website = mParams["website"];

				if (name.EndsWith(".bf", .OrdinalIgnoreCase))
					name.RemoveFromEnd(3);
					outFileName.Append(name);
					outText.AppendF(
					$"""
					using SourceBeef;

					namespace {Namespace}
					{{
						[ExportPlugin]
						public class {name} : IPlugin
						{{
							public this()
							{{
								info.Author 	= 	"{author}";
								info.Name 		= 	"{pname}";
								info.Version 	= 	"1.0";
								info.Website 	=	"{website}";
							}}

							public override bool OnLoad()
							{{
								return true;
							}}
						}}
					}}
					""");
			}
		}
	}
}