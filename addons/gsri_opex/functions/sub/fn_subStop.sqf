params["_sub", "_stop"];

private _engine = _sub getVariable "GSRI_FREMM_engine";

_engine enableSimulationGlobal !(_stop);
_engine engineOn !(_stop);

if(_stop) then {detach _sub} else {_sub attachTo [_engine, [0,-15,-3.5]]; _sub setDir 180};

_sub setVariable ["GSRI_FREMM_subIsStill", _stop, true];
