params["_com", "_player", "_params"];
_params params ["_lifting"];

private ["_currentPhase", "_nextPhase"];

_currentPhase = (_com getVariable "GSRI_FREMM_associatedDoor") animationSourcePhase "Door_1_source";
_nextPhase = [0, 0.89] select (_currentPhase < 0.5);

(_com getVariable "GSRI_FREMM_associatedDoor") animateSource ["Door_1_source", _nextPhase];