#define mag_2(a) a, a
#define mag_3(a) a, a, a
#define mag_4(a) a, a, a, a
#define mag_5(a) a, a, a, a, a
#define mag_6(a) a, a, a, a, a, a
#define mag_7(a) a, a, a, a, a, a, a
#define mag_8(a) a, a, a, a, a, a, a, a
#define mag_9(a) a, a, a, a, a, a, a, a, a
#define mag_10(a) a, a, a, a, a, a, a, a, a, a

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
        displayName = $STR_GSRI_faction;
    };
};

class CfgWeapons {
    class SMA_MK18MOEOD;
    class GSRI_rifle_base : SMA_MK18MOEOD {
        scope = 1;
        class LinkedItems {
            class LinkedItemsOptic {
                slot = "asdg_OpticRail_SMAAssault";
                item = "optic_MRCO";
            };
            class LinkedItemsBipod {
                slot = "asdg_Underbarrel";
                item = "SMA_Gripod_01";
            };
            class LinkedItemsMuzzle {
                slot = "MuzzleSlot";
                item = "sma_gemtech_one_wdl";
            };
        };
    };
};

class CfgVehicles {
    class B_Soldier_F;
    class GSRI_Soldier_base : B_Soldier_F {
        faction = "GSRI";
        author = "www.gsri.team";
        displayName = $STR_GSRI_regular;
        uniformClass = "GSRI_uniform";
        weapons[] = {"Throw", "Put"};
        respawnWeapons[] = {"Throw", "Put"};
        items[] = {};
        respawnItems[] = {};
        linkedItems[] = {"GSRI_beret", "ItemMap", "ItemWatch"};
        respawnLinkedItems[] = {"GSRI_beret", "ItemMap", "ItemWatch"};
        magazines[] = {};
        respawnMagazines[] = {};
    };
    class GSRI_Soldier_operator : GSRI_Soldier_base {
        displayName = $STR_GSRI_operator;
        weapons[] += {"GSRI_rifle_base"};
        respawnWeapons[] += {"GSRI_rifle_base"};
        linkedItems[] = {"GSRI_vest_carrier", "GSRI_helmet_modular", "GSRI_balaclava_v2_dark", "TFAR_anprc152", "ItemWatch"};
        respawnLinkedItems[] = {"GSRI_vest_carrier", "GSRI_helmet_modular", "GSRI_balaclava_v2_dark", "TFAR_anprc152", "ItemWatch"};
        magazines[] = {mag_10("ACE_30Rnd_556x45_Stanag_Mk318_mag"), mag_3("SmokeShell"), mag_3("ACE_M84")};
        respawnMagazines[] = {mag_10("ACE_30Rnd_556x45_Stanag_Mk318_mag"), mag_3("SmokeShell"), mag_3("ACE_M84")};
        items[] = {mag_10("ACE_quikclot"), mag_4("ACE_splint"), mag_4("ACE_tourniquet"), mag_2("ACE_morphine"), "ACE_EarPlugs", mag_4("ACE_CableTie"), mag_2("ACE_MRE_LambCurry"), mag_4("ACE_WaterBottle")};
        respawnItems[] = {mag_10("ACE_quikclot"), mag_4("ACE_splint"), mag_4("ACE_tourniquet"), mag_2("ACE_morphine"), "ACE_EarPlugs", mag_4("ACE_CableTie"), mag_2("ACE_MRE_LambCurry"), mag_4("ACE_WaterBottle")};
    };
};
