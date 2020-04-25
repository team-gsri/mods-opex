params ["", "", "_args"];
_args params ["_hangar"];
private _heli = ([_hangar] call GSRI_fnc_heliRetrieveCurrent);
["HeliDelete", [getText (configFile >> "CfgVehicles" >> typeOf _heli >> "displayName")]] call BIS_fnc_showNotification;
deleteVehicle _heli;