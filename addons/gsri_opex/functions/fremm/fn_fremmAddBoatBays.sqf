// Adding lateral boat bays on Liberty-class ships
// by [-GSRI-] Cheitan

params["_ship"];

// Bays are created serverside to avoid desync
if(isServer) then {
	{
		private _bay = createVehicle ["Land_Destroyer_01_Boat_Rack_01_F", [0,0,0], [], 0, "NONE"];
		_bay attachTo [_ship, _x select 1];
		_bay setDir 180;
		[_bay] remoteExecCall ["BIS_fnc_BoatRack01Init", 0, true];

		private _door = "SCMS_HangarDoor" createVehicle [0,0,0];
		_door setPosWorld (_ship modelToWorldWorld (_x select 3));
		_door setDir (getDir _ship + (_x select 4));

		private _com = "Land_Tablet_02_black_F" createVehicle [0,0,0];
		_com attachTo [_ship, (_x select 2)];
		_com setVectorDirAndUp [[0,0,-1],[0,-1,0]];

		_com setVariable ["GSRI_FREMM_associatedBay", _bay, true];
		_bay setVariable ["GSRI_FREMM_associatedCom", _com, true];
		_com setVariable ["GSRI_FREMM_associatedDoor", _door, true];
		_door setVariable ["GSRI_FREMM_associatedCom", _com, true];
		_ship setVariable [(_x select 0), _bay, true];
	} forEach [
		["GSRI_FREMM_Starboard_bay",[-11.5,14.43,6.76],[-4.4,18.29,8.9],[-14.73,14.25,9.96], 178.75],
		["GSRI_FREMM_Portboard_bay",[11.5,14.43,6.76],[4.4,18.29,8.9],[14.73,14.25,9.96], 1.23]
	];
};

if(isDedicated) exitWith {};

// Main action
private _bayRoot = ["bayRoot",localize "STR_GSRI_FREMM_bayRoot","",{},{true}] call ace_interact_menu_fnc_createAction;
private _actionSpawnInBay = ["actionSpawnInBay",localize "STR_GSRI_FREMM_spawnInBay","",{},{true}] call ace_interact_menu_fnc_createAction;

// All boats and liveries
private _boatActions = [];
{
	_x params ["_classname", "_name", "_liveries"];
	private _boatMain = [format ["action_%1", _classname],_name,"",{_this spawn GSRI_fnc_bayReplace},{true},{},[_classname]] call ace_interact_menu_fnc_createAction; //this is the main action, will spawn the default textureSource
	private _boatLiveriesActions = [];
	{
		_boatLiveriesActions pushBack ( [format ["action_%1_%2", _classname, _x],_x,"",{_this spawn GSRI_fnc_bayReplace},{true},{},[_classname, _x]] call ace_interact_menu_fnc_createAction ); //this is a livery action, will spawn the given textureSource
	} forEach _liveries;
	_boatActions pushBack [_boatMain, _boatLiveriesActions];
} forEach ([_ship getVariable "GSRI_FREMM_selectTemplate"] call GSRI_fnc_bayParseList);

// Generic actions (not boats)
private _emptyBay = ["action_empty",localize "STR_GSRI_FREMM_emptyBay","",{_this spawn GSRI_fnc_bayReplace},{true},{},[""]] call ace_interact_menu_fnc_createAction;
private _doorControl = ["doorControl",localize "STR_GSRI_FREMM_bayDoorControl","",{_this spawn GSRI_fnc_bayDoorControl},{true}] call ace_interact_menu_fnc_createAction;

// Add all actions
{
	private _com = (_ship getVariable _x getVariable "GSRI_FREMM_associatedCom");
	[_com, 0, [], _bayRoot] call ace_interact_menu_fnc_addActionToObject;
	[_com, 0, ["bayRoot"], _actionSpawnInBay] call ace_interact_menu_fnc_addActionToObject;
	[_com, 0, ["bayRoot"], _doorControl] call ace_interact_menu_fnc_addActionToObject;
	[_com, 0, ["bayRoot","actionSpawnInBay"], _emptyBay] call ace_interact_menu_fnc_addActionToObject;
	{
		_x params ["_mainAction", "_liveriesActions"];
		[_com, 0, ["bayRoot","actionSpawnInBay"], _mainAction] call ace_interact_menu_fnc_addActionToObject;
		{
			[_com, 0, ["bayRoot","actionSpawnInBay",(_mainAction select 0)], _x] call ace_interact_menu_fnc_addActionToObject;
		} forEach _liveriesActions;
	} forEach _boatActions;
} forEach ["GSRI_FREMM_Starboard_bay","GSRI_FREMM_Portboard_bay"];