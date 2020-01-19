// Adding lateral boat bays on Liberty-class ships
// by [-GSRI-] Cheitan

params["_ship"];

// Bays are created serverside to avoid desync
if(isServer) then {
	{
		_bay = createVehicle ["Land_Destroyer_01_Boat_Rack_01_F", [0,0,0], [], 0, "NONE"];
		_bay enableSimulation false;
		_bay allowDamage false;
		_bay setDir (getDir _ship + 180);
		_bay setPosATL ASLToATL (_ship modelToWorldWorld (_x select 1));
		_bay enableSimulation true;
		[_bay] remoteExecCall ["BIS_fnc_BoatRack01Init", 0, true];
		_ship setVariable [(_x select 0), _bay, true];
	} forEach [["GSRI_FREMM_Starboard_bay",[-11.5,14.43,7.5]],["GSRI_FREMM_Portboard_bay",[11.5,14.43,7.5]]];
};

// ACE actions are created clientside to avoid unnecessary network load
_actionSpawnInBay = ["actionSpawnInBay",localize "STR_GSRI_FREMM_spawnInBay","",{},{true}] call ace_interact_menu_fnc_createAction;
_actionsList = [];
_boats = ["B_Boat_Transport_01_F", "B_Boat_Transport_01_F", "B_Boat_Armed_01_minigun_F", "B_SDV_01_F"];
{
	_name = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_actionBoat = [format["action_%1",_x],_name,"",{_this spawn GSRI_fnc_libertyBayReplace},{true},{},[_x]] call ace_interact_menu_fnc_createAction;
	_actionsList pushBack _actionBoat;
} forEach _boats;
_actionNull = ["actionNull",localize "STR_GSRI_FREMM_emptyBay","",{_this spawn GSRI_fnc_libertyBayReplace},{true},{},[""]] call ace_interact_menu_fnc_createAction;
_actionsList pushBack _actionNull;
{
	_com = "Land_Tablet_02_black_F" createVehicleLocal [0,0,0];
	_com attachTo [_ship, (_x select 1)];
	_com setVectorDirAndUp [[0,0,-1],[0,-1,0]];
	_com setVariable ["GSRI_FREMM_associatedBay", _ship getVariable (_x select 0)];
	{ [_com, 0, ["_actionSpawnInBay"], _x] call ace_interact_menu_fnc_addActionToObject } forEach _actionsList;
} forEach [["GSRI_FREMM_Starboard_bay",[-4.4,18.29,8.9]], ["GSRI_FREMM_Portboard_bay",[4.4,18.29,8.9]]];