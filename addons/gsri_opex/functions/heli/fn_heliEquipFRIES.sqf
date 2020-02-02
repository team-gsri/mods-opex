params ["_t", "_p", "_args"];
_args params ["_hangar"];
_heli = [_hangar] call GSRI_fnc_heliRetrieveCurrent;
["HeliFRIES", [getText (configFile >> "CfgVehicles" >> typeOf _heli >> "displayName")]] call BIS_fnc_showNotification;
[_heli] remoteExecCall ["ace_fastroping_fnc_equipFRIES", 2];