params["_target", "_player", "_args"];
_args params [["_height", 3000], ["_speed", 200], ["_class", "B_T_VTOL_01_Infantry_F"]];

_wait = missionNamespace getVariable ["planeWaiting", []];
if (player in _wait) then {
	hint "Vous êtes déjà dans la liste d'embarquement de l'avion.";
} else {
	_wait pushBack player;
	missionNamespace setVariable  ["planeWaiting", _wait,true];
	hint "Vous avez été ajouté à la liste d'embarquement de l'avion.";
};