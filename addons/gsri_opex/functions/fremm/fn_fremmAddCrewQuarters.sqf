/*
 * Author: [-GSRI-] Cheitan
 * Create objects representing crew quarters. Specific actions and other interactible material is delegated to client-side functions once big work is done.
 *
 * Arguments:
 * _ship: object
 *
 * Return Value:
 * None
 *
 * Example:
 * [myShip] call gsri_fnc_fremmAddCrewQuarters
 *
 * Public: No
 */

params["_ship"];

// Server part : spawning objects
if(isServer) then {
    // Base objects (corridors, rooms, etc)
    private _bedrooms = [];
    private _data = [
        ["SCMS_Couloir",0,[-0.244751,-12.4375,12.2001]],
        ["SCMS_Couloir",270,[4.61157,-10.814,12.2002]],
        ["SCMS_Habs_Rplc",90,[-6.94519,-13.1768,12.2]],
        ["SCMS_Briefroom",90,[-9.84521,-15.6782,12.2]],
        ["SCMS_Habs_Rplc2",0,[-1.87805,-14.4517,12.2]],
        ["SCMS_Habs_Rplc2",90,[2.56079,-15.644,12.2]],
        ["SCMS_Habs_Rplc2",0,[1.35242,-14.4634,12.2]],
        ["Land_ConcreteWall_03_m_pole_F",90,[-3.60046,-10.8433,12]],
        ["Land_ConcreteWall_03_m_pole_F",0,[-3.56958,-13.979,12]],
        ["Land_ConcreteWall_03_m_pole_F",315,[3.04077,-10.8862,12]],
        ["Land_ConcreteWall_03_m_pole_F",45,[3.04224,-13.9961,12]],
        ["SCMS_bedroom",0,[-1.83228,-10.834,12.65]],
        ["SCMS_bedroom",0,[1.41309,-10.8237,12.65]],
        ["SCMS_Couloir",0,[-3.55017,-2.72217,12.2003]],
        ["SCMS_Couloir",270,[-5.17163,-7.51221,12.2004]],
        ["SCMS_Briefroom",180,[7.83545,-1.12402,12.2]],
        ["SCMS_Habs_Rplc2",270,[-3.14954,-5.91699,12.2]],
        ["SCMS_Habs_Rplc2",0,[-8.43298,-4.73438,12.2]],
        ["SCMS_Habs_Rplc2",90,[2.56531,-5.96533,12.2]],
        ["SCMS_Habs_Rplc2",0,[1.27307,-4.74072,12.2]],
        ["SCMS_Habs_Rplc2",0,[-1.96252,-4.74365,12.2]],
        ["SCMS_Habs_Rplc2",270,[-3.15649,-9.14697,12.2]],
        ["SCMS_Habs_Rplc2",90,[2.56055,-9.19629,12.2]],
        ["Land_ConcreteWall_03_m_pole_F",45,[-6.74109,-4.24854,12]],
        ["Land_ConcreteWall_03_m_pole_F",315,[-6.72241,-1.14746,12]],
        ["Land_ConcreteWall_03_m_pole_F",45,[-3.625,-1.14551,12]],
        ["Land_ConcreteWall_03_m_pole_F",315,[-3.61023,-4.24609,12]],
        ["SCMS_Cantine",270,[7.98486,-10.5352,12.65]],
        ["SCMS_bedroom",0,[1.3374,-1.11133,12.65]],
        ["SCMS_bedroom",0,[-8.44897,-1.11865,12.65]],
        ["SCMS_bedroom",0,[-1.89404,-1.12207,12.65]],
        ["SCMS_bedroom",270,[-6.78052,-5.854,12.65]],
        ["SCMS_bedroom",270,[-6.78235,-9.08154,12.65]]
    ];
    {
        _x params ["_classname", "_relativeDirection", "_relativePosition"];
        private _item = createVehicle[_classname, getPos _ship];
        _item setVectorUp [0,0,1];
        _item attachTo [_ship, _relativePosition];
        _item setDir _relativeDirection;
        // Additionnal virtual beds
        if(_classname == "SCMS_bedroom") then {
            _bedrooms pushBack _item;
            private _bed = createVehicle["SCMS_Beds", getPos _ship];
            _bed setVectorUp [0,0,1];
            _bed attachTo [_item, [-0.05,0.05,-0.05]];
        };
        // Additionnal kitchen props
        if (_classname == "SCMS_Cantine") then {
            private _kitchen = _item;
            private _propsData = [
                ["SCMS_Chaise",0,[-4.10999,-1.41211,-1.2]],
                ["SCMS_Chaise",0,[-4.10229,-0.782227,-1.2]],
                ["SCMS_Chaise",0,[-4.09241,-0.090332,-1.2]],
                ["Land_WaterCooler_01_new_F",270,[-5.00708,1.63623,-0.96]],
                ["Land_WaterCooler_01_new_F",90,[2.69189,1.64014,-0.96]],
                ["SCMS_Chaise",0,[-1.76233,0.0766602,-1.2]],
                ["SCMS_Chaise",0,[0.558472,-1.26172,-1.2]],
                ["SCMS_Chaise",0,[-1.77222,-0.615234,-1.2]],
                ["SCMS_Chaise",0,[0.57605,0.0600586,-1.2]],
                ["SCMS_Chaise",180,[1.58191,0.0620117,-1.2]],
                ["SCMS_Chaise",0,[-1.77991,-1.24512,-1.2]],
                ["SCMS_Chaise",180,[1.57373,-0.567871,-1.2]],
                ["SCMS_Chaise",180,[1.56396,-1.25977,-1.2]],
                ["SCMS_Chaise",180,[-0.766357,-0.00683594,-1.2]],
                ["SCMS_Chaise",180,[-0.77417,-0.636719,-1.2]],
                ["SCMS_Chaise",180,[-0.783936,-1.32861,-1.2]],
                ["SCMS_Chaise",180,[-3.0127,-0.0551758,-1.2]],
                ["SCMS_Chaise",180,[-3.02051,-0.685059,-1.2]],
                ["SCMS_Chaise",180,[-3.03027,-1.37695,-1.2]],
                ["SCMS_Chaise",0,[0.566162,-0.631836,-1.2]]
            ];
            {
                _x params ["_propType", "_propDirection", "_propPosition"];
                private _prop = createVehicle[_propType, getPos _kitchen];
                _prop setVectorUp [0,0,1];
                _prop attachTo [_kitchen, _propPosition];
                _prop setDir _propDirection;
                if(_propType == "SCMS_Chaise") then { _prop setVariable ["SCMS_custom_seat_exit", [-0.6, 0, -0.35], true] };
            } forEach _propsData;
        };
    } forEach _data;

    // Helpers to distinguish between real/modded doors and fake ones.
    private _signs = [
        ["SCMS_Panneau2","Panneau_interdit_co.paa",0,[6.11804,-16.3101,12.5]],
        ["SCMS_Panneau2","Panneau_interdit_co.paa",90,[-5.10596,-13.9141,12.5]],
        ["SCMS_Panneau2","Panneau_elec_co.paa",0,[6.10303,-13.2354,12.5]],
        ["SCMS_Panneau2","Panneau_interdit_co.paa",180,[-9.96204,-2.7793,12.5]],
        ["SCMS_Panneau2","Panneau_elec_co.paa",270,[-4.375,-1.16602,12.5]],
        ["SCMS_Panneau2","Panneau_interdit_co.paa",270,[5.40601,-4.47168,12.5]],
        ["SCMS_Panneau2","Panneau_interdit_co.paa",0,[2.79834,-3.52734,12.5]],
        ["SCMS_Panneau2","Panneau_interdit_co.paa",180,[-6.64978,-12.502,12.5]]
    ];
    {
        _x params ["_signType", "_signTexture", "_signDir", "_signPos"];
        private _sign = createVehicle [_signType, getPos _ship];
        _sign attachTo [_ship, _signPos];
        _sign setDir _signDir;
        _sign setObjectTextureGlobal[0, "fr\gsri\opex\images\"+_signTexture];
    } forEach _signs;

    // This will be used both for client-side ACE actions and for spawn management
    _ship setVariable ["gsri_opex_availableBedrooms", _bedrooms, true];

    // Modded doors
    private _moddedDoors = _ship getVariable ["GSRI_FREMM_moddedDoors", []];
    _moddedDoors pushBack [_ship, [4.7,-16.7,12.4], [4.85,-20,10.4], 180]; // from quarters to deck
    _moddedDoors pushBack [_ship, [4.85,-19.5,12], [4.7,-16,10.9], 0]; // from deck to quarters
    _ship setVariable ["GSRI_FREMM_moddedDoors", _moddedDoors, true];
};

if!(isDedicated) then {
    //clientCanLoad already set when executing this

    // This will trigger client-side init of bedrooms
    {
        [_x] call gsri_fnc_crewInitBedroom;
    } forEach (_ship getVariable ["gsri_opex_availableBedrooms", []]);

    // When crew quarters are loaded, any respawn on the ship should be redirected to rooms
    player addEventHandler ["Respawn", {
        //params["_unit", "_corpse"];
        params["_unit"];
        _unit setVariable ["GSRI_FREMM_respawnTimestamp", time];
    }];
    private _trigger = createTrigger ["EmptyDetector", _ship, false];
    _trigger setPosWorld (_ship modelToWorldWorld [1.31018,-1.11719,7.27226]);
    _trigger setTriggerArea [2, 2, 0, false, 2];
    _trigger setTriggerActivation ["WEST", "PRESENT", true];
    _trigger setTriggerStatements ["this","call GSRI_fnc_crewMoveToCabin", ""];
};
