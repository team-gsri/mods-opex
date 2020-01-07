// Add cleaning action to given handle
// Will remove any chopper landed on the "hangar" position of given destroyer

params["_boat", "_handle"];

_modifier = {
    params ["_t", "_p", "_args", "_actionData"];
	_args params ["_hangar"];
	_heli = [_hangar] call GSRI_fnc_getHeli;
	// Proper formatting of displayName and action parameters
    _actionData set [1, format ["Supprimer %1", [_heli] call GSRI_fnc_minifyName]];
};

_condition = {
	params ["_t", "_p", "_args"];
	_args params ["_hangar"];
	!isNull ([_hangar] call GSRI_fnc_getHeli)
};

_statement = {
	params ["_t", "_p", "_args"];
	_args params ["_hangar"];
	_heli = ([_hangar] call GSRI_fnc_getHeli);
	["HeliDelete", [getText (configFile >> "CfgVehicles" >> typeOf _heli >> "displayName")]] call BIS_fnc_showNotification;
	deleteVehicle _heli;
};

_action = ["actionClear","Supprimer","",_statement,_condition,{},[(_boat getVariable "GSRI_hangar")],"",2,[false, false, false, false, false], _modifier] call ace_interact_menu_fnc_createAction;
[_handle, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;