params["_ship"];

if(isServer) then {
    private _commandRoom = createVehicle["SCMS_QG", getPos _ship];
    _commandRoom attachTo [_ship, [-4.63,-29.3,15.18]];
    _commandRoom setDir 90;

    private _table = createVehicle["Land_BriefingRoomDesk_01_F", getPos _commandRoom];
    _table attachTo [_commandRoom, [-0.3,0.14,-1.66]];

    private _lamp = createVehicle["SCMS_Ceiling_Lamp", getPos _commandRoom];
    _lamp attachTo [_commandRoom, [-0.33,2.33,2.3]];
};
