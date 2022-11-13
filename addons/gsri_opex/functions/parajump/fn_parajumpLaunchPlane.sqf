params["_target", "_player", "_args"];
_args params [["_height", 3000], ["_speed", 200], ["_class", "B_T_VTOL_01_Infantry_F"]];

_start   = missionnamespace getVariable ["planePosJump", []];
_end   = missionnamespace getVariable ["planePosStop", []];
_side  = WEST;
_list = missionNamespace getVariable ["planeWaiting",[]];

if (count _start == 3 && count _end == 3 && count _list != 0) then { [2, _height];
	_start set [2,_height];
	_end set [2, _height];

	_direction = [_start, _end] call BIS_fnc_dirTo;

	_vehicleContainer = [_start, _direction, _class, _side] call BIS_fnc_spawnVehicle;
	_vehicle   = _vehicleContainer select 0;
	_vehicleCrew  = _vehicleContainer select 1;
	_vehicleGroup  = _vehicleContainer select 2;

	_vehicle disableAi "TARGET";
	_vehicle disableAi "AUTOTARGET";
	_vehicleGroup allowFleeing 0;

	_vehicle flyInHeight _height;

	_waypoint = _vehicleGroup addWaypoint [_end, 0];

	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointBehaviour "CARELESS";
	_waypoint setWaypointCombatMode "BLUE";
	_vehicle limitspeed _speed;

	_waypoint setWaypointStatements [
		"true",
		"private ['_group', '_vehicle']; _group = group this; _vehicle = vehicle this; { deleteVehicle _x } forEach units _group; deleteVehicle _vehicle; deleteGroup _group;"
	];

	{
		_x moveInAny _vehicle;
	} foreach _list;
	missionnamespace setVariable ["planePosJump", []];
	missionnamespace setVariable ["planePosStop", []];
	missionNamespace setVariable ["planeWaiting",[]];
} else {
	if (count _start != 3 && count _end != 3) then
	{
		hint "L'itinéraire de l'avion n'a pas été défini.";
	};

	if (count _list == 0) then
	{
		hint "Personne dans la liste d'embarquement";
	};
};
