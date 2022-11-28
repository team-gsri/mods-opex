params["_ship"];

if(isServer) then {
    private _commandRoom = createVehicle["SCMS_QG", getPos _ship];
    _commandRoom attachTo [_ship, [-4.63,-29.3,15.18]];
    _commandRoom setDir 90;

    private _table = createVehicle["Land_BriefingRoomDesk_01_F", getPos _commandRoom];
    _table attachTo [_commandRoom, [-0.3,0.14,-1.66]];

    private _lamp = createVehicle["SCMS_Ceiling_Lamp", getPos _commandRoom];
    _lamp attachTo [_commandRoom, [-0.33,2.33,2.3]];

    private _panneau = createVehicle["SCMS_Panneau2", getPos _commandRoom];
    _panneau attachTo [_commandRoom, [0.60,7.42,-0.08]];
    _panneau setDir 90;
    _panneau setObjectTextureGlobal[0, "fr\gsri\opex\images\Panneau_qg_co.paa"];

    // Modded doors
    private _moddedDoors = _ship getVariable ["GSRI_FREMM_moddedDoors", []];
    _moddedDoors pushBack [_commandRoom, [0.65,6.1,0.4], [0.55,8,-1.5], 0]; // from commandroom to deck
    _moddedDoors pushBack [_commandRoom, [0.60,7.42,0], [0.65,5.7,-1.25], 180]; // from deck to commandroom
    _ship setVariable ["GSRI_FREMM_moddedDoors", _moddedDoors, true];
};
