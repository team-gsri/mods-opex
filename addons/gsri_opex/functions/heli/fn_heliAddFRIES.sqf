if(isDedicated) exitWith {};

params["_ship"];

// FRIES mounting action
private _condition = {
	// Check if the heli is compatible and is not already equiped
	// params ["_target", "_player", "_args"];
	params ["", "", "_args"];
	_args params ["_hangar"];
	private _heli = [_hangar] call GSRI_fnc_heliRetrieveCurrent;
	(isNumber (configFile >> "CfgVehicles" >> typeOf _heli >> "ace_fastroping_enabled") && isNull (_heli getVariable ["ace_fastroping_FRIES", objNull]));
};
private _actionFRIES = ["actionFRIES",localize "STR_GSRI_FREMM_heliEquipFRIES","",GSRI_fnc_heliEquipFRIES,_condition,{},[(_ship getVariable "GSRI_FREMM_hangar")]] call ace_interact_menu_fnc_createAction;

// actionHeliMain should already exist
private _handle = [_ship, "Display_11"] call GSRI_fnc_screenGetById;
[_handle, 0, ["actionHeliMain"], _actionFRIES] call ace_interact_menu_fnc_addActionToObject;