class CfgPatches {
    class gsri_opex {
        units[]={};
        requiredVersion=0.1;
        requiredAddons[]={"A3_Boat_F_Destroyer", "cba_settings", "gsri_equipment", "gsri_props", "ace_interact_menu", "Habs", "emr_main"};
        author="www.gsri.team";
        is3DENmod=1;
    };
};

class CfgVehicles {
    class Strategic;
    class StaticShip : Strategic {
        class Attributes;
    };
    class Land_Destroyer_01_base_F : StaticShip {
        class Attributes : Attributes {
            class GSRI_FREMM_selectTemplate {
                displayName = "$STR_GRSI_FREMM_selectTemplate";
                tooltip = "$STR_GRSI_FREMM_selectTemplate_tooltip";
                property = "GSRI_FREMM_selectTemplate";
                control = "Combo";
                class Values {
                    class GSRI_Normandie {
                        name = "D-651 Normandie";
                        value = "GSRI_Normandie";
                    };
                    class Custom {
                        name = "Custom ship";
                        value = "GSRI_Custom";
                    };
                    class None {
                        name = "None";
                        value = "";
                    };
                };
                expression = "_this setVariable ['%s',_value];";
                defaultValue = "None";
                typeName = "STRING";
            };
        };
    };
};

class Extended_PreInit_EventHandlers {
    class gsri_opex {
        init = "call GSRI_fnc_initSettings";
    };
};

class GSRI_FREMM_Templates {
    class GSRI_Normandie {
        class Properties {
            fullname="D-651 Normandie";
            identifier="651";
            name="Normandie";
            flag="fr\gsri\props\flags\Data\flag_fr_CO.paa";
            nameplate="fr\gsri\opex\images\normandie.paa";
            hasWeapons=1;
            hasArsenal=1;
            hasBridge=1;
            hasBoatBays=1;
            hasHelicopter=1;
            hasSubmarine=1;
            hasCrewQuarters=1;
            hasBriefingRoom=1;
            hasCommandRoom=1;
            hasParajump=1;
        };
        class AvailableBoats {
            class B_Boat_Transport_01_F {
                name="CRRC";
                liveries[]={"Black","Rescue","Civilian"};
            };
            class B_Boat_Armed_01_minigun_F {
                name=$STR_GSRI_FREMM_boatArmored;
                liveries[]={};
            };
            class C_Boat_Transport_02_F {
                name="RHIB";
                liveries[]={"Black","Civilian"};
            };
            class B_SDV_01_F {
                name="SDV";
                liveries[]={};
            };
        };
        class AvailableHelis {
            list[]={"B_Heli_Transport_01_F", "B_Heli_Attack_01_dynamicLoadout_F", "B_Heli_Light_01_dynamicLoadout_F", "B_Heli_Light_01_F", "B_T_UAV_03_dynamicLoadout_F", "MELB_AH6M", "MELB_MH6M"};
        };
    };
};

class CfgFunctions {
    class GSRI {
        class bays {
            file="fr\gsri\opex\functions\bays";
            class bayDoorControl {};
            class bayParseList {};
            class bayReplace {};
        };
        class core {
            file="fr\gsri\opex\functions\core";
            class initMission { postInit = 1 };
            class initSettings {};
        };
        class crew {
            file="fr\gsri\opex\functions\crew";
            class crewAddChairs {};
            class crewAddProps {};
            class crewMoveToCabin {};
            class crewInitBedroom {};
        };
        class door {
            file="fr\gsri\opex\functions\door";
            class doorConnect {};
            class doorGetById {};
            class createModdedDoor {};
        };
        class fremm {
            file="fr\gsri\opex\functions\fremm";
            class fremmAddArsenal {};
            class fremmAddBoatBays {};
            class fremmAddBridge {};
            class fremmAddBriefingRoom {};
            class fremmAddCrewQuarters {};
            class fremmAddCommandRoom {};
            class fremmAddHeli {};
            class fremmAddParajump {};
            class fremmAddScreens {};
            class fremmAddSub {};
            class fremmAddWeapons {};
            class initFremm {};
        };
        class heli {
            file="fr\gsri\opex\functions\heli";
            class heliAddDeckTractor {};
            class heliAddFRIES {};
            class heliAddFuelPump {};
            class heliEquipFRIES {};
            class heliMinifyName {};
            class heliRemove {};
            class heliRetrieveCurrent {};
            class heliSpawn {};
        };
        class parajump {
            file="fr\gsri\opex\functions\parajump";
            class parajumpAddWaiting {};
            class parajumpInit {};
            class parajumpLaunchPlane {};
            class parajumpRemoveWaiting {};
        };
        class screen {
            file="fr\gsri\opex\functions\screen";
            class screenGetById {};
            class screenGetBySector {};
        };
        class sub {
            file="fr\gsri\opex\functions\sub";
            class subAddControls {};
            class subAddInterior {};
            class subDeployCRRC {};
            class subRetrieveCRRC {};
            class subSelectPos {};
            class subStop {};
        };
    };
};

#include "CfgNotifications.hpp"
