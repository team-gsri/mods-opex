params["_ship"];

// Submarine and teleport handles spawn
if(isServer) then {
	// Spawn and place sub
	private _sub = "Submarine_01_F" createVehicle [0,0,0];
	_sub enableSimulation false;
	_ship setVariable ["GSRI_FREMM_submarine", _sub, true];
	_sub setPosASL [(getPosASL _ship select 0) + 100, (getPosASL _ship select 1) + 100, (getPosASL _ship select 2)-10];
	_sub setDir getDir _ship;
	_sub setVariable ["GSRI_FREMM_shipIndex", _ship getVariable "GSRI_FREMM_shipIndex"];

	// Add map marker
	private _mk = createMarker [format["marker_submarine_%1", _sub getVariable "GSRI_FREMM_shipIndex"], _sub];
	_mk setMarkerType "flag_France";
	_mk setMarkerText "S-625 Devigny";

	// CRRC handle and spawner
	private _crrcSpawner = "Land_HelipadEmpty_F" createVehicle [0,0,0];
	_crrcSpawner attachTo [_sub, [0,17.4,5]];
	_sub setVariable ["GSRI_FREMM_sub_crrcSpawner", _crrcSpawner, true];

	private _crrcHandle = "Land_Battery_F" createVehicle [0,0,0];
	_crrcHandle attachTo [_sub, [0,12,3.74]];
	_sub setVariable ["GSRI_FREMM_sub_crrcHandle", _crrcHandle, true];
	_crrcHandle setVariable ["GSRI_FREMM_associatedSpawner", _crrcSpawner];

	private _subDoors = [["Land_SewerCover_02_F", "Trapdoor", [0,-2.96,3.2], [0,-2.96,3.1]]];
	_sub setVariable ["GSRI_FREMM_moddedDoors", _subDoors, true];
	[_sub] call GSRI_fnc_subAddInterior;
};

// Adding position selection eventHandler
addMissionEventHandler ["MapSingleClick", GSRI_fnc_subSelectPos];

// Adding "abort selection" eventHandler
addMissionEventHandler ["Map", {
	// params ["_opened", "_forced"];
	params ["_opened"];
	// Detect if map is closed but do not check if the event is linked to this module
	if!(_opened) then {
		player setVariable ["GSRI_FREMM_submarine_token", false];
		if!(player getVariable ["GSRI_FREMM_submarine_hadMap",true]) then { player unlinkItem "ItemMap"; player setVariable ["GSRI_FREMM_submarine_hadMap", nil] };
	};
}];

// Clientside jobs
if!(isDedicated) then {
	// Create handle for sub movement
	private _com = "Land_Battery_F" createVehicleLocal [0,0,0];
	_com enableSimulation false;
	_com attachTo [_ship, [-2.94995,-34.0001,20.6]];

	// Add actions with map selection
	private _statement = {
		if!("ItemMap" in assignedItems player) then { player setVariable ["GSRI_FREMM_submarine_hadMap", false]; player linkItem "ItemMap" };
		// Open the map
		openMap true;

		// Set the "submarine token" for the eventHandler to fire correctly
		player setVariable ["GSRI_FREMM_submarine_token", true];

		// Help notification
		["SubmarineInfo"] call BIS_fnc_showNotification;
	};
	private _actionSelectPos = ["submarineSelectPosition",localize "STR_GSRI_FREMM_submarine_selectPos","",_statement,{true}] call ace_interact_menu_fnc_createAction;
	[_com, 0, [], _actionSelectPos] call ace_interact_menu_fnc_addActionToObject;
	
	// Add CRRC deploy/retrieve actions
	private _handle = (_ship getVariable "GSRI_FREMM_submarine") getVariable "GSRI_FREMM_sub_crrcHandle";
	private _crrcActions = [
		["actionCRRC","CRRC",{},[]],
		["actionCRRCSpawn",localize "STR_GSRI_FREMM_submarine_deployCRRC",GSRI_fnc_subDeployCRRC,["actionCRRC"]],
		["actionCRRCRetrieve",localize "STR_GSRI_FREMM_submarine_retrieveCRRC",GSRI_fnc_subRetrieveCRRC,["actionCRRC"]]
	];
	{
		private _action = [_x select 0,_x select 1,"",_x select 2,{true}] call ace_interact_menu_fnc_createAction;
		[_handle, 0, _x select 3, _action] call ace_interact_menu_fnc_addActionToObject;
	} forEach _crrcActions;
};