// No serverside task
if(isDedicated) exitWith {};

params["_ship"];
private ["_handle","_fuel","_types","_helipad"];

// Actions handle spawn
_handle = ((_ship getVariable "GSRI_FREMM_screens") select 0);

// Adding fuel pomp
_fuel = "Land_FuelStation_01_pump_malevil_F" createVehicleLocal [0,0,0];
_fuel attachTo [_ship, [9.63,40.13,10.15]];
_fuel setDir 90;

// Dummy objects for hangar and flight deck
_types = ["B_Heli_Transport_01_F", "B_Heli_Attack_01_dynamicLoadout_F", "B_Heli_Light_01_dynamicLoadout_F", "B_Heli_Light_01_F", "B_T_UAV_03_dynamicLoadout_F","MELB_AH6M","MELB_MH6M","UK3CB_BAF_Apache_AH1_DynamicLoadoutUnlimited"];
{
	_helipad = "Land_HelipadEmpty_F" createVehicleLocal [0,0,0];
	_helipad enableSimulation false;
	_helipad attachTo [_ship, _x select 1];
	_helipad setDir 180; //warning : relative to attached object !
	_helipad setVariable ["GSRI_FREMM_heli_list", _types];
	_ship setVariable [_x select 0, _helipad];
} forEach [["GSRI_FREMM_hangar", [0,44,8.81]], ["GSRI_FREMM_deck", [0.08,75,8.76]]];

// Heli actions
private _actionList = [];
{
	if(isClass (configFile >> "CfgVehicles" >> _x)) then {
		private _display = [_x] call GSRI_fnc_heliMinifyName;
		private _modifier = {
			// params ["_target", "_player", "_args", "_actionData"];
			params ["", "", "_args", "_actionData"];
			_args params ["_hangar", "_newType"];
			private _heli = [_hangar] call GSRI_fnc_heliRetrieveCurrent;
			private _displayName = [localize "STR_GSRI_FREMM_heliReplace", localize "STR_GSRI_FREMM_heliGet"] select (isNull _heli);
			_actionData set [1, format [_displayName, [_heli] call GSRI_fnc_heliMinifyName, [_newType] call GSRI_fnc_heliMinifyName]];
		};
		private _condition = {
			// params["_target", "_player", "_args"];
			params["", "", "_args"];
			_args params ["_hangar", "_newType"];
			private _heli = [_hangar] call GSRI_fnc_heliRetrieveCurrent;
			(([_newType] call GSRI_fnc_heliMinifyName) != ([_heli] call GSRI_fnc_heliMinifyName))
		};
		_actionList pushBack ([format["action%1", _display],_display,"",GSRI_fnc_heliSpawn,_condition,{},[(_ship getVariable "GSRI_FREMM_hangar"), _x],"",2,[false, false, false, false, false], _modifier] call ace_interact_menu_fnc_createAction);
	};
} forEach _types;

// Hangar cleaning action
private _modifier = {
	// params ["_target", "_player", "_args", "_actionData"];
    params ["", "", "_args", "_actionData"];
	_args params ["_hangar"];
	private _heli = [_hangar] call GSRI_fnc_heliRetrieveCurrent;
    _actionData set [1, format [localize "STR_GSRI_FREMM_heliRemove", [_heli] call GSRI_fnc_heliMinifyName]];
};
private _condition = {
	// params ["_target", "_player", "_args"];
	params ["", "", "_args"];
	_args params ["_hangar"];
	!isNull ([_hangar] call GSRI_fnc_heliRetrieveCurrent)
};
_actionList pushBack (["actionClear","Supprimer","",GSRI_fnc_heliRemove,_condition,{},[(_ship getVariable "GSRI_FREMM_hangar")],"",2,[false, false, false, false, false], _modifier] call ace_interact_menu_fnc_createAction);

// FRIES mounting action
private _condition = {
	// params ["_target", "_player", "_args"];
	params ["", "", "_args"];
	_args params ["_hangar"];
	private _heli = [_hangar] call GSRI_fnc_heliRetrieveCurrent;
	(isNumber (configFile >> "CfgVehicles" >> typeOf _heli >> "ace_fastroping_enabled") && isNull (_heli getVariable ["ace_fastroping_FRIES", objNull]));
};
_actionList pushBack (["actionFRIES",localize "STR_GSRI_FREMM_heliEquipFRIES","",GSRI_fnc_heliEquipFRIES,_condition,{},[(_ship getVariable "GSRI_FREMM_hangar")]] call ace_interact_menu_fnc_createAction);

private _leshLoaded = isClass (configFile >> "CfgPatches" >> "rksla3_aircraft_tug");
if(_leshLoaded && isServer) then {
	// add RKSL airport tug to ship
	private _tug = createVehicle ["rksla3_aircraft_tug_blufor", [0,0,100], [], 0, "NONE"];
	_tug enableSimulation false;
	_tug allowDamage false;
	_tug animateSource ["option_cabin_hide_source", 0, true];
	_tug setDir getDir _ship;
	_tug setPosATL ASLToATL (_ship modelToWorldWorld [7.45,47.77,8.81]);
	_tug enableSimulation true;
	_tug allowDamage true;
	_ship setVariable ["GSRI_FREMM_tug", _tug, true];
} else {
	// Add placeholder actions
	// Place helicopter on rear deck
	// Will not be externalized
	private _condition = {
		// params["_target", "_player", "_args"];
		params["", "", "_args"];
		_args params ["_ship"];
		// Return true if there is a heli in hangar and if there is no heli on deck
		!(isNull ([(_ship getVariable "GSRI_FREMM_hangar")] call GSRI_fnc_heliRetrieveCurrent)) and (isNull ([(_ship getVariable "GSRI_FREMM_deck")] call GSRI_fnc_heliRetrieveCurrent))
	};
	private _statement = {
		// params["_target", "_player", "_args"];
		params["", "", "_args"];
		_args params ["_ship"];
		private _heli = [(_ship getVariable "GSRI_FREMM_hangar")] call GSRI_fnc_heliRetrieveCurrent;
		["HeliMoved", [getText (configFile >> "CfgVehicles" >> typeOf _heli >> "displayName")]] call BIS_fnc_showNotification;
		_heli setPosASL getPosASL (_ship getVariable "GSRI_FREMM_deck");
	};
	_actionList pushBack (["actionDeck",localize "STR_GSRI_FREMM_heliToDeck","",_statement,_condition,{},[_ship]] call ace_interact_menu_fnc_createAction);
	
	// Place helicopter in hangar
	// Will not be externalized
	private _condition = {
		// params["_target", "_player", "_args"];
		params["", "", "_args"];
		_args params ["_ship"];
		// Return true if there is no heli in hangar and if there is a heli on deck
		(isNull ([(_ship getVariable "GSRI_FREMM_hangar")] call GSRI_fnc_heliRetrieveCurrent)) and !(isNull ([(_ship getVariable "GSRI_FREMM_deck")] call GSRI_fnc_heliRetrieveCurrent))
	};
	private _statement = {
		// params["_target", "_player", "_args"];
		params["", "", "_args"];
		_args params ["_ship"];
		private _heli = [(_ship getVariable "GSRI_FREMM_deck")] call GSRI_fnc_heliRetrieveCurrent;
		["HeliMoved", [getText (configFile >> "CfgVehicles" >> typeOf _heli >> "displayName")]] call BIS_fnc_showNotification;
		_heli setPosASL getPosASL (_ship getVariable "GSRI_FREMM_hangar");
	};
	_actionList pushBack (["actionHangar",localize "STR_GSRI_FREMM_heliToHangar","",_statement,_condition,{},[_ship]] call ace_interact_menu_fnc_createAction);
};

// Adding actions
private _heliMain = ["actionHeliMain",localize "STR_GSRI_FREMM_heliMain","",{},{true},{},[],[0,0,-0.3]] call ace_interact_menu_fnc_createAction;
[_handle, 0, [], _heliMain] call ace_interact_menu_fnc_addActionToObject;
{
	[_handle, 0, ["actionHeliMain"], _x] call ace_interact_menu_fnc_addActionToObject;
} forEach _actionList;