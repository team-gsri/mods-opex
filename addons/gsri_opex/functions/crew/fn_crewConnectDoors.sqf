// With two doors, connect each one's handle to the other's doorstep
// (and create the handle, too...)
params["_corridor", "_action"];
(_corridor select 0) params ["_objectA","_doorNameA"];
(_corridor select 1) params ["_objectB","_doorNameB"];

private _doorA = [_objectA, _doorNameA] call GSRI_fnc_crewGetDoor;
private _doorB = [_objectB, _doorNameB] call GSRI_fnc_crewGetDoor;

private _handle1 = (_doorA select 0) createVehicleLocal [0,0,0];
_handle1 attachTo [_objectA, (_doorA select 2)];
_handle1 setVariable ["GSRI_FREMM_goTo", _objectB modelToWorldWorld (_doorB select 3)];

private _handle2 = (_doorB select 0) createVehicleLocal [0,0,0];
_handle2 attachTo [_objectB, (_doorB select 2)];
_handle2 setVariable ["GSRI_FREMM_goTo", _objectA modelToWorldWorld (_doorA select 3)];

[_handle1, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;
[_handle2, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;