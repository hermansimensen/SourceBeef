namespace SourceBeef
{
	using System;

	[CRepr]
	struct CBaseEdict
	{
		int32 	m_fStateFlags;
		int 	m_NetworkSerialNumber;

		void	*m_pNetworkable;
		void	*m_pUnk;
	}

	[CRepr]
	struct edict_t : CBaseEdict;
}