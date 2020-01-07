// No serverside task
if(isDedicated) exitWith {};

params["_navire"];

// Actions handle spawn
_handle = "Land_Battery_F" createVehicleLocal [0,0,0];
_handle attachTo [_navire, [-9.74,36.64,12.38]];

// Ammo handle spawn
_ammo = "Land_Battery_F" createVehicleLocal [0,0,0];
_ammo attachTo [_navire, [5.9,29,10.25]];
_ammo setVariable ["ace_rearm_isSupplyVehicle", true];

// Dummy objects for hangar and flight deck
_types = ["B_Heli_Transport_01_F", "B_Heli_Attack_01_dynamicLoadout_F", "B_Heli_Light_01_dynamicLoadout_F", "B_Heli_Light_01_F", "B_T_UAV_03_dynamicLoadout_F","MELB_AH6M","MELB_MH6M"];
{
	_helipad = "Land_HelipadEmpty_F" createVehicleLocal [0,0,0];
	_helipad enableSimulation false;
	_helipad attachTo [_navire, _x select 1];
	_helipad setDir 180; //warning : relative to attached object !
	_helipad setVariable ["heli_list", _types];
	_navire setVariable [_x select 0, _helipad];
} forEach [["GSRI_hangar", [0,44,8.81]], ["GSRI_deck", [0.08,75,8.76]]];

// Heli spawning
{
	if(isClass (configFile >> "CfgVehicles" >> _x)) then {
		_display = [_x] call GSRI_fnc_minifyName;
		_modifier = {
			params ["_t", "_p", "_args", "_actionData"];

			// Retrieving action parameters
			_args params ["_hangar", "_newType"];

			// Get the nearest chopper
			_heli = [_hangar] call GSRI_fnc_getHeli;

			// Select formattable string depending on wether there is already a chopper or not
			_displayName = ["Remplacer %1 par %2", "Demander %2"] select (isNull _heli);

			// Proper formatting of displayName and action parameters
			_actionData set [1, format [_displayName, [_heli] call GSRI_fnc_minifyName, [_newType] call GSRI_fnc_minifyName]];
		};
		_condition = {
			params["_t", "_p", "_args"];

			// Retrieving action parameters
			_args params ["_hangar", "_newType"];

			_heli = [_hangar] call GSRI_fnc_getHeli;

			// If names are the same, do not display
			(([_newType] call GSRI_fnc_minifyName) != ([_heli] call GSRI_fnc_minifyName))
		};
		_action = [format["action%1", _display],_display,"",GSRI_fnc_spawnHeli,_condition,{},[(_navire getVariable "GSRI_hangar"), _x],"",2,[false, false, false, false, false], _modifier] call ace_interact_menu_fnc_createAction;
		[_handle, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
	};
} forEach _types;

// Hangar cleaning action
[_navire, _handle] call GSRI_fnc_addCleaningAction;

// FRIES mounting action
[_navire, _handle] call GSRI_fnc_addFRIESAction;

// Place helicopter on rear deck
// TODO : replace by Lesh's tow mod
// Will not be externalized
_condition = {
	params["_t", "_p", "_args"];
	_args params ["_navire"];
	// Return true if there is a heli in hangar and if there is no heli on deck
	!(isNull ([(_navire getVariable "GSRI_hangar")] call GSRI_fnc_getHeli)) and (isNull ([(_navire getVariable "GSRI_deck")] call GSRI_fnc_getHeli))
};
_statement = {
	params["_t", "_p", "_args"];
	_args params ["_navire"];
	_heli = [(_navire getVariable "GSRI_hangar")] call GSRI_fnc_getHeli;
	["HeliMoved", [getText (configFile >> "CfgVehicles" >> typeOf _heli >> "displayName")]] call BIS_fnc_showNotification;
	_heli setPosASL getPosASL (_navire getVariable "GSRI_deck");
};
_action = ["actionDeck","Placer l'appareil sur le pont d'envol","",_statement,_condition,{},[_navire]] call ace_interact_menu_fnc_createAction;
[_handle, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

// Place helicopter in hangar
// TODO : replace by Lesh's tow mod
// Will not be externalized
_condition = {
	params["_t", "_p", "_args"];
	_args params ["_navire"];
	// Return true if there is no heli in hangar and if there is a heli on deck
	(isNull ([(_navire getVariable "GSRI_hangar")] call GSRI_fnc_getHeli)) and !(isNull ([(_navire getVariable "GSRI_deck")] call GSRI_fnc_getHeli))
};
_statement = {
	params["_t", "_p", "_args"];
	_args params ["_navire"];
	_heli = [(_navire getVariable "GSRI_deck")] call GSRI_fnc_getHeli;
	["HeliMoved", [getText (configFile >> "CfgVehicles" >> typeOf _heli >> "displayName")]] call BIS_fnc_showNotification;
	_heli setPosASL getPosASL (_navire getVariable "GSRI_hangar");
};
_action = ["actionHangar","Placer l'appareil dans le hangar","",_statement,_condition,{},[_navire]] call ace_interact_menu_fnc_createAction;
[_handle, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

// Adding fuel pomp
_fuel = "Land_FuelStation_01_pump_malevil_F" createVehicleLocal [0,0,0];
_fuel attachTo [_navire, [9.63,40.13,10.15]];
_fuel setDir 90;