// Add locker features to red lockers in preparation area
// by [GSRI] Cheitan

// No task serverside
if(isDedicated) exitWith {};

params["_ship"];
private _start = [-2.42944,15.6,8.7];

private _i = 0;
for [{_i = 0}, {_i < 9}, {_i = _i+1}] do {
	private _handle = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0];
	_handle setObjectTexture [0, ""];
	_handle enableSimulation false;
	_handle attachTo [_ship, (_start vectorAdd [0,(0.61*_i),0])];
	[_handle] call GSRI_fnc_setAsLocker;
};

// grey lockers
//_pos = [[2.33301,17.878,8.7],[2.33301,16.414,8.7]];