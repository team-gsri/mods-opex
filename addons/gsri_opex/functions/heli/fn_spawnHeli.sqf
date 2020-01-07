params["_t", "_u", "_args"];

// Allow suspension
_args spawn {
	params["_hangar", "_newType"];

	// Making some space for our new chopper, sleep is mandatory
	deleteVehicle ([_hangar] call GSRI_fnc_getHeli);
	sleep 0.1;

	// Carefully spawn the new helo
	_veh = _newType createVehicle [0,0,100];
	_veh enableSimulation false;
	_veh setDir getDir _hangar;
	_veh setPosASL getPosASL _hangar;
	_veh enableSimulation true;

	// Quick confirmation
	["HeliInfo", [getText (configFile >> "CfgVehicles" >> _newType >> "displayName")]] call BIS_fnc_showNotification;
};