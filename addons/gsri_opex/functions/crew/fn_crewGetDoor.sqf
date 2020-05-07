// With an object and a door name, return the appropriate door
params["_object", "_doorName"];

private _doors = _object getVariable ["GSRI_FREMM_moddedDoors", []];
private _door = [];

{
	if(_x select 1 isEqualTo _doorName) exitWith {_door = _x};
} forEach _doors;

_door