// Add Virtual Arsenal to red lockers in preparation area
// Also add Presloting actions on grey lockers
// by [GSRI] Cheitan

// No task serverside
if(isDedicated) exitWith {};

params["_ship"];

_start = [-2.42944,15.6,8.7];
_actionLockerMain = ["actionLockerMain",localize "STR_GSRI_FREMM_lockerMain","",{},{true}] call ace_interact_menu_fnc_createAction;
_actionArsenalMain = ["actionArsenalMain",localize "STR_GSRI_FREMM_arsenalMain","",{},{true}] call ace_interact_menu_fnc_createAction;
_actionPreslotMain = ["actionPreslotMain",localize "STR_GSRI_FREMM_preslotMain","",{},{true}] call ace_interact_menu_fnc_createAction;

_actionArsenalACE = ["actionArsenalACE",localize "STR_GSRI_FREMM_openArsenalACE","",{params ["_target", "_player", "_params"];[_target,_player,true] call ace_arsenal_fnc_openBox},{true}] call ace_interact_menu_fnc_createAction;
_actionArsenalBI = ["actionArsenalBI",localize "STR_GSRI_FREMM_openArsenalBI","",{["Open",true] spawn bis_fnc_arsenal},{true}] call ace_interact_menu_fnc_createAction;
_actionRifleman = ["actionRifleman",localize "STR_GSRI_FREMM_gearAsRifleman","",{call GSRI_fnc_getSoldier},{true}] call ace_interact_menu_fnc_createAction;
_actionGunner = ["actionGunner",localize "STR_GSRI_FREMM_gearAsGunner","",{call GSRI_fnc_getGunner},{true}] call ace_interact_menu_fnc_createAction;
_actionGrenadier = ["actionGrenadier",localize "STR_GSRI_FREMM_gearAsGrenadier","",{call GSRI_fnc_getGrenadier},{true}] call ace_interact_menu_fnc_createAction;
_actionMedic = ["actionMedic",localize "STR_GSRI_FREMM_gearAsMedic","",{call GSRI_fnc_getMedic},{true}] call ace_interact_menu_fnc_createAction;
_actionDiver = ["actionDiver",localize "STR_GSRI_FREMM_gearAsDiver","",{call GSRI_fnc_getDiver},{true}] call ace_interact_menu_fnc_createAction;

for [{_i = 0}, {_i < 9}, {_i = _i+1}] do {
	_handle = "Land_Battery_F" createVehicleLocal [0,0,0];
	_handle enableSimulation false;
	_handle attachTo [_ship, (_start vectorAdd [0,(0.61*_i),0])];
	[_handle, 0, [], _actionLockerMain] call ace_interact_menu_fnc_addActionToObject;
	[_handle, 0, ["actionLockerMain"], _actionPreslotMain] call ace_interact_menu_fnc_addActionToObject;
	{
		[_handle, 0, ["actionLockerMain","actionPreslotMain"], _x] call ace_interact_menu_fnc_addActionToObject;
	} forEach [_actionRifleman,_actionGrenadier,_actionGunner,_actionMedic,_actionDiver];
	[_handle, 0, ["actionLockerMain"], _actionArsenalMain] call ace_interact_menu_fnc_addActionToObject;
	{
		[_handle, 0, ["actionLockerMain","actionArsenalMain"], _x] call ace_interact_menu_fnc_addActionToObject;
	} forEach [_actionArsenalBI,_actionArsenalACE];
};

// grey lockers
//_pos = [[2.33301,17.878,8.7],[2.33301,16.414,8.7]];