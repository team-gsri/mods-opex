params["_sub", "_handle"];

private _rootAction = ["submarineControl",localize "STR_GSRI_FREMM_submarine_control","",{},{true}] call ace_interact_menu_fnc_createAction;
[_handle, 0, [], _rootAction] call ace_interact_menu_fnc_addActionToObject;

// Sub's teleporter
private _statement = {
	params["_target", "_player", "_params"];
	if!("ItemMap" in assignedItems player) then { player setVariable ["GSRI_FREMM_submarine_hadMap", false]; player linkItem "ItemMap" };
	openMap true;
	player setVariable ["GSRI_FREMM_engine", (_params select 0) getVariable "GSRI_FREMM_engine"];
	["SubmarineInfo"] call BIS_fnc_showNotification;
};
private _condition = {
	params["_target", "_player", "_params"];
	!((_params select 0) getVariable ["GSRI_FREMM_subIsStill", false])
};
private _actionSelectPos = ["submarineSelectPosition",localize "STR_GSRI_FREMM_submarine_selectPos","",_statement,_condition,{},[_sub]] call ace_interact_menu_fnc_createAction;
[_handle, 0, ["submarineControl"], _actionSelectPos] call ace_interact_menu_fnc_addActionToObject;

// Make the sub still
private _modifier = {
	// params ["_target", "_player", "_args", "_actionData"];
	params ["", "", "_args", "_actionData"];
	_args params ["_sub"];
	private _OnOff = _sub getVariable ["GSRI_FREMM_subIsStill", false];
	_actionData set [1, localize format ["STR_GSRI_FREMM_submarine_%1",["doStop", "doMove"] select _OnOff]];
	_actionData set [6, [_sub, !(_OnOff)]];
};
private _actionStop = ["submarineStop","","",{params["","","_args"]; _args call GSRI_fnc_subStop},{true},{},[_sub, false],"",2,[false, false, false, false, false], _modifier] call ace_interact_menu_fnc_createAction;
[_handle, 0, ["submarineControl"], _actionStop] call ace_interact_menu_fnc_addActionToObject;