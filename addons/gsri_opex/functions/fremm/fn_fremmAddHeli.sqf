params["_ship"];

// Server-side spawning of required helipads and useful data
// This executed BEFORE clientCanLoad
if(isServer) then {
	private _types = getArray (configFile >> "GSRI_FREMM_Templates" >> (_ship getVariable "GSRI_FREMM_selectTemplate") >> "AvailableHelis" >> "list");
	{
		private _helipad = "Land_HelipadEmpty_F" createVehicle [0,0,0];
		_helipad attachTo [_ship, _x select 1];
		_helipad setDir 180;
		_helipad setVariable ["GSRI_FREMM_heli_list", _types, true];
		_helipad setVariable ["GSRI_FREMM_associatedShip", _ship, true];
		_ship setVariable [_x select 0, _helipad];
	} forEach [["GSRI_FREMM_hangar", [0,44,8.81]], ["GSRI_FREMM_deck", [0.08,75,8.76]]];
};

// Clientside-only : basically ACE actions, AFTER clientCanLoad
if!(isDedicated) then {
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
			_actionList pushBack ([format["action_%1", _display],_display,"",GSRI_fnc_heliSpawn,_condition,{},[(_ship getVariable "GSRI_FREMM_hangar"), _x],"",2,[false, false, false, false, false], _modifier] call ace_interact_menu_fnc_createAction);
		};
	} forEach (_ship getVariable "GSRI_FREMM_hangar" getVariable "GSRI_FREMM_heli_list"); //this list retrieval looks a bit weird, but works anyway.

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

	// Finally adding all generated actions
	private _handle = [_ship, "Display_11"] call GSRI_fnc_screenGetById;
	private _heliMain = ["actionHeliMain",localize "STR_GSRI_FREMM_heliMain","",{},{true},{},[],[0,0,-0.3]] call ace_interact_menu_fnc_createAction;
	[_handle, 0, [], _heliMain] call ace_interact_menu_fnc_addActionToObject;
	{
		[_handle, 0, ["actionHeliMain"], _x] call ace_interact_menu_fnc_addActionToObject;
	} forEach _actionList;
};

// Useful complementary features
[_ship] call GSRI_fnc_heliAddFuelPump;
[_ship] call GSRI_fnc_heliAddDeckTractor;
[_ship] call GSRI_fnc_heliAddFRIES;