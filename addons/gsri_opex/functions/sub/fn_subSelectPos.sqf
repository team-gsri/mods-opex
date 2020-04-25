// Mandatory to get suspension allowed
_this spawn {
	// params ["_units", "_pos", "_alt", "_shift"];
	params ["", "_pos", "", "_shift"];
	private ["_maxDepth","_sub","_ship"];

	// Map click may happen but not linked to this module
	if!(player getVariable ["GSRI_FREMM_submarine_token", false]) exitWith {};
	
	// Cannot pass custom arguments. Correct ship must be "guessed" based on location
	_ship = nearestObject [player, "Land_Destroyer_01_base_F"];

	// Check if there is water here
	_maxDepth = getTerrainHeightASL _pos;
	if(_maxDepth > -25 and worldName != "VR") exitWith { openMap false; ["SubmarineFail"] call BIS_fnc_showNotification};

	// TODO : check if there is players around the sub, both at actual and targeted coordinates

	// Select depth depending on Shift. key being pressed or not
	_pos set [2,([-25, -10] select _shift)];

	// Move submarine
	_sub = (_ship getVariable "GSRI_FREMM_submarine");
	_sub setPosASL _pos;
	sleep 0.1;
	"marker_submarine" setMarkerPos getPosASL _sub;
	(_ship getVariable "GSRI_FREMM_submarine_toShip") attachTo [_sub, [0.0788574,-4.32037,3.1]];
	["SubmarineOk", [["submerged", "surfaced"] select _shift]] call BIS_fnc_showNotification;

	// Finally, map must be closed, flag and map are removed by another eventHandler (see initSubmarine)
	openMap false;
};