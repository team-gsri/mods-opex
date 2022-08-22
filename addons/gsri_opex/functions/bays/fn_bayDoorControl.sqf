//params["_com", "_player", "_params"];
params["_com"];

private _door = _com getVariable "GSRI_FREMM_associatedDoor";
private _currentPhase = _door animationSourcePhase "Door_1_source";
private _nextPhase = [0, 0.89] select (_currentPhase < 0.5);

playSound3D ["fr\gsri\opex\sounds\doorSound.wss", _door];
_door animateSource ["Door_1_source", _nextPhase];
waitUntil { (_door animationSourcePhase "Door_1_source") == _nextPhase };
playSound3D ["a3\sounds_f\structures\doors\ServoRamp\ServoRampSlam.wss", _door];
