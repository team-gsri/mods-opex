// Script d'ajout des baies latérales
// by [LM] Cheitan

// Récupération du navire concerné
params["_navire"];

// Création des baies, côté serveur
if(isServer) then {
	{
		_bay = createVehicle ["Land_Destroyer_01_Boat_Rack_01_F", [0,0,0], [], 0, "NONE"];
		_bay enableSimulation false;
		_bay allowDamage false;
		_bay setDir (getDir _navire + 180);
		_bay setPosATL ASLToATL (_navire modelToWorldWorld (_x select 1));
		_bay enableSimulation true;
		[_bay] remoteExecCall ["BIS_fnc_BoatRack01Init", 0, true];
		_navire setVariable [(_x select 0), _bay, true];
	} forEach [["baie_tribord",[-11.5,14.43,7.5]],["baie_babord",[11.5,14.43,7.5]]];
};

// Actions ACE
_actionCRRC = ["actionCRRC","CRRC","",{_this spawn GSRI_fnc_libertyBayReplace},{true},{},["B_Boat_Transport_01_F"]] call ace_interact_menu_fnc_createAction;
_actionRHIB = ["actionRHIB","RHIB","",{_this spawn GSRI_fnc_libertyBayReplace},{true},{},["C_Boat_Transport_02_F"]] call ace_interact_menu_fnc_createAction;
_actionHB = ["actionHB","Hors-bord","",{_this spawn GSRI_fnc_libertyBayReplace},{true},{},["B_Boat_Armed_01_minigun_F"]] call ace_interact_menu_fnc_createAction;
_actionSDV = ["actionSDV","SDV","",{_this spawn GSRI_fnc_libertyBayReplace},{true},{},["B_SDV_01_F"]] call ace_interact_menu_fnc_createAction;
_actionNull = ["actionNull","Vide","",{_this spawn GSRI_fnc_libertyBayReplace},{true},{},[""]] call ace_interact_menu_fnc_createAction;

// Création des commandes, côté client
{
	_com = "Land_Tablet_02_black_F" createVehicleLocal [0,0,0];
	_com attachTo [_navire, (_x select 1)];
	_com setVectorDirAndUp [[0,0,-1],[0,-1,0]];
	_com setVariable ["baie", _navire getVariable (_x select 0), true];
	{ [_com, 0, ["ACE_MainActions"], _x] call ace_interact_menu_fnc_addActionToObject } forEach [_actionCRRC, _actionRHIB, _actionHB, _actionSDV, _actionNull];
} forEach [["baie_tribord",[-4.4,18.29,8.9]], ["baie_babord",[4.4,18.29,8.9]]];