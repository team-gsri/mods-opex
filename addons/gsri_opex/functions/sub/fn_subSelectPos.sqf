// Mandatory to get suspension allowed
_this spawn {
	params ["_units", "_pos", "_alt", "_shift"];

	// Map click may happen but not linked to this module
	if!(player getVariable ["submarine_flag", false]) exitWith {};

	// Check if there is water here
	_maxDepth = getTerrainHeightASL _pos;
	if(_maxDepth > -25 and worldName != "VR") exitWith { openMap false; ["SubmarineFail"] call BIS_fnc_showNotification};

	// TODO : check if there is players around the sub, both at actual and targeted coordinates

	// Select depth depending on Shift. key being pressed or not
	_pos set [2,([-25, -10] select _shift)];

	// Move submarine
	_sub = (destroyer getVariable "submarine");
	_sub setPosASL _pos;
	sleep 0.1;
	"marker_submarine" setMarkerPos getPosASL _sub;
	(destroyer getVariable "toShip") attachTo [_sub, [0.0788574,-4.32037,3.1]];
	["SubmarineOk", [["submerged", "surfaced"] select _shift]] call BIS_fnc_showNotification;

	// Finally, map must be closed, flag and map are removed by another eventHandler (see initSubmarine)
	openMap false;
};