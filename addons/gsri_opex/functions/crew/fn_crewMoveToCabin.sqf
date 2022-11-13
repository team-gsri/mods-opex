if(time - (player getVariable ["GSRI_FREMM_respawnTimestamp",0]) < 10) then {
	// Select a room and a relative pos (cabin)
	private _ship = nearestObject [player, "Land_Destroyer_01_base_F"];
	private _room = _ship getVariable format["GSRI_FREMM_crewQuarters%1", selectRandom ["RoomA", "RoomB"]];
	private _pos = [selectRandom[-4,-0.8,2.8,5.8], 5, -0.5];
	player setPosWorld (_room modelToWorldWorld _pos);
	enableEnvironment false;
};
