// With two doors, connect each one's handle to the other's doorstep
// (and create the handle, too...)
params["_sides", "_doorName1", "_doorName2", "_action"];

private _door1 = [_sides select 0, _doorName1] call GSRI_fnc_crewGetDoor;
private _door2 = [_sides select 1, _doorName2] call GSRI_fnc_crewGetDoor;

private _handle1 = (_door1 select 0) createVehicleLocal [0,0,0];
_handle1 attachTo [(_sides select 0), (_door1 select 2)];
_handle1 setVariable ["GSRI_FREMM_goTo", (_sides select 1) modelToWorldWorld (_door2 select 3)];

private _handle2 = (_door2 select 0) createVehicleLocal [0,0,0];
_handle2 attachTo [(_sides select 1), (_door2 select 2)];
_handle2 setVariable ["GSRI_FREMM_goTo", (_sides select 0) modelToWorldWorld (_door1 select 3)];

[_handle1, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;
[_handle2, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;