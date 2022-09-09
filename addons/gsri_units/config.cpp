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
    class arifle_SPAR_01_blk_F;
    class GSRI_autorifle_base : arifle_SPAR_01_blk_F {
        scope = 1;
        class LinkedItems {
            class LinkedItemsOptic {
                slot = "CowsSlot";
                item = "optic_MRCO";
            };
            class LinkedItemsBipod {
                slot = "UnderBarrelSlot";
                item = "bipod_01_F_blk";
            };
            class LinkedItemsMuzzle {
                slot = "MuzzleSlot";
                item = "muzzle_snds_M";
            };
        };
    };
};

class CfgVehicles {
    class GSRI_Kitbag;
    class GSRI_backpack_medic : GSRI_Kitbag {
        scope = 1;
        class TransportItems {
            class _xx_ACE_packingBandage {
                name = "ACE_packingBandage";
                count = 30;
            };
            class _xx_ACE_salineIV_500 {
                name = "ACE_salineIV_500";
                count = 15;
            };
            class _xx_ACE_morphine {
                name = "ACE_morphine";
                count = 10;
            };
            class _xx_ACE_epinephrine {
                name = "ACE_epinephrine";
                count = 10;
            };
            class _xx_ACE_splint {
                name = "ACE_splint";
                count = 10;
            };
            class _xx_ACE_surgicalKit {
                name = "ACE_surgicalKit";
                count = 1;
            };
        };
    };

    class B_Soldier_F;
    class GSRI_Soldier_base : B_Soldier_F {
        faction = "GSRI";
        author = "www.gsri.team";
        displayName = $STR_GSRI_soldier_regular;
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
        displayName = $STR_GSRI_soldier_operator;
        weapons[] += {"GSRI_rifle_base"};
        respawnWeapons[] += {"GSRI_rifle_base"};
        linkedItems[] = {"GSRI_vest_carrier", "GSRI_helmet_modular", "GSRI_balaclava_v2_dark", "TFAR_anprc152", "ItemWatch"};
        respawnLinkedItems[] = {"GSRI_vest_carrier", "GSRI_helmet_modular", "GSRI_balaclava_v2_dark", "TFAR_anprc152", "ItemWatch"};
        magazines[] = {mag_10("ACE_30Rnd_556x45_Stanag_Mk318_mag"), mag_3("SmokeShell"), mag_3("ACE_M84")};
        respawnMagazines[] = {mag_10("ACE_30Rnd_556x45_Stanag_Mk318_mag"), mag_3("SmokeShell"), mag_3("ACE_M84")};
        items[] = {mag_10("ACE_quikclot"), mag_4("ACE_splint"), mag_4("ACE_tourniquet"), mag_2("ACE_morphine"), "ACE_EarPlugs", mag_4("ACE_CableTie"), mag_2("ACE_MRE_LambCurry"), mag_4("ACE_WaterBottle"), "A3_GPNVG18_F"};
        respawnItems[] = {mag_10("ACE_quikclot"), mag_4("ACE_splint"), mag_4("ACE_tourniquet"), mag_2("ACE_morphine"), "ACE_EarPlugs", mag_4("ACE_CableTie"), mag_2("ACE_MRE_LambCurry"), mag_4("ACE_WaterBottle"), "A3_GPNVG18_F"};
    };
    class GSRI_Soldier_abl : GSRI_Soldier_operator {
        displayName = $STR_GSRI_soldier_abl;
        weapons[] += {"tf47_at4_heat"};
        respawnWeapons[] += {"tf47_at4_heat"};
    };
    class GSRI_Soldier_medic : GSRI_Soldier_operator {
        displayName = $STR_GSRI_soldier_medic;
        backpack = "GSRI_backpack_medic";
    };
    class GSRI_Soldier_tad : GSRI_Soldier_operator {
        displayName = $STR_GSRI_soldier_tad;
        weapons[] = {"GSRI_autorifle_base", "Throw", "Put"};
        respawnWeapons[] = {"GSRI_autorifle_base", "Throw", "Put"};
        magazines[] = {mag_5("150Rnd_556x45_Drum_Mag_Tracer_F"), mag_4("SmokeShell"), mag_2("ACE_M84")};
        respawnMagazines[] = {mag_5("150Rnd_556x45_Drum_Mag_Tracer_F"), mag_4("SmokeShell"), mag_2("ACE_M84")};
    };
};

class CfgGroups {
    class West {
        class GSRI {
            name = $STR_GSRI_faction;
            class GSRI_Commandos {
                name = $STR_GSRI_grouptype_commando;
                class GSRI_Commandos_Delta {
                    name = STR_GSRI_group_delta;
                    faction = "GSRI";
                    side = 1;
                    icon = "\A3\ui_f\data\map\markers\nato\b_inf.paa";
                    class Unit0 {
                        side = 1;
                        vehicle = "GSRI_Soldier_operator";
                        rank = "SERGEANT";
                        position[] = {0,0,0};
                    };
                    class Unit1 {
                        side = 1;
                        vehicle = "GSRI_Soldier_abl";
                        rank = "SOLDIER";
                        position[] = {-2,-2,0};
                    };
                    class Unit2 {
                        side = 1;
                        vehicle = "GSRI_Soldier_medic";
                        rank = "SOLDIER";
                        position[] = {2,-2,0};
                    };
                    class Unit3 {
                        side = 1;
                        vehicle = "GSRI_Soldier_tad";
                        rank = "SOLDIER";
                        position[] = {4,-4,0};
                    };
                };
            };
        };
    };
};
