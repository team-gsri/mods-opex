class CfgPatches {
    class gsri_units {
        units[]={};
        requiredVersion=0.1;
        requiredAddons[]={};
        author="www.gsri.team";
    };
};

class CfgFactionClasses {
    class BLU_F;
    class GSRI : BLU_F {
        displayName = $STR_GRSI_faction;
    };
};

class CfgVehicles {
    class B_Soldier_F;
    class GSRI_Soldier_base : B_Soldier_F {
        faction = "GSRI";
        author = "www.gsri.team";
        displayName = $STR_GRSI_regular;
        uniformClass = "GSRI_uniform";
        weapons[] = {"Throw", "Put"};
        respawnWeapons[] = {"Throw", "Put"};
        items[] = {};
        respawnItems[] = {};
        linkedItems[] = {"GSRI_beret", "ItemMap"};
        respawnLinkedItems[] = {"GSRI_beret", "ItemMap"};
        magazines[] = {};
        respawnMagazines[] = {};
    };
};
