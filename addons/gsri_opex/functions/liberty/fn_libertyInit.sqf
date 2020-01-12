params["_destroyer"];

// Init the vanilla ship
_destroyer call BIS_fnc_Destroyer01Init;

_todo = missionNamespace getVariable ["GSRI_todo", []];
_todo pushBack _destroyer;
if(is3DEN) exitWith {};

if(_destroyer getVariable ["gsri_frigate_attribute_addweapons",true]) then { [_destroyer] call GSRI_fnc_libertyWeapons };
/*
if(_arsenal) then { [_destroyer] call GSRI_fnc_libertyArsenal };
if(_preslots) then { [_destroyer] call GSRI_fnc_libertyPreslots };
if(_bridge) then { [_destroyer] call GSRI_fnc_libertyBridge };
if(_bays) then { [_destroyer] call GSRI_fnc_libertyBays };
if(_heli) then { [_destroyer] call GSRI_fnc_initHeli };
if(_sub) then { [_destroyer] call GSRI_fnc_initSubmarine };
*/

if(isServer) then {
	// Add map marker
	_mk = createMarker ["marker_destroyer", _destroyer];
	_mk setMarkerType "flag_France";
	_mk setMarkerText "D-651 Normandie";

	// Signs array
	_signs = [
		["SignAd_Sponsor_F",[-1.912,6.641,8.27],270,"gsri_opex\images\zone_preparation.paa"],
		["SignAd_Sponsor_F",[-2.91199,14.007,7.465],270,"gsri_opex\images\vers_sousmarin.paa"],
		["SignAd_SponsorS_F",[-10.116,50.833,9.2],270,"gsri_opex\images\vers_heli.paa"]
	];

	{
		_x params ["_class", "_pos", "_dir", "_texture"];
		_sign = _class createVehicle [0,0,0];
		_sign enableSimulation false;
		_sign attachTo [_destroyer, _pos];
		_sign setDir _dir;
		_sign setObjectTextureGlobal [0, _texture];
	} forEach _signs;
};