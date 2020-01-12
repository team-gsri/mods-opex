class CfgPatches {
    class gsri_opex {
        units[]={};
        requiredVersion=0.1;
        requiredAddons[]={"A3_Boat_F_Destroyer"};
        author="[-GSRI-] Cheitan";
    };
};

class CfgVehicles {
    // Make 651 as the default hull number
    class Land_Destroyer_01_hull_01_F;
    class GSRI_Normandie_hull_01 : Land_Destroyer_01_hull_01_F {
        hiddenSelectionsTextures[]={
            "A3\Boat_F_Destroyer\Destroyer_01\Data\Destroyer_01_N_06_co.paa",
            "A3\Boat_F_Destroyer\Destroyer_01\Data\Destroyer_01_N_05_co.paa",
            "A3\Boat_F_Destroyer\Destroyer_01\Data\Destroyer_01_N_01_co.paa"
        };
    };
    // Make "Normandie" the default ship name
    class Land_Destroyer_01_hull_05_F;
    class GSRI_Normandie_hull_05 : Land_Destroyer_01_hull_05_F {
        hiddenSelectionsTextures[]={"gsri_opex\images\normandie.paa"};
    };
    // Make the flag display french colors
    class ShipFlag_US_F;
    class GSRI_Normandie_Flag : ShipFlag_US_F {
        class EventHandlers {
            init="(_this select 0) setFlagTexture 'gsri_opex\images\flag_fr.paa'";
        };
    };

    class StaticShip;
    class Land_Destroyer_01_base_F : StaticShip {
        class Attributes {
            class CustomShipNumber1;
            class CustomShipNumber2;
            class CustomShipNumber3;
            class CustomShipNameTexture0;
            class CustomShipFlagTexture0;
        };
        class EventHandlers;
    };
    class GSRI_Normandie : Land_Destroyer_01_base_F {
        displayname="$STR_GSRI_frigate_displayName";
        multiStructureParts[]={
			{"GSRI_Normandie_hull_01","pos_hull_1"},
			{"Land_Destroyer_01_hull_02_F","pos_hull_2"},
			{"Land_Destroyer_01_hull_03_F","pos_hull_3"},
			{"Land_Destroyer_01_hull_04_F","pos_hull_4"},
			{"GSRI_Normandie_hull_05","pos_hull_5"},
			{"Land_Destroyer_01_interior_02_F","pos_hull_2"},
			{"Land_Destroyer_01_interior_03_F","pos_hull_3"},
			{"Land_Destroyer_01_interior_04_F","pos_hull_4"},
			{"Land_HelipadEmpty_F","pos_heliPad"},
			{"GSRI_Normandie_Flag","pos_Flag"}
		};
        class Attributes : Attributes {
            class GSRI_frigate_attribute_addWeapons {
                displayName="$STR_GSRI_frigate_addWeaponsTitle";
                tooltip="$STR_GSRI_frigate_addWeaponsTooltip";
                property="GSRI_frigate_addWeaponsProperty";
                control="Checkbox";
                expression="_this setVariable ['%s',_value];";
                defaultValue="1";
                typeName = "BOOL";
            };
            class CustomShipNumber1 : CustomShipNumber1 {
                defaultValue="6";
                expression="[([_this, 'GSRI_Normandie_hull_01'] call bis_fnc_destroyer01GetShipPart), _value, 0] spawn bis_fnc_destroyer01InitHullNumbers;";
            };
            class CustomShipNumber2 : CustomShipNumber2 {
                defaultValue="5";
                expression="[([_this, 'GSRI_Normandie_hull_01'] call bis_fnc_destroyer01GetShipPart), _value, 1] spawn bis_fnc_destroyer01InitHullNumbers;";
            };
            class CustomShipNumber3 : CustomShipNumber3 {
                defaultValue="1";
                expression="[([_this, 'GSRI_Normandie_hull_01'] call bis_fnc_destroyer01GetShipPart), _value, 2] spawn bis_fnc_destroyer01InitHullNumbers;";
            };
            class CustomShipNameTexture0 : CustomShipNameTexture0 {
                defaultValue="'gsri_opex\images\normandie.paa'";
                expression="([_this, 'GSRI_Normandie_hull_05'] call bis_fnc_destroyer01GetShipPart) setObjectTextureGlobal [0, _value];";
            };
            class CustomShipFlagTexture0 : CustomShipFlagTexture0 {
                defaultValue="'gsri_opex\images\flag_fr.paa'";
                expression="([_this, 'GSRI_Normandie_Flag'] call bis_fnc_destroyer01GetShipPart) setObjectTextureGlobal [0, _value];";
            };
        };
        class EventHandlers : EventHandlers {
            init = "_this call GSRI_fnc_libertyInit;";
            // TODO : retaper le spawn des armes, qui ont tendance à finir au fond de l'eau
            dragged3DEN = "_this call GSRI_fnc_libertyUpdate;";
        };
    };
};

class CfgFunctions {
	class GSRI {
		class liberty {
            file="gsri_opex\functions\liberty";
			class libertyArsenal {};
			class libertyPreslots {};
			class libertyBays {};
			class libertyBridge {};
			class libertyWeapons {};
			class libertyInit {};
            class libertyUpdate {};
			class libertyBayReplace {};
		};
		class heli {
            file="gsri_opex\functions\heli";
			class getHeli {};
			class spawnHeli {};
			class initHeli {};
			class minifyName {};
			class addCleaningAction {};
			class addFRIESAction {};
		};
		class submarine {
            file="gsri_opex\functions\submarine";
			class initSubmarine {};
			class submarineSelectPos {};
		};
		class preslots {
            file="gsri_opex\functions\preslots";
			class getSoldier {};
			class getGrenadier {};
			class getMedic {};
			class getGunner {};
			class getDiver {};
		};
	};
};