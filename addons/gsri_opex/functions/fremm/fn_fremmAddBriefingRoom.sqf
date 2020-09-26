params ["_ship"];

if(isServer) then {
	// Briefing room
	private _briefing = "SCMS_Brief_base" createVehicle [0,0,0];
	_briefing setPosASL [50, ((_ship getVariable "GSRI_FREMM_shipIndex")*50), 10];
	_briefing setVectorUp [0,0,1];
	_briefing setDir (getDir _ship + 90);
	_briefing call BIS_fnc_Destroyer01PosUpdate;
	_ship setVariable ["GSRI_FREMM_briefingRoom", _briefing, true];

	// Chairs
	private _chairs_data = [
		[1.84277,1.4751,-0.82],
		[1.8457,0.863037,-0.82],
		[1.84277,0.175049,-0.82],
		[1.83594,-0.488037,-0.82],
		[0.510742,1.4751,-0.82],
		[0.513672,0.863037,-0.82],
		[0.510742,0.175049,-0.82],
		[0.503906,-0.488037,-0.82],
		[-0.852051,1.44604,-0.82],
		[-0.849121,0.834961,-0.82],
		[-0.851074,0.146973,-0.82],
		[-0.858887,-0.515869,-0.82],
		[-2.11426,1.45508,-0.82],
		[-2.11133,0.843018,-0.82],
		[-2.11426,0.155029,-0.82],
		[-2.12109,-0.507813,-0.82],
		[-3.29736,1.45483,-0.82],
		[-3.29297,0.842041,-0.82],
		[-3.2959,0.154053,-0.82],
		[-3.3042,-0.509033,-0.82],
		[-4.53906,2.08301,-0.82],
		[-4.54199,1.42676,-0.82],
		[-4.53809,0.813965,-0.82],
		[-4.54102,0.125977,-0.82],
		[-4.54932,-0.536865,-0.82]
	];

	{
		private _chair = "SCMS_Chaise" createVehicle getPos _briefing;
		_chair attachTo [_briefing, _x];
	} forEach _chairs_data;

	{
		private _props = _x select 0 createVehicle getPos _briefing;
		_props attachTo [_briefing, _x select 1];
		_props setDir (_x select 2);
	} forEach [
		["Land_MapBoard_01_Wall_F", [-3.55518,3.1001,0.2], 0],
		["Land_WaterCooler_01_new_F", [-4.65088,2.7583,-0.57], 270],
		["SCMS_Large_screen", [4.67773,1.0271,0.3], 180]
	];
	private _briefModdedDoors = [
		["Land_Battery_F", "Door1", [0.895508,3.12,0.3], [0.837891,2.5752,-1.29856]]
	];
	_briefing setVariable ["GSRI_FREMM_moddedDoors",_briefModdedDoors, true];
};

if!(isDedicated) then {
	private _statement = {
		params["_target", "_player"];
		_player setPosWorld (_target getVariable "GSRI_FREMM_goTo");
	};
	private _doorCross = ["actionCrossDoor",localize "STR_GSRI_FREMM_crewCrossDoor","",_statement,{true}] call ace_interact_menu_fnc_createAction;

	private _corridors = [
		[[_ship, "DoorBriefing"],[_ship getVariable "GSRI_FREMM_briefingRoom", "Door1"]]
	];

	{ [_x, _doorCross] call GSRI_fnc_doorConnect } forEach _corridors;
};