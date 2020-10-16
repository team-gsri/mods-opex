params["_target", "_player", "_args"];
_args params [["_height", 3000], ["_speed", 200], ["_class", "B_T_VTOL_01_Infantry_F"]];

_wait = missionNamespace getVariable ["planeWaiting", []];
if (player in _wait) then {
	_pos = _wait find player;
	_wait deleteAt _pos;
	missionNamespace setVariable  ["planeWaiting", _wait,true];
	hint "Vous n'êtes plus dans la liste d'embarquement de l'avion.";
} else {
	hint "Vous n'êtes pas dans la liste d'embarquement de l'avion.";
};