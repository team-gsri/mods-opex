// This function has a corridor "name" as an input, and extract from it the objects involved in the relation
params["_ship","_corridorName"];

private _parts = _corridorName splitString "_";

{
	if(_x isEqualTo "Ship") then {
		_parts set [_forEachIndex, _ship];
	} else {
		_parts set [_forEachIndex, _ship getVariable format["GSRI_FREMM_CrewQuarters%1", _x]];
	};
} forEach _parts;

_parts