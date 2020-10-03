if!(isServer) exitWith {};

params["_ship"];

private _leshLoaded = isClass (configFile >> "CfgPatches" >> "rksla3_aircraft_tug");
if(_leshLoaded) then {
	private _tug = createVehicle ["rksla3_aircraft_tug_blufor", ASLToATL (_ship modelToWorldWorld [7.45,47.77,8.81]), [], 0, "NONE"];
	_tug setDir getDir _ship;
	_tug animateSource ["option_cabin_hide_source", 0, true];
	_ship setVariable ["GSRI_FREMM_tug", _tug, true];
};
_ship setVariable ["GSRI_FREMM_leshLoaded", _leshLoaded];