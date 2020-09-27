// params ["_target", "_player", "_otherParams"];
params ["_target", "", "_otherParams"];
_otherParams params ["_boatType", ["_boatLivery", ""]];

private _bay = (_target getVariable "GSRI_FREMM_associatedBay");
private _boat = (getVehicleCargo _bay) select 0;

// If bay is full, need to empty it first
if!(isNil "_boat") then
{
	if (typeOf _boat isEqualTo "B_Boat_Transport_01_F") then { deleteVehicle (_boat getVariable "nameOfShovel") }; // Shovel bug on CRRC
	deleteVehicle _boat;
};

if(_boatType != "") then {
	waitUntil { count (getVehicleCargo _bay) == 0 }; // Previous deletion might take a few frames
	_boat = createVehicle [_boatType, [0,0,0], [], 0, "NONE"];
	_bay setVehicleCargo _boat;

	// Change livery
	if(_boatLivery != "") then {
		[_boat, _boatLivery] call BIS_fnc_initVehicle;
	};
};
