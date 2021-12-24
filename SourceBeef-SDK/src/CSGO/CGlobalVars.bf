namespace SourceBeef.CSGO
{
	using SourceBeef;
	using System;

	enum MapLoadType_t : int32
	{
		MapLoad_NewGame = 0,
		MapLoad_LoadGame,
		MapLoad_Transition,
		MapLoad_Background,
	}

	[CRepr]
	struct CGlobalVarsBase
	{
		// Absolute time (per frame still - Use Plat_FloatTime() for a high precision real time 
		//  perf clock, but not that it doesn't obey host_timescale/host_framerate)
		public float			realtime;
		// Absolute frame counter
		public int32			framecount;
		// Non-paused frametime
		public float			absoluteframetime;

		// Current time 
		//
		// On the client, this (along with tickcount) takes a different meaning based on what
		// piece of code you're in:
		// 
		//   - While receiving network packets (like in PreDataUpdate/PostDataUpdate and proxies),
		//     this is set to the SERVER TICKCOUNT for that packet. There is no interval between
		//     the server ticks.
		//     [server_current_Tick * tick_interval]
		//
		//   - While rendering, this is the exact client clock 
		//     [client_current_tick * tick_interval + interpolation_amount]
		//
		//   - During prediction, this is based on the client's current tick:
		//     [client_current_tick * tick_interval]
		public float			curtime;

		// Time spent on last server or client frame (has nothing to do with think intervals)
		public float			frametime;
		// current maxplayers setting
		public int32			maxClients;

		// Simulation ticks
		public int32			tickcount;

		// Simulation tick interval
		public float			interval_per_tick;

		// interpolation amount ( client-only ) based on fraction of next tick which has elapsed
		public float			interpolation_amount;
		public int32			simTicksThisFrame;

		public int32			network_protocol;
	}

	[CRepr]
	struct CGlobalVars : CGlobalVarsBase
	{
		string_t		mapname;
		int32			mapversion;
		string_t		startspot;
		MapLoadType_t	eLoadType;		// How the current map was loaded
		bool			bMapLoadFailed;	// Map has failed to load, we need to kick back to the main menu

		// game specific flags
		bool			deathmatch;
		bool			coop;
		bool			teamplay;
		// current maxentities
		int32			maxEntities;

		int32			serverCount;
		edict_t			*pEdicts;
	}
}