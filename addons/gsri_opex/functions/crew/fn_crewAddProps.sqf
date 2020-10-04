if!(isServer) exitWith {};

params["_room", "_type"];

switch(_type) do {
	case "A": {
		private _mapName = ["Wall_F", format["Wall_%1_F", worldName]] select (toLower worldName in ["altis", "stratis", "malden", "tanoa"]);
		private _board = (format["Land_MapBoard_01_%1", _mapName]) createVehicle getPos _room;
		_board attachTo [_room, [-0.721924,-1.7,0.5]];
		_board setDir 180;

		private _seau = "Land_Bucket_F" createVehicle getPos _room;
		_seau attachTo [_room, [7.15308,0,-0.7]];
	};
	case "B": {
		private _poubelle = "Land_GarbageBin_01_F" createVehicle getPos _room;
		_poubelle attachTo [_room, [3.0459,-1,-0.3]];
		_poubelle setDir 90;

		private _eau = "Land_WaterBottle_01_pack_F" createVehicle getPos _room;
		_eau attachTo [_room, [2.40796,-3.89209,0]];
		_eau setDir 33;
	};
};