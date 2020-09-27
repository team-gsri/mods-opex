params["_template"];

private _configList = (configFile >> "GSRI_FREMM_Templates" >> _template >> "AvailableBoats") call BIS_fnc_getCfgSubClasses;
private _boatList = [];

{
	private _liveries = getArray (configFile >> "GSRI_FREMM_Templates" >> _template >> "AvailableBoats" >> _x >> "liveries");
	private _name = getText (configFile >> "GSRI_FREMM_Templates" >> _template >> "AvailableBoats" >> _x >> "name");
	_boatList pushBack [_x, _name, _liveries];
} forEach _configList;

_boatList