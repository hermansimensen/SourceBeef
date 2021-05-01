namespace SourceBeef
{
	using System;
	struct GameEvent
	{
		void** calltable;

		[Inline]
		public char8* GetName() mut
		{
			function char8*(void* this) GetNameFunc = (.)calltable[1];
			return GetNameFunc(&this);
		}

		[Inline]
		public bool IsReliable() mut
		{
			function bool(void* this) IsReliableFunc = (.)calltable[2];
			return IsReliableFunc(&this);
		}

		[Inline]
		public bool IsLocal() mut
		{
			function bool(void* this) IsLocalFunc = (.)calltable[3];
			return IsLocalFunc(&this);
		}

		[Inline]
		public bool IsEmpty() mut
		{
			function bool(void* this) IsEmptyFunc = (.)calltable[4];
			return IsEmptyFunc(&this);
		}

		[Inline]
		public bool GetBool(char8* keyName = null, bool defaultValue = false) mut
		{
			function bool(void* this, char8*, bool) GetBoolFunc = (.)calltable[5];
			return GetBoolFunc(&this, keyName, defaultValue);
		}

		[Inline]
		public int32 GetInt(char8* keyName = null, int defaultValue = 0) mut
		{
			function int32(void* this, char8*, int) GetIntFunc = (.)calltable[6];
			return GetIntFunc(&this, keyName, defaultValue);
		}

		[Inline]
		public float GetFloat(char8* keyName = null, float defaultValue = 0) mut
		{
			function float(void* this, char8*, float) GetFloatFunc = (.)calltable[7];
			return GetFloatFunc(&this, keyName, defaultValue);
		}

		[Inline]
		public char8* GetString(char8* keyName = null, char8* defaultValue = "") mut
		{
			function char8*(void* this, char8*, char8*) GetStringFunc = (.)calltable[8];
			return GetStringFunc(&this, keyName, defaultValue);
		}

		[Inline]
		public void SetBool(char8* keyName, bool value) mut
		{
			function bool(void* this, char8*, bool) SetBoolFunc = (.)calltable[9];
			SetBoolFunc(&this, keyName, value);
		}

		[Inline]
		public void SetInt(char8* keyName, int value) mut
		{
			function int32(void* this, char8*, int) SetIntFunc = (.)calltable[10];
			SetIntFunc(&this, keyName, value);
		}

		[Inline]
		public void SetFloat(char8* keyName, float value) mut
		{
			function float(void* this, char8*, float) SetFloatFunc = (.)calltable[11];
			SetFloatFunc(&this, keyName, value);
		}

		[Inline]
		public void SetString(char8* keyName, char8* value) mut
		{
			function char8*(void* this, char8*, char8*) SetStringFunc = (.)calltable[12];
			SetStringFunc(&this, keyName, value);
		}
	}
}
