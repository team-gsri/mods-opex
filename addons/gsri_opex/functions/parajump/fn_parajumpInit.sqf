_this spawn {
	params["_target", "_player", "_args"];
	_args params [["_height", 3000], ["_speed", 200], ["_class", "B_T_VTOL_01_Infantry_F"]];

	openMap true;
	hint "Position de départ de l'avion";
	onMapSingleClick 'missionNamespace setVariable ["planePosJump", _pos,true];';
	waitUntil { count (missionNamespace getVariable ["planePosJump",[]]) > 0};
	hint "Position d'arrivee de l'avion";
	onMapSingleClick 'missionNamespace setVariable ["planePosStop", _pos,true];';
	waitUntil { count (missionNamespace getVariable ["planePosStop",[]]) > 0};
	openMap false;
};
