#pragma warning disable 4204

namespace SourceBeef
{
	using System;

	[CRepr]
	struct PlayerInfo
	{
		public void** calltable;

		[Inline]
		public char8* GetName() mut
		{
			function char8*(void* this) GetNameFunc = (.)calltable[0];
			return GetNameFunc(&this); 
		}

		[Inline]
		public int GetUserID() mut
		{
			function int(void* this) GetUserIDFunc = (.)calltable[1];
			return GetUserIDFunc(&this);
		}

		[Inline]
		public char8* GetNetworkIDString()
		{
			function char8*(void* this) GetNetworkIDStringFunc = (.)calltable[2];
			return GetNetworkIDStringFunc(&this);
		}

		[Inline]
		public int GetTeamIndex() mut
		{
			function int(void* this) GetTeamIndexFunc = (.)calltable[3];
			return GetTeamIndexFunc(&this);
		}

		[Inline]
		public void ChangeTeam(int iTeamNum) mut
		{
			function void(void* this, int iTeamNum) ChangeTeamFunc = (.)calltable[4];
			ChangeTeamFunc(&this, iTeamNum);
		}

		[Inline]
		public int GetFragCount() mut
 		{
			 function int(void* this) GetFragCountFunc = (.)calltable[5];
			 return GetFragCountFunc(&this);
		}

		[Inline]
		public int GetDeathCount() mut
		{
			function int(void* this) GetDeathCountFunc = (.)calltable[6];
			return GetDeathCountFunc(&this);
		}

		[Inline]
		public bool IsPlayerConnected() mut
		{
			function bool(void* this) IsPlayerConnectedFunc = (.)calltable[7];
			return IsPlayerConnectedFunc(&this);
		}

		[Inline]
		public int GetArmorValue() mut
		{
			function int(void* this) GetArmorValueFunc = (.)calltable[8];
			return GetArmorValueFunc(&this);
		}

		[Inline]
		public bool IsHLTV() mut
		{
			function bool(void* this) IsHLTVFunc = (.)calltable[9];
			return IsHLTVFunc(&this);
		}

		[Inline]
		public bool IsPlayer() mut
		{
			function bool(void* this) IsPlayerFunc = (.)calltable[10];
			return IsPlayerFunc(&this);
		}

		[Inline]
		public bool IsFakeClient() mut
		{
			function bool(void* this) IsFakeClientFunc = (.)calltable[11];
			return IsFakeClientFunc(&this);
		}

		[Inline]
		public bool IsDead() mut
		{
			function bool(void* this) IsDeadFunc = (.)calltable[12];
			return IsDeadFunc(&this);
		}

		[Inline]
		public bool IsInAVehicle() mut
		{
			function bool(void* this) IsInAVehicleFunc = (.)calltable[13];
			return IsInAVehicleFunc(&this);
		}

		[Inline]
		public bool IsObserver() mut
		{
			function bool(void* this) IsObserverFunc = (.)calltable[14];
			return IsObserverFunc(&this);
		}


		[Inline]
		public Vector GetAbsOrigin() mut
		{
			function Vector(void* this) GetAbsOriginFunc = (.)calltable[15];
			return GetAbsOriginFunc(&this);
		}

		
		[Inline]
		public int GetHealth() mut
		{
			 function int(void* this) GetHealthFunc = (.)calltable[22];
			 return GetHealthFunc(&this);
		}
	}
}
