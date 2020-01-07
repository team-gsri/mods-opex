// Add Preslots to grey lockers in preparation area
// by [GSRI] Cheitan

// No task serverside
if(isDedicated) exitWith {};

params["_navire"];

_pos = [[2.33301,17.878,8.7],[2.33301,16.414,8.7]];
_actionSoldier = ["actionSoldier","Fusilier","",{call GSRI_fnc_getSoldier},{true}] call ace_interact_menu_fnc_createAction;
_actionGrenadier = ["actionGrenadier","Grenadier","",{call GSRI_fnc_getGrenadier},{true}] call ace_interact_menu_fnc_createAction;
_actionGunner = ["actionGunner","Mitrailleur","",{call GSRI_fnc_getGunner},{true}] call ace_interact_menu_fnc_createAction;
_actionMedic = ["actionMedic","Médic","",{call GSRI_fnc_getMedic},{true}] call ace_interact_menu_fnc_createAction;
_actionDiver = ["actionDiver","Plongeur","",{call GSRI_fnc_getDiver},{true}] call ace_interact_menu_fnc_createAction;
{
	_handle = "Land_Battery_F" createVehicleLocal [0,0,0];
	_handle enableSimulation false;
	_handle attachTo [_navire, _x];
	{
		[_handle, 0, ["ACE_MainActions"], _x] call ace_interact_menu_fnc_addActionToObject;
	} forEach [_actionSoldier,_actionGrenadier,_actionGunner,_actionMedic,_actionDiver];
} forEach _pos;
