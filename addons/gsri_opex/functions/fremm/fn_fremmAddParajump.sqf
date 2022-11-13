params["_ship"];

if(isServer) then {
	private _handle = "Land_Tablet_02_black_F" createVehicle getPos _ship;
	_handle attachTo [_ship, [1.15,9.83,8.97]];
	_handle setVectorDirAndUp [[0,0,-1],[0,1,0]];
	_ship setVariable ["GSRI_FREMM_parajump_handle", _handle, true];
};

if!(isDedicated) then {
	private _handle = _ship getVariable "GSRI_FREMM_parajump_handle";

	private _mainAction = ["actionParaMain",localize "STR_GSRI_FREMM_parajump","",{},{true}] call ace_interact_menu_fnc_createAction;
	private _initAction = ["actionParaInit",localize "STR_GSRI_FREMM_parajump_init","",GSRI_fnc_parajumpInit,{true}] call ace_interact_menu_fnc_createAction;
	private _addWaitingAction = ["actionParaAddWaiting",localize "STR_GSRI_FREMM_parajump_addWaiting","",GSRI_fnc_parajumpAddWaiting,{true}] call ace_interact_menu_fnc_createAction;
	private _removeWaitingAction = ["actionParaRemoveWaiting",localize "STR_GSRI_FREMM_parajump_removeWaiting","",GSRI_fnc_parajumpRemoveWaiting,{true}] call ace_interact_menu_fnc_createAction;
	private _launchPlaneAction = ["actionParaLaunchPlane",localize "STR_GSRI_FREMM_parajump_launchPlane","",GSRI_fnc_parajumpLaunchPlane,{true}] call ace_interact_menu_fnc_createAction;

	[_handle, 0, [], _mainAction] call ace_interact_menu_fnc_addActionToObject;
	[_handle, 0, ["actionParaMain"], _initAction] call ace_interact_menu_fnc_addActionToObject;
	[_handle, 0, ["actionParaMain"], _addWaitingAction] call ace_interact_menu_fnc_addActionToObject;
	[_handle, 0, ["actionParaMain"], _removeWaitingAction] call ace_interact_menu_fnc_addActionToObject;
	[_handle, 0, ["actionParaMain"], _launchPlaneAction] call ace_interact_menu_fnc_addActionToObject;
};
