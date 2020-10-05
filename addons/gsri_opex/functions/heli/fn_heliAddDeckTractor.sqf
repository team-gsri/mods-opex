params["_ship"];
private _leshLoaded = isClass (configFile >> "CfgPatches" >> "rksla3_aircraft_tug");

// Aircraft tug is spawned by the server before clientCanLoad, if the tow mod is available
if(_leshLoaded && isServer) then {
	private _tug = createVehicle ["rksla3_aircraft_tug_blufor", ASLToATL (_ship modelToWorldWorld [7.45,47.77,8.81]), [], 0, "NONE"];
	_tug setDir getDir _ship;
	_tug animateSource ["option_cabin_hide_source", 0, true];
	_ship setVariable ["GSRI_FREMM_tug", _tug, true];
};

// Placeholder actions are added if the tow mod is not activated, but clientside only
// Executed at the end of the heli component spawning, so all other actions are already created
if!(_leshLoaded || isServer) then {
	private _conditionToDeck = {
		// Condition is valied if there is a heli in hangar and deck is free
		// params["_target", "_player", "_args"];
		params["", "", "_args"];
		_args params ["_ship"];
		!(isNull ([(_ship getVariable "GSRI_FREMM_hangar")] call GSRI_fnc_heliRetrieveCurrent)) and (isNull ([(_ship getVariable "GSRI_FREMM_deck")] call GSRI_fnc_heliRetrieveCurrent))
	};
	private _statementToDeck = {
		// params["_target", "_player", "_args"];
		params["", "", "_args"];
		_args params ["_ship"];
		private _heli = [(_ship getVariable "GSRI_FREMM_hangar")] call GSRI_fnc_heliRetrieveCurrent;
		["HeliMoved", [getText (configFile >> "CfgVehicles" >> typeOf _heli >> "displayName")]] call BIS_fnc_showNotification;
		_heli setPosASL getPosASL (_ship getVariable "GSRI_FREMM_deck");
	};
	private _actionToDeck = ["actionToDeck",localize "STR_GSRI_FREMM_heliToDeck","",_statementToDeck,_conditionToDeck,{},[_ship]] call ace_interact_menu_fnc_createAction;

	private _conditionToHangar = {
		// Condition is valid if hangar is free and if there is a heli on deck
		// params["_target", "_player", "_args"];
		params["", "", "_args"];
		_args params ["_ship"];
		(isNull ([(_ship getVariable "GSRI_FREMM_hangar")] call GSRI_fnc_heliRetrieveCurrent)) and !(isNull ([(_ship getVariable "GSRI_FREMM_deck")] call GSRI_fnc_heliRetrieveCurrent))
	};
	private _statementToHangar = {
		// params["_target", "_player", "_args"];
		params["", "", "_args"];
		_args params ["_ship"];
		private _heli = [(_ship getVariable "GSRI_FREMM_deck")] call GSRI_fnc_heliRetrieveCurrent;
		["HeliMoved", [getText (configFile >> "CfgVehicles" >> typeOf _heli >> "displayName")]] call BIS_fnc_showNotification;
		_heli setPosASL getPosASL (_ship getVariable "GSRI_FREMM_hangar");
	};
	private _actionToHangar = ["actionToHangar",localize "STR_GSRI_FREMM_heliToHangar","",_statementToHangar,_conditionToHangar,{},[_ship]] call ace_interact_menu_fnc_createAction;

	// actionHeliMain should already exist
	private _handle = [_ship, "Display_11"] call GSRI_fnc_screenGetById;
	{ [_handle, 0, ["actionHeliMain"], _x] call ace_interact_menu_fnc_addActionToObject } forEach [_actionToDeck, _actionToHangar];
};