// Spawning bridge units
// by [GSRI] Cheitan

// Get boat reference
params["_navire"];

if(isServer) then {
	// Gear script
	_marin = {
		params["_unit"];
		removeAllWeapons _unit;
		removeAllItems _unit;
		removeAllAssignedItems _unit;
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeHeadgear _unit;
		removeGoggles _unit;
		_unit forceAddUniform "U_B_GEN_Soldier_F";
		_unit linkItem "H_MilCap_blue";
		_unit linkItem "G_Tactical_Clear";
		[_unit, "ace_novoice"] remoteExec ["setSpeaker", 0, true];
	};

	// Pilotes (tic et tac)
	_group = createGroup[WEST, true];
	_posArray = [[-1.29529,-39.7251,19.35],[1.29529,-39.7251,19.35]];
	{
		// Create helper
		_helper = "babe_helper" createVehicle [0,0,0];
		_helper attachTo [_navire, _x];

		// Create unit
		_unit = _group createUnit ["B_Soldier_F", [0,0,0], [], 0, "CAN_COLLIDE"];
		_unit attachTo [_navire, _x];
		detach _unit;
		_unit allowDamage false;
		_unit setDir (getDir _navire + 180);
		_unit disableAI "ALL";
		_move = selectRandom ["HubSittingAtTableU_idle1", "HubSittingAtTableU_idle2", "HubSittingAtTableU_idle3"];
		[_unit, _move] remoteExecCall ["switchMove", 0];
		_unit addEventHandler ["AnimDone", {
			params ["_u", "_anim"];
			_move = selectRandom ["HubSittingAtTableU_idle1", "HubSittingAtTableU_idle2", "HubSittingAtTableU_idle3"];
			[_u, _move] remoteExecCall ["switchMove", 0];
		}];

		// Spawn unit's gear
		removeAllWeapons _unit;
		removeAllItems _unit;
		removeAllAssignedItems _unit;
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeHeadgear _unit;
		removeGoggles _unit;
		_unit forceAddUniform "U_B_GEN_Soldier_F";
		_unit linkItem "H_MilCap_blue";
		[_unit, "ace_novoice"] remoteExec ["setSpeaker", 0, true];
		sleep 0.1;
		_unit linkItem "G_Tactical_Clear";

		// Save unit
		_navire setVariable [format["GSRI_marin_%1",_forEachIndex], _unit, true];
	} forEach _posArray;
};