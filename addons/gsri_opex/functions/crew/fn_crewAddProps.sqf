if!(isServer) exitWith {};

params["_room", "_type"];

switch(_type) do {
	case "A": {
		private _mapName = ["Wall_F", format["Wall_%1_F", worldName]] select (worldName in ["Altis", "Stratis", "Malden", "Tanoa"]);
		private _board = (format["Land_MapBoard_01_%1", _mapName]) createVehicle getPos _roomA;
		_board attachTo [_roomA, [-0.721924,-1.83594,0.5]];
		_board setDir 180;

		private _seau = "Land_Bucket_F" createVehicle getPos _roomA;
		_seau attachTo [_roomA, [7.15308,-0.212402,-0.7]];
	};
	case "B": {
		private _poubelle = "Land_GarbageBin_01_F" createVehicle getPos _roomB;
		_poubelle attachTo [_roomB, [3.0459,-1.20215,-0.3]];
		_poubelle setDir 90;

		private _eau = "Land_WaterBottle_01_pack_F" createVehicle getPos _roomB;
		_eau attachTo [_roomB, [2.40796,-3.89209,0.1]];
		_eau setDir 33;
	};
};