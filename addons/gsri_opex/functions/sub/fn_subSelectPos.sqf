// Mandatory to get suspension allowed
_this spawn {
	// params ["_units", "_pos", "_alt", "_shift"];
	params ["", "_pos"];

	// Map click may happen but not linked to this module
	if(isNull (player getVariable ["GSRI_FREMM_engine", objNull])) exitWith {};
	
	// Check if there is water here
	private _availableDepth = abs (getTerrainHeightASL _pos);
	if(_availableDepth > 30 and worldName != "VR") then {
		private _engine = player getVariable "GSRI_FREMM_engine";
		_pos set [2, -20];
		_engine setPosWorld _pos;
		_engine swimInDepth -20;
		["SubmarineOk"] call BIS_fnc_showNotification;
		openMap false;
	} else {
		["SubmarineFail"] call BIS_fnc_showNotification;
	};
};