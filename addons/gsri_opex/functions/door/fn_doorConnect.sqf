// With two doors, connect each one's handle to the other's doorstep
// (and create the handle, too...)
// a custom action can be provided
// handle's dir might not be provided, assumed 0
params["_corridor", ["_action", []]];
(_corridor select 0) params ["_objectA","_doorNameA"];
(_corridor select 1) params ["_objectB","_doorNameB"];

if(count _action == 0) then {
	// Composing default action
	private _statement = {
		params["_doorHandle", "_player"];
		(_doorHandle getVariable "GSRI_FREMM_distantDoor") params ["_distantObject", "_distantRelPos"];
		_player setPosWorld (_distantObject modelToWorldWorld _distantRelPos);
		private _goToShip = _doorHandle getVariable ["GSRI_FREMM_goToShip", false]; //When not define, assume that it's a door going from and to a custom room
		enableEnvironment _goToShip;
	};
	_action = ["actionCrossDoor",localize "STR_GSRI_FREMM_crewCrossDoor","",_statement,{true}] call ace_interact_menu_fnc_createAction;
};

private _doorA = [_objectA, _doorNameA] call GSRI_fnc_doorGetById;
private _doorB = [_objectB, _doorNameB] call GSRI_fnc_doorGetById;

private _handle1 = (_doorA select 0) createVehicleLocal [0,0,0];
_handle1 attachTo [_objectA, (_doorA select 2)];
_handle1 setVariable ["GSRI_FREMM_distantDoor", [_objectB, _doorB select 3]];
if(count _doorA >= 4) then { _handle1 setDir (_doorA select 4) };
if(count _doorA >= 5) then { _handle1 setVariable ["GSRI_FREMM_goToShip", _doorA select 5] };

private _handle2 = (_doorB select 0) createVehicleLocal [0,0,0];
_handle2 attachTo [_objectB, (_doorB select 2)];
_handle2 setVariable ["GSRI_FREMM_distantDoor", [_objectA, _doorA select 3]];
if(count _doorB >= 4) then { _handle2 setDir (_doorB select 4) };
if(count _doorB >= 5) then { _handle2 setVariable ["GSRI_FREMM_goToShip", _doorB select 5] };

[_handle1, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;
[_handle2, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;