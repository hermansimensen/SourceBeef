namespace SourceBeef
{
	using System;

	typealias string_t = char8*;

#if CSTRIKE
	typealias CGlobalVars = SourceBeef.CSS.CGlobalVars;
#elif CSGO
	typealias CGlobalVars = SourceBeef.CSGO.CGlobalVars;
#else
	[CRepr]
	struct CGlobalVars;
#endif

}