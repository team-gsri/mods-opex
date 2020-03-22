if!(isServer) then {
	diag_log "Client is waiting for server init";
	waitUntil { !isNil "GSRI_FREMM_clientCanLoad" };
	diag_log "clientCanLoad detected, will now load template";
};

{
	_template = _x getVariable ["GSRI_FREMM_selectTemplate", ""];
	if!(_template == "") then {
		_x setVariable ["GSRI_FREMM_selectTemplate", _template, true];
		[_x] call GSRI_fnc_initFremm;
	};
} forEach allMissionObjects "Land_Destroyer_01_base_F";

if(isServer) then {
	GSRI_FREMM_clientCanLoad = true;
	publicVariable "GSRI_FREMM_clientCanLoad";
};

diag_log "initMission finished.";