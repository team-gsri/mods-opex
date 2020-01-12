// Script de création et mise en place de l'armement du navire
// by [-GSRI-] Cheitan

if!(isServer) exitWith {};

// Récupération de la référence du navire
params["_navire"];

//[type, relPos, relDir]
_raw = [
	["B_Ship_Gun_01_F",[0,-79.08,12.1],180],
	["B_Ship_MRLS_01_F",[0,-62.4229,10.7],180],
	["B_AAA_System_01_F",[0,-48.106,15.1],180],
	["B_AAA_System_01_F",[0,36.3765,19.3],0],
	["B_SAM_System_01_F",[0,50.6011,15.8],0]
];
_weaponsList = [];

{
	_gun = createVehicle [(_x select 0), [0,0,0], [], 0, "CAN_COLLIDE"];
	_gun setDir (getDir _navire + (_x select 2));
	_gun setPosASL AGLToASL (_navire modelToWorld (_x select 1));
	createVehicleCrew _gun;
	_gun disableAI "ALL";
	_weaponsList pushBack [_gun, _x select 1, _x select 2];
} forEach _raw;

_navire setVariable ["GSRI_Normandie_weapons", _weaponsList, true];

//if!(is3DEN) then {{ detach (_x select 0) } forEach _weaponsList};