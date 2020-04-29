params["_ship"];

// Parsing settings based on selected template
private _template = _ship getVariable "GSRI_FREMM_selectTemplate";
private _varList = (configProperties [configFile >> "GSRI_FREMM_Templates" >> _template]) apply {configName _x};
{
  private _name = format ["%1_%2", "GSRI_FREMM", _x];
  private _feature = format ["%1_%2", _template, _x];
  _ship setVariable [_name, call compile _feature ];
} forEach _varList;

// Ship features
if(_ship getVariable "GSRI_FREMM_hasWeapons") then { [_ship] call GSRI_fnc_fremmAddWeapons };
if(_ship getVariable "GSRI_FREMM_hasArsenal") then { [_ship] call GSRI_fnc_fremmAddArsenal };
if(_ship getVariable "GSRI_FREMM_hasBridge") then { [_ship] call GSRI_fnc_fremmAddBridge };
if(_ship getVariable "GSRI_FREMM_hasBoatBays") then { [_ship] call GSRI_fnc_fremmAddBoatBays };
if(_ship getVariable "GSRI_FREMM_hasHelicopter") then { [_ship] call GSRI_fnc_fremmAddHeli };
if(_ship getVariable "GSRI_FREMM_hasSubmarine") then { [_ship] call GSRI_fnc_fremmAddSub };

if(isServer) then {
	// Identifier, flag, nameplate textures
	private _identifier = (_ship getVariable "GSRI_FREMM_identifier");
	([_ship, "Land_Destroyer_01_hull_01_F"] call bis_fnc_destroyer01GetShipPart) setObjectTextureGlobal [0, format["A3\Boat_F_Destroyer\Destroyer_01\Data\Destroyer_01_N_0%1_co.paa",(_identifier select [0,1])]];
	([_ship, "Land_Destroyer_01_hull_01_F"] call bis_fnc_destroyer01GetShipPart) setObjectTextureGlobal [1, format["A3\Boat_F_Destroyer\Destroyer_01\Data\Destroyer_01_N_0%1_co.paa",(_identifier select [1,1])]];
	([_ship, "Land_Destroyer_01_hull_01_F"] call bis_fnc_destroyer01GetShipPart) setObjectTextureGlobal [2, format["A3\Boat_F_Destroyer\Destroyer_01\Data\Destroyer_01_N_0%1_co.paa",(_identifier select [2,1])]];
	([_ship, 'ShipFlag_US_F'] call bis_fnc_destroyer01GetShipPart) setFlagTexture (_ship getVariable "GSRI_FREMM_flag");
	([_ship, 'Land_Destroyer_01_hull_05_F'] call bis_fnc_destroyer01GetShipPart) setObjectTextureGlobal [0, (_ship getVariable "GSRI_FREMM_nameplate")];

	// Add map marker
	private _mk = createMarker ["marker_destroyer", _ship];
	_mk setMarkerType "flag_France";
	_mk setMarkerText (_ship getVariable "GSRI_FREMM_fullname");

	// Signs array
	private _signs = [
		["SignAd_Sponsor_F",[-1.912,6.641,8.27],270,"gsri_opex\images\zone_preparation.paa"],
		["SignAd_Sponsor_F",[-2.91199,14.007,7.465],270,"gsri_opex\images\vers_sousmarin.paa"],
		["SignAd_SponsorS_F",[-10.116,50.833,9.2],270,"gsri_opex\images\vers_heli.paa"]
	];

	{
		_x params ["_class", "_pos", "_dir", "_texture"];
		private _sign = _class createVehicle [0,0,0];
		_sign enableSimulation false;
		_sign attachTo [_ship, _pos];
		_sign setDir _dir;
		_sign setObjectTextureGlobal [0, _texture];
	} forEach _signs;

	// Screens
	[_ship] call GSRI_fnc_fremmAddScreens;
};

diag_log "initFremm finished.";
