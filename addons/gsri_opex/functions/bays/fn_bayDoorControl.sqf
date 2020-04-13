params["_com", "_player", "_params"];
_params params ["_lifting"];

_phase = 0.89;
if(_lifting) then {_phase = 0};

(_com getVariable "GSRI_FREMM_associatedDoor") animateSource ["Door_1_source", _phase];