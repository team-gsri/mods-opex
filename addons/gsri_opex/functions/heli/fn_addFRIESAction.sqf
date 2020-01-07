//Add FRIES mounting action to given handle

params["_boat", "_handle"];

_condition = {
	params ["_t", "_p", "_args"];
	_args params ["_hangar"];
	_heli = [_hangar] call GSRI_fnc_getHeli;
	(isNumber (configFile >> "CfgVehicles" >> typeOf _heli >> "ace_fastroping_enabled") && isNull (_heli getVariable ["ace_fastroping_FRIES", objNull]));
};

_statement = {
	params ["_t", "_p", "_args"];
	_args params ["_hangar"];
	_heli = [_hangar] call GSRI_fnc_getHeli;
	["HeliFRIES", [getText (configFile >> "CfgVehicles" >> typeOf _heli >> "displayName")]] call BIS_fnc_showNotification;
	[_heli] remoteExecCall ["ace_fastroping_fnc_equipFRIES", 2];
};

_action = ["actionFRIES","Equiper FRIES","",_statement,_condition,{},[(_boat getVariable "GSRI_hangar")]] call ace_interact_menu_fnc_createAction;
[_handle, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;