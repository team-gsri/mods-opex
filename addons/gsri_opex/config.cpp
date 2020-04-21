class CfgPatches {
    class gsri_opex {
        units[]={};
        requiredVersion=0.1;
        requiredAddons[]={"A3_Boat_F_Destroyer", "cba_settings"};
        author="[-GSRI-] Cheitan";
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
				};
				expression = "_this setVariable ['%s',_value];";
				defaultValue = "GSRI_Normandie";
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
        fullname="D-651 Normandie";
        identifier="651";
        name="Normandie";
        flag="gsri_opex\images\flag_fr.paa";
        nameplate="gsri_opex\images\normandie.paa";
        hasWeapons=1;
        hasArsenal=1;
        hasBridge=1;
        hasBoatBays=1;
        hasHelicopter=1;
        hasSubmarine=1;
    };
};

class CfgFunctions {
	class GSRI {
		class core {
			file="gsri_opex\functions\core";
            class initMission { postInit = 1 };
			class initSettings {};
		};
		class fremm {
            file="gsri_opex\functions\fremm";
			class initFremm {};
			class fremmAddWeapons {};
			class fremmAddArsenal {};
			class fremmAddBridge {};
			class fremmAddBoatBays {};
			class fremmAddHeli {};
			class fremmAddSub {};
		};
        class bays {
            file="gsri_opex\functions\bays";
			class bayReplace {};
        };
		class heli {
            file="gsri_opex\functions\heli";
			class heliMinifyName {};
			class heliRetrieveCurrent {};
			class heliSpawn {};
			class heliRemove {};
			class heliEquipFRIES {};
		};
		class sub {
            file="gsri_opex\functions\sub";
			class subSelectPos {};
		};
		class preslots {
            file="gsri_opex\functions\preslots";
			class getSoldier {};
			class getGrenadier {};
			class getMedic {};
			class getGunner {};
			class getDiver {};
			class getEmpty {};
			class setAsLocker {};
		};
	};
};

#include "CfgNotifications.hpp"