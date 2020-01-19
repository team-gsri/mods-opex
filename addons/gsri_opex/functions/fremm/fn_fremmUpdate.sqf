params["_destroyer",["_delete", false]];

// Weapons
{
	params["_gun", "_relPos", "_relDir"];
	_gun attachTo [_destroyer, _relPos];
	_gun setDir _relDir;
} forEach (_destroyer getVariable ["GSRI_Normandie_weapons", []]);

_destroyer call BIS_fnc_Destroyer01PosUpdate;