if!(isServer) exitWith {};
{
	if("GSRI_Normandie" in vehicleVarName _x) then {
		_x setVariable ["GSRI_FREMM_fullname", GSRI_Normandie_fullname];
		_x setVariable ["GSRI_FREMM_identifier", GSRI_Normandie_identifier];
		_x setVariable ["GSRI_FREMM_name", GSRI_Normandie_name];
		_x setVariable ["GSRI_FREMM_flag", GSRI_Normandie_flag];
		_x setVariable ["GSRI_FREMM_nameplate", GSRI_Normandie_nameplate];
		_x setVariable ["GSRI_FREMM_hasWeapons", GSRI_Normandie_hasWeapons];
		_x setVariable ["GSRI_FREMM_hasArsenal", GSRI_Normandie_hasArsenal];
		_x setVariable ["GSRI_FREMM_hasBridge", GSRI_Normandie_hasBridge];
		_x setVariable ["GSRI_FREMM_hasBoatBays", GSRI_Normandie_hasBoatBays];
		_x setVariable ["GSRI_FREMM_hasHelicopter", GSRI_Normandie_hasHelicopter];
		_x setVariable ["GSRI_FREMM_hasSubmarine", GSRI_Normandie_hasSubmarine];
		[_x] call GSRI_fnc_initFremm;
	};
} forEach allMissionObjects "Land_Destroyer_01_base_F";