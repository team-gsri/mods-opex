params ["_ship"];

if(isServer) then {
	// Briefing room
	private _briefing = "SCMS_Briefroom" createVehicle [0,0,0];
	_briefing setVectorUp [0,0,1];
	_briefing attachTo [_ship, [-5.20593,-27.1812,11.8]];
	_briefing setDir 90;
	_ship setVariable ["GSRI_FREMM_briefingRoom", _briefing, true];

	private _additionnalDoor = "SCMS_Habs_Rplc" createVehicle [0,0,0];
	_additionnalDoor setVectorUp [0,0,1];
	_additionnalDoor attachTo [_ship, [-1.90002,-22.0962,11.75]];
	_additionnalDoor setDir 270;

	// Chairs
	private _chairs_data = [
		[2.21378,-0.644653,-0.82],
		[-0.515711,1.35291,-0.82],
		[0.835363,-0.707275,-0.82],
		[-3.18368,1.43066,-0.82],
		[0.837316,-0.0404053,-0.82],
		[0.828527,0.726807,-0.82],
		[2.20695,0.72937,-0.82],
		[-4.55526,-0.00598145,-0.82],
		[2.2089,1.39624,-0.82],
		[-1.88925,-0.75061,-0.82],
		[-1.88729,-0.0837402,-0.82],
		[-1.89608,0.683472,-0.82],
		[-1.89413,1.35034,-0.82],
		[-0.510828,-0.748047,-0.82],
		[-0.508875,-0.0811768,-0.82],
		[-0.517664,0.686035,-0.82],
		[-4.5621,1.4281,-0.82],
		[-4.55721,-0.673096,-0.82],
		[-3.18563,0.763794,-0.82],
		[-3.17684,-0.00341797,-0.82],
		[-3.1788,-0.670288,-0.82],
		[2.21573,0.0222168,-0.82],
		[0.83048,1.39368,-0.82],
		[-4.56405,0.76123,-0.82]
	];
	{
		private _chair = "SCMS_Chaise" createVehicle getPos _briefing;
		_chair attachTo [_briefing, _x];
	} forEach _chairs_data;

	// Briefing screen
	private _screen = "Land_BriefingRoomScreen_01_F" createVehicle getPos _briefing;
	_screen attachTo [_briefing, [4.70694,1.16333,-1.47592]];
	_screen setDir 270;

	// Modded doors
    private _moddedDoors = _ship getVariable ["GSRI_FREMM_moddedDoors", []];
    _moddedDoors pushBack [_briefing, [-4.4,3,0.3], [-4.4,3.8,-1.3], 0]; // from briefing to deck
    _moddedDoors pushBack [_briefing, [-4.35,3.4,0.3], [-4.4,2.6,-1.3], 180]; // from deck to briefing
    _moddedDoors pushBack [_briefing, [0.9,3,0.3], [0.6,4.2,-1.3], 0]; // from briefing to forward corridor
    _moddedDoors pushBack [_briefing, [0.6,3.75,0.3], [0.9,2.7,-1.3], 180]; // from forward corridor to briefing
    _ship setVariable ["GSRI_FREMM_moddedDoors", _moddedDoors, true];
};

if!(isDedicated) then {
	systemChat "todo : screen images and stuff";
};
