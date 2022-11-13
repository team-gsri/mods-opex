params["_ship"];

// Server part : spawning objects
if(isServer) then {
	// Base objects (corridors, rooms, etc)
	private _beds = [];
	private _data = [
		["SCMS_Couloir",0,[-0.244751,-12.4375,12.2001]],
		["SCMS_Couloir",270,[4.61157,-10.814,12.2002]],
		["SCMS_Habs_Rplc",90,[-6.94519,-13.1768,12.2]],
		["SCMS_Briefroom",90,[-9.84521,-15.6782,12.2]],
		["SCMS_Habs_Rplc2",0,[-1.87805,-14.4517,12.2]],
		["SCMS_Habs_Rplc2",90,[2.56079,-15.644,12.2]],
		["SCMS_Habs_Rplc2",0,[1.35242,-14.4634,12.2]],
		["Land_ConcreteWall_03_m_pole_F",90,[-3.60046,-10.8433,12]],
		["Land_ConcreteWall_03_m_pole_F",0,[-3.56958,-13.979,12]],
		["Land_ConcreteWall_03_m_pole_F",315,[3.04077,-10.8862,12]],
		["Land_ConcreteWall_03_m_pole_F",45,[3.04224,-13.9961,12]],
		["SCMS_bedroom",0,[-1.83228,-10.834,12.65]],
		["SCMS_bedroom",0,[1.41309,-10.8237,12.65]],
		["SCMS_Couloir",0,[-3.55017,-2.72217,12.2003]],
		["SCMS_Couloir",270,[-5.17163,-7.51221,12.2004]],
		["SCMS_Briefroom",180,[7.83545,-1.12402,12.2]],
		["SCMS_Habs_Rplc2",270,[-3.14954,-5.91699,12.2]],
		["SCMS_Habs_Rplc2",0,[-8.43298,-4.73438,12.2]],
		["SCMS_Habs_Rplc2",90,[2.56531,-5.96533,12.2]],
		["SCMS_Habs_Rplc2",0,[1.27307,-4.74072,12.2]],
		["SCMS_Habs_Rplc2",0,[-1.96252,-4.74365,12.2]],
		["SCMS_Habs_Rplc2",270,[-3.15649,-9.14697,12.2]],
		["SCMS_Habs_Rplc2",90,[2.56055,-9.19629,12.2]],
		["Land_ConcreteWall_03_m_pole_F",45,[-6.74109,-4.24854,12]],
		["Land_ConcreteWall_03_m_pole_F",315,[-6.72241,-1.14746,12]],
		["Land_ConcreteWall_03_m_pole_F",45,[-3.625,-1.14551,12]],
		["Land_ConcreteWall_03_m_pole_F",315,[-3.61023,-4.24609,12]],
		["SCMS_Cantine",270,[7.98486,-10.5352,12.65]],
		["SCMS_bedroom",0,[1.3374,-1.11133,12.65]],
		["SCMS_bedroom",0,[-8.44897,-1.11865,12.65]],
		["SCMS_bedroom",0,[-1.89404,-1.12207,12.65]],
		["SCMS_bedroom",270,[-6.78052,-5.854,12.65]],
		["SCMS_bedroom",270,[-6.78235,-9.08154,12.65]]
	];
	{
		_x params ["_classname", "_relativeDirection", "_relativePosition"];
		private _item = createVehicle[_classname, getPos _ship];
		_item setVectorUp [0,0,1];
		_item attachTo [_ship, _relativePosition];
		_item setDir _relativeDirection;
		// Additionnal virtual beds
		if(_classname == "SCMS_bedroom") then {
			private _bed = createVehicle["SCMS_Beds", getPos _ship];
			_bed setVectorUp [0,0,1];
			_bed attachTo [_item, [-0.05,0.05,-0.05]];
			_beds pushBack _bed;
		};
		// Additionnal kitchen props
		if (_classname == "SCMS_Cantine") then {
			private _kitchen = _item;
			private _chairs = [
				["SCMS_Chaise",0,[-4.10999,-1.41211,-1.70624]],
				["SCMS_Chaise",0,[-4.10229,-0.782227,-1.70624]],
				["SCMS_Chaise",0,[-4.09241,-0.090332,-1.70624]],
				["SCMS_Chaise",0,[0.566162,-0.631836,-1.70624]],
				["SCMS_Chaise",0,[-1.77991,-1.24512,-1.70624]],
				["SCMS_Chaise",0,[-1.77222,-0.615234,-1.70624]],
				["SCMS_Chaise",0,[-1.76233,0.0766602,-1.70624]],
				["SCMS_Chaise",0,[0.558472,-1.26172,-1.70624]],
				["SCMS_Chaise",180,[-0.766357,-0.00683594,-1.70624]],
				["SCMS_Chaise",0,[0.57605,0.0600586,-1.70624]],
				["SCMS_Chaise",180,[1.58154,0.0620117,-1.70624]],
				["SCMS_Chaise",180,[1.57373,-0.567871,-1.70624]],
				["SCMS_Chaise",180,[1.56396,-1.25977,-1.70624]],
				["SCMS_Chaise",180,[-0.77417,-0.636719,-1.70624]],
				["SCMS_Chaise",180,[-0.783936,-1.32861,-1.70624]],
				["SCMS_Chaise",180,[-3.0127,-0.0551758,-1.70624]],
				["SCMS_Chaise",180,[-3.02051,-0.685059,-1.70624]],
				["SCMS_Chaise",180,[-3.03027,-1.37695,-1.70624]]];
			{
				_x params ["_chairClass", "_chairDirection", "_chairPosition"];
				private _chair = createVehicle[_chairClass, getPos _kitchen];
				_chair setVectorUp [0,0,1];
				_chair setDir (getDir _kitchen + _chairDirection);
				_chair setPosWorld (_kitchen modelToWorldWorld _chairPosition);
			} forEach _chairs;
		}
	} forEach _data;
	_ship setVariable ["gsri_opex_availableBeds", _beds, true];

	// Adding modded doors to the crew quarters
	private _quartersDoorsA = [
		["Sign_Sphere10cm_F", "Door1", [7.42,-1.12012,0.51501], [7.12843,-1.12391,-0.928343],0,true],
		["Sign_Sphere10cm_F", "Door2", [-5.42,-0.3727,0.620061], [-4.78034,-0.423262,-0.897619]]
	];
	_roomA setVariable ["GSRI_FREMM_moddedDoors", _quartersDoorsA, true];
	private _quartersDoorsB = [
		["Sign_Sphere10cm_F", "Door1", [7.42,-1.12012,0.51501], [7.12843,-1.12391,-0.928343]],
		["Sign_Sphere10cm_F", "Door2", [-5.42,-0.3727,0.620061], [-4.78034,-0.423262,-0.897619],0,true]
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
