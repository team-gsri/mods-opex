if!(isServer) exitWith {};
{
	if("GSRI_Normandie" in vehicleVarName _x) then {
		// TODO optimiser ce truc
		_x setVariable ["GSRI_FREMM_fullname", getText (configFile >> "GSRI_FREMM_Templates" >> "GSRI_Normandie" >> "fullname")];
		_x setVariable ["GSRI_FREMM_identifier", getText (configFile >> "GSRI_FREMM_Templates" >> "GSRI_Normandie" >> "identifier")];
		_x setVariable ["GSRI_FREMM_name", getText (configFile >> "GSRI_FREMM_Templates" >> "GSRI_Normandie" >> "name")];
		_x setVariable ["GSRI_FREMM_flag", getText (configFile >> "GSRI_FREMM_Templates" >> "GSRI_Normandie" >> "flag")];
		_x setVariable ["GSRI_FREMM_nameplate", getText (configFile >> "GSRI_FREMM_Templates" >> "GSRI_Normandie" >> "nameplate")];
		_x setVariable ["GSRI_FREMM_hasWeapons", [false, true] select getNumber (configFile >> "GSRI_FREMM_Templates" >> "GSRI_Normandie" >> "hasWeapons")];
		_x setVariable ["GSRI_FREMM_hasArsenal", [false, true] select getNumber (configFile >> "GSRI_FREMM_Templates" >> "GSRI_Normandie" >> "hasArsenal")];
		_x setVariable ["GSRI_FREMM_hasBridge", [false, true] select getNumber (configFile >> "GSRI_FREMM_Templates" >> "GSRI_Normandie" >> "hasBridge")];
		_x setVariable ["GSRI_FREMM_hasBoatBays", [false, true] select getNumber (configFile >> "GSRI_FREMM_Templates" >> "GSRI_Normandie" >> "hasBoatBays")];
		_x setVariable ["GSRI_FREMM_hasHelicopter", [false, true] select getNumber (configFile >> "GSRI_FREMM_Templates" >> "GSRI_Normandie" >> "hasHelicopter")];
		_x setVariable ["GSRI_FREMM_hasSubmarine", [false, true] select getNumber (configFile >> "GSRI_FREMM_Templates" >> "GSRI_Normandie" >> "hasSubmarine")];
		[_x] call GSRI_fnc_initFremm;
	};
} forEach allMissionObjects "Land_Destroyer_01_base_F";