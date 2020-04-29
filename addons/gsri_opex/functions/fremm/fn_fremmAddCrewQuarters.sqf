params["_ship"];

// Server part : spawning objects
if(isServer) then {
	private _shipIndex = _ship getVariable "GSRI_FREMM_shipIndex";
	private _roomA = "SCMS_Destroyer_Interior" createVehicle [0,0,0];
	_roomA setPosASL [25, (_shipIndex*50), 10];
	_roomA setVectorUp [0,0,1];
	_roomA setDir (getDir _ship + 90);
	_roomA call BIS_fnc_Destroyer01PosUpdate;
	_ship setVariable ["GSRI_FREMM_CrewQuartersRoomA", _roomA, true];

	private _roomB = "SCMS_Destroyer_Interior" createVehicle [0,0,0];
	private _pos = _roomA getRelPos [15, 270];
	_roomB setPosASL [_pos select 0, _pos select 1, 10];
	_roomB setVectorUp [0,0,1];
	_roomB setDir (getDir _ship + 90);
	_roomB call BIS_fnc_Destroyer01PosUpdate;
	_ship setVariable ["GSRI_FREMM_CrewQuartersRoomB", _roomB, true];

	// Adding modded doors to the crew quarters
	// Room A and B are the same object, for now they should share handlePos and manPos of each doors
	private _quartersDoors = [
		["Land_Battery_F", "Door1", [7.35815,-1.12012,0.51501], [7.12843,-1.12391,-0.928343]],
		["Land_Battery_F", "Door2", [-5.38441,-0.3727,0.620061], [-4.78034,-0.423262,-0.897619]]
	];
	_roomA setVariable ["GSRI_FREMM_moddedDoors", _quartersDoors, true];
	_roomB setVariable ["GSRI_FREMM_moddedDoors", _quartersDoors, true];
};

if!(isDedicated) then {
	//clientCanLoad set when executing this, so rooms should already exists

	// Generic door crossing ACE action
	private _statement = {
		params["_target", "_player"];
		_player setPosWorld (_target getVariable "GSRI_FREMM_goTo");
	};
	private _doorCross = ["actionCrossDoor",localize "STR_GSRI_FREMM_crewCrossDoor","",_statement,{true}] call ace_interact_menu_fnc_createAction;

	// A corridor is a link between two doors
	//[name, doorSide1, doorSide2]
	private _corridors = [
		["Ship_RoomA","DoorQuarters", "Door1"],
		["Ship_RoomB","DoorBays","Door2"],
		["RoomA_RoomB", "Door2", "Door1"]
	];
	{
		// Get sides (objects) of the corridor
		private _sides = [_ship, _x select 0] call GSRI_fnc_crewGetDoorSides;
		// Connect doors
		[_sides, _x select 1, _x select 2, _doorCross] call GSRI_fnc_crewConnectDoors;
	} forEach _corridors;
};