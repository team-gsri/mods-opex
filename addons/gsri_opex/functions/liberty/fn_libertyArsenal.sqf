// Add Virtual Arsenal to red lockers in preparation area
// by [GSRI] Cheitan

// No task serverside
if(isDedicated) exitWith {};

params["_navire"];

_start = [-2.42944,15.6,8.7];
_actionArsenal = ["actionArsenal","Ouvrir le vestiaire","",{["Open",true] spawn bis_fnc_arsenal;},{true}] call ace_interact_menu_fnc_createAction;
for [{_i = 0}, {_i < 9}, {_i = _i+1}] do {
	_handle = "Land_Battery_F" createVehicleLocal [0,0,0];
	_handle enableSimulation false;
	_handle attachTo [_navire, (_start vectorAdd [0,(0.61*_i),0])];
	[_handle, 0, [], _actionArsenal] call ace_interact_menu_fnc_addActionToObject;
};