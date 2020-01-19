class CfgPatches {
    class gsri_opex {
        units[]={};
        requiredVersion=0.1;
        requiredAddons[]={"A3_Boat_F_Destroyer"};
        author="[-GSRI-] Cheitan";
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
		class fremm {
            file="gsri_opex\functions\fremm";
            class initMission { postInit = 1 };
			class initFremm {};
			class fremmAddWeapons {};
			class fremmAddArsenal {};
			class fremmAddBridge {};
			class fremmAddBoatBays {};
            class fremmUpdate {};
		};
        class bays {
            file="gsri_opex\functions\bays";
			class bayReplace {};
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