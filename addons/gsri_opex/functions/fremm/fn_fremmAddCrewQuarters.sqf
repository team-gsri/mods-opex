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
	[_roomA, "A"] call GSRI_fnc_crewAddProps;

	private _roomB = "SCMS_Destroyer_Interior" createVehicle [0,0,0];
	private _pos = _roomA getRelPos [15, 270];
	_roomB setPosASL [_pos select 0, _pos select 1, 10];
	_roomB setVectorUp [0,0,1];
	_roomB setDir (getDir _ship + 90);
	_roomB call BIS_fnc_Destroyer01PosUpdate;
	_ship setVariable ["GSRI_FREMM_CrewQuartersRoomB", _roomB, true];
	[_roomA, "B"] call GSRI_fnc_crewAddProps;

	// Adding modded doors to the crew quarters
	private _quartersDoorsA = [
		["Land_Battery_F", "Door1", [7.42,-1.12012,0.51501], [7.12843,-1.12391,-0.928343],0,true],
		["Land_Battery_F", "Door2", [-5.42,-0.3727,0.620061], [-4.78034,-0.423262,-0.897619]]
	];
	_roomA setVariable ["GSRI_FREMM_moddedDoors", _quartersDoorsA, true];
	private _quartersDoorsB = [
		["Land_Battery_F", "Door1", [7.42,-1.12012,0.51501], [7.12843,-1.12391,-0.928343]],
		["Land_Battery_F", "Door2", [-5.42,-0.3727,0.620061], [-4.78034,-0.423262,-0.897619],0,true]
	];
	_roomB setVariable ["GSRI_FREMM_moddedDoors", _quartersDoorsB, true];
};

if!(isDedicated) then {
	//clientCanLoad set when executing this, so rooms should already exists
	// A corridor is a link between two doors
	//[[SideAObject, SideADoorName],[SideBObject, SideBDoorName]]
	private _corridors = [
		[[_ship, "DoorQuarters"],[_ship getVariable "GSRI_FREMM_crewQuartersRoomA", "Door1"]],
		[[_ship, "DoorBays"],[_ship getVariable "GSRI_FREMM_crewQuartersRoomB", "Door2"]],
		[[_ship getVariable "GSRI_FREMM_crewQuartersRoomA", "Door2"],[_ship getVariable "GSRI_FREMM_crewQuartersRoomB", "Door1"]]
	];
	{
		// Connect doors
		[_x] call GSRI_fnc_doorConnect;
	} forEach _corridors;

	// When crew quarters are loaded, any respawn on the ship should be redirected to rooms
	player addEventHandler ["Respawn", {
		//params["_unit", "_corpse"];
		params["_unit"];
		_unit setVariable ["GSRI_FREMM_respawnTimestamp", time];
	}];
	private _trigger = createTrigger ["EmptyDetector", _ship, false];
	_trigger setPosWorld (_ship modelToWorldWorld [1.31018,-1.11719,7.27226]);
	_trigger setTriggerArea [2, 2, 0, false, 2];
	_trigger setTriggerActivation ["WEST", "PRESENT", true];
	_trigger setTriggerStatements ["this","call GSRI_fnc_crewMoveToCabin", ""];
};