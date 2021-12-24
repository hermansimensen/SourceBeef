using SourceBeef;
using System;

namespace SamplePlugin
{
	[ExportPlugin]
	public class MyPlugin : IPlugin
	{
		public this()
		{
			info.Author = "carnifex";
			info.Name = "Basic SourceBeef plugin";
			info.Version = "1.0";
			info.Website = "https://github.com/hermansimensen/sourcebeef";
		}

		public override bool OnLoad()
		{
			API.Msg("Plugin successfully loaded. \n");
			return true;
		}

		private float mTimeElapsed;

		public override void OnGameFrame(bool simulating)
		{
			if(simulating)
			{
				mTimeElapsed += API.GetGlobalVars().interval_per_tick;
			}
		}
	}
}