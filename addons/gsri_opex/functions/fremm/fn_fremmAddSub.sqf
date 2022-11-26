params["_ship"];

// Submarine and teleport handles spawn
if(isServer) then {
	// Engine is the SDV which serve as a moving target object for the submarine
	private _engine = createVehicle ["B_SDV_01_F", (getPosWorld _ship vectorAdd [100,100,0])];
	createVehicleCrew _engine;
	_engine setDir (getDir _ship + 180);
	_engine allowDamage false;
	driver _engine allowDamage false;
	driver _engine disableAI "ALL";

	// Sub is the submarine's skin and model, and also (for convenience) the attaching reference of action handles and stuff like that
	private _sub = "Submarine_01_F" createVehicle getPosWorld _engine;
	_sub attachTo [_engine, [0,-15,-3.5]];
	_sub allowDamage false;
	_sub enableSimulationGlobal false; //sub simul is always off, whereas engine simul varies following commander's choice to move the sub or make it still.
	_sub setDir 180;

	// A few needed variables for action functions
	_ship setVariable ["GSRI_FREMM_submarine", _sub, true];
	_sub setVariable ["GSRI_FREMM_shipIndex", _ship getVariable "GSRI_FREMM_shipIndex"];
	_sub setVariable ["GSRI_FREMM_engine", _engine];
	_engine setVariable ["GSRI_FREMM_sub", _sub];

	// Add map marker
	[
		west,
		[format["taskSubmarine%1", _ship getVariable "GSRI_FREMM_shipIndex"], format["taskDestroyer%1_root", _ship getVariable "GSRI_FREMM_shipIndex"]],
		["S-625 Devigny", "S-625 Devigny", ""],
		[_engine, true],
		"CREATED", -1, false, "boat"
	] call BIS_fnc_taskCreate;

	// CRRC handle and spawner
	private _crrcSpawner = "Land_HelipadEmpty_F" createVehicle [0,0,0];
	_crrcSpawner attachTo [_sub, [0,17.4,5]];
	_sub setVariable ["GSRI_FREMM_sub_crrcSpawner", _crrcSpawner, true];

	private _crrcHandle = "Sign_Sphere10cm_F" createVehicle [0,0,0];
	_crrcHandle setObjectTexture [0, ""];
	_crrcHandle attachTo [_sub, [0,12,3.74]];
	_sub setVariable ["GSRI_FREMM_sub_crrcHandle", _crrcHandle, true];
	_crrcHandle setVariable ["GSRI_FREMM_associatedSpawner", _crrcSpawner];

	private _subDoors = [["Land_SewerCover_02_F", "Trapdoor", [0,-2.96,3.2], [0,-2.96,3.1]]];
	//_sub setVariable ["GSRI_FREMM_moddedDoors", _subDoors, true];
	[_sub] call GSRI_fnc_subAddInterior;
	[_sub, true] call GSRI_fnc_subStop;
};

// Adding position selection eventHandler
addMissionEventHandler ["MapSingleClick", GSRI_fnc_subSelectPos];

// Adding "abort selection" eventHandler
addMissionEventHandler ["Map", {
	// params ["_opened", "_forced"];
	params ["_opened"];
	// Detect if map is closed but do not check if the event is linked to this module
	if!(_opened) exitWith {};
	player setVariable ["GSRI_FREMM_engine", nil];
	if!(player getVariable ["GSRI_FREMM_submarine_hadMap",true]) then {
		player unlinkItem "ItemMap";
		player setVariable ["GSRI_FREMM_submarine_hadMap", nil]
	};
}];

// Clientside jobs
if!(isDedicated) then {
	private _sub = _ship getVariable "GSRI_FREMM_submarine";
	// Create handle for sub movement
	private _com = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0];
	_com setObjectTexture [0, ""];
	_com enableSimulation false;
	_com attachTo [_ship, [-2.94995,-34,20.6]];
	[_sub, _com] call GSRI_fnc_subAddControls;
	
	// Add CRRC deploy/retrieve actions
	private _handle = _sub getVariable "GSRI_FREMM_sub_crrcHandle";
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
