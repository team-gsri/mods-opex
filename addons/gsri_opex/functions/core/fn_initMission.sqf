{
	if!(_x getVariable ["GSRI_FREMM_selectTemplate", ""] == "") then {
		[_x] call GSRI_fnc_initFremm;
	};
} forEach allMissionObjects "Land_Destroyer_01_base_F";