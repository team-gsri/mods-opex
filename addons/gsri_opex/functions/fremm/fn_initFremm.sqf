params["_ship"];

// Parsing settings based on selected template
private _template = _ship getVariable "GSRI_FREMM_selectTemplate";
private _varList = (configProperties [configFile >> "GSRI_FREMM_Templates" >> _template >> "Properties"]) apply {configName _x};
{
  private _name = format ["%1_%2", "GSRI_FREMM", _x];
  private _feature = format ["%1_%2", _template, _x];
  _ship setVariable [_name, call compile _feature ];
} forEach _varList;

// Adding doors to the ship (useful for crew quarters and stuff), in format [classname, name, handlePos, manPos, handleDir(optionnal), goToShip(optionnal)]
// executed on every client the same way, so no need for a global setVariable
// eventually should be moved to config ?
private _shipDoors = [
	["Sign_Sphere10cm_F","DoorQuarters", [4.87646,-19.46,12.075], [4.78271,-19.7825,10.4181]],
	["Sign_Sphere10cm_F","DoorBays", [-0.270996,12.98,13.6152], [-0.178818,13.2195,11.9315]],
	["Sign_Sphere10cm_F","DoorBriefing", [-1.96,-22.82,11.92], [-1.25085,-22.73,10.3624]]
];
_ship setVariable ["GSRI_FREMM_moddedDoors", _shipDoors];

// Screens
[_ship] call GSRI_fnc_fremmAddScreens;

// Ship features
if(_ship getVariable "GSRI_FREMM_hasWeapons") then { [_ship] call GSRI_fnc_fremmAddWeapons };
if(_ship getVariable "GSRI_FREMM_hasArsenal") then { [_ship] call GSRI_fnc_fremmAddArsenal };
if(_ship getVariable "GSRI_FREMM_hasBridge") then { [_ship] call GSRI_fnc_fremmAddBridge };
if(_ship getVariable "GSRI_FREMM_hasBoatBays") then { [_ship] call GSRI_fnc_fremmAddBoatBays };
if(_ship getVariable "GSRI_FREMM_hasHelicopter") then { [_ship] call GSRI_fnc_fremmAddHeli };
if(_ship getVariable "GSRI_FREMM_hasSubmarine") then { [_ship] call GSRI_fnc_fremmAddSub };
if(_ship getVariable "GSRI_FREMM_hasCrewQuarters") then { [_ship] call GSRI_fnc_fremmAddCrewQuarters };
if(_ship getVariable "GSRI_FREMM_hasBriefingRoom") then { [_ship] call GSRI_fnc_fremmAddBriefingRoom };
if(_ship getVariable "GSRI_FREMM_hasParajump") then { [_ship] call GSRI_fnc_fremmAddParajump };

if(isServer) then {
	// Identifier, flag, nameplate textures
	private _identifier = (_ship getVariable "GSRI_FREMM_identifier");
	([_ship, "Land_Destroyer_01_hull_01_F"] call bis_fnc_destroyer01GetShipPart) setObjectTextureGlobal [0, format["A3\Boat_F_Destroyer\Destroyer_01\Data\Destroyer_01_N_0%1_co.paa",(_identifier select [0,1])]];
	([_ship, "Land_Destroyer_01_hull_01_F"] call bis_fnc_destroyer01GetShipPart) setObjectTextureGlobal [1, format["A3\Boat_F_Destroyer\Destroyer_01\Data\Destroyer_01_N_0%1_co.paa",(_identifier select [1,1])]];
	([_ship, "Land_Destroyer_01_hull_01_F"] call bis_fnc_destroyer01GetShipPart) setObjectTextureGlobal [2, format["A3\Boat_F_Destroyer\Destroyer_01\Data\Destroyer_01_N_0%1_co.paa",(_identifier select [2,1])]];
	([_ship, 'ShipFlag_US_F'] call bis_fnc_destroyer01GetShipPart) setFlagTexture (_ship getVariable "GSRI_FREMM_flag");
	([_ship, 'Land_Destroyer_01_hull_05_F'] call bis_fnc_destroyer01GetShipPart) setObjectTextureGlobal [0, (_ship getVariable "GSRI_FREMM_nameplate")];

	// Add map marker
	private _fullname = _ship getVariable ["GSRI_FREMM_fullname", ""];
	private _index = _ship getVariable "GSRI_FREMM_shipIndex";
	private _navalGroupName = format [localize "STR_GSRI_FREMM_navalGroup", _fullname];
	private _navalGroupTaskId = format["taskDestroyer%1_root", _index];
	[
		west,
		_navalGroupTaskId,
		[_navalGroupName, _navalGroupName, ""],
		objNull,
		"CREATED",
		-1,
		false,
		"defend"
	] call BIS_fnc_taskCreate;
	[
		west,
		[format["taskDestroyer%1", _index], _navalGroupTaskId],
		[_fullname, _fullname, ""],
		[_ship, true],
		"CREATED",
		-1,
		false,
		"boat"
	] call BIS_fnc_taskCreate;

	// Signs array
	private _signs = [
		["SCMS_Panneau1",[-1.09302,-16.8311,10.2468],270],
		["SCMS_Panneau2",[-2.8988,14.0205,8.38586],180],
		["SCMS_Panneau3",[-9.97888,51.6299,10.1794],180],
		["SCMS_Panneau4",[-1.91,-22.82,11.92],180]
	];

	{
		_x params ["_class", "_pos", "_dir", ["_texture",""]];
		private _sign = _class createVehicle [0,0,0];
		_sign enableSimulation false;
		_sign attachTo [_ship, _pos];
		_sign setDir _dir;
		if!(_texture == "") then { _sign setObjectTextureGlobal [0, _texture] };
	} forEach _signs;

	// Add Apex respawn position
    [west, _ship modelToWorldWorld [1.31018,-1.11719,7.27226], _fullname] call BIS_fnc_addRespawnPosition;
};

diag_log "initFremm finished.";
