params["_com", "_player", "_params"];
_params params ["_lifting"];

private ["_door","_currentPhase", "_nextPhase"];

_door = _com getVariable "GSRI_FREMM_associatedDoor";
_currentPhase = _door animationSourcePhase "Door_1_source";
_nextPhase = [0, 0.89] select (_currentPhase < 0.5);

playSound3D ["a3\sounds_f\structures\doors\ServoRamp\ServoRampSound_1.wss", _door];
_door animateSource ["Door_1_source", _nextPhase];