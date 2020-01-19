// Add Virtual Arsenal to red lockers in preparation area
// Also add Presloting actions on grey lockers
// by [GSRI] Cheitan

// No task serverside
if(isDedicated) exitWith {};

params["_ship"];

// Arsenal lockers
_start = [-2.42944,15.6,8.7];
_actionArsenal = ["actionArsenal",localize "STR_GSRI_FREMM_openLocker","",{["Open",true] spawn bis_fnc_arsenal},{true}] call ace_interact_menu_fnc_createAction;
for [{_i = 0}, {_i < 9}, {_i = _i+1}] do {
	_handle = "Land_Battery_F" createVehicleLocal [0,0,0];
	_handle enableSimulation false;
	_handle attachTo [_ship, (_start vectorAdd [0,(0.61*_i),0])];
	[_handle, 0, [], _actionArsenal] call ace_interact_menu_fnc_addActionToObject;
};

// Preslot lockers
_pos = [[2.33301,17.878,8.7],[2.33301,16.414,8.7]];
_actionGearAs = ["actionGearAs",localize "STR_GSRI_FREMM_openLocker","",{},{true}] call ace_interact_menu_fnc_createAction;
_actionRifleman = ["actionRifleman",localize "STR_GSRI_FREMM_gearAsRifleman","",{call GSRI_fnc_getSoldier},{true}] call ace_interact_menu_fnc_createAction;
_actionGunner = ["actionGunner",localize "STR_GSRI_FREMM_gearAsGunner","",{call GSRI_fnc_getGunner},{true}] call ace_interact_menu_fnc_createAction;
_actionGrenadier = ["actionGrenadier",localize "STR_GSRI_FREMM_gearAsGrenadier","",{call GSRI_fnc_getGrenadier},{true}] call ace_interact_menu_fnc_createAction;
_actionMedic = ["actionMedic",localize "STR_GSRI_FREMM_gearAsMedic","",{call GSRI_fnc_getMedic},{true}] call ace_interact_menu_fnc_createAction;
_actionDiver = ["actionDiver",localize "STR_GSRI_FREMM_gearAsDiver","",{call GSRI_fnc_getDiver},{true}] call ace_interact_menu_fnc_createAction;
{
	_handle = "Land_Battery_F" createVehicleLocal [0,0,0];
	_handle enableSimulation false;
	_handle attachTo [_ship, _x];
	{
		[_handle, 0, ["actionGearAs"], _x] call ace_interact_menu_fnc_addActionToObject;
	} forEach [_actionRifleman,_actionGrenadier,_actionGunner,_actionMedic,_actionDiver];
} forEach _pos;

// TODO merge arsenal and preslots on the same lockers