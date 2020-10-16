class CfgNotifications {
	class SubmarineOk {
		title = "GSRI Insertion System";
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
		iconText = "";
		description = "$STR_GSRI_FREMM_submarineOk";
		color[] = {1,1,1,1};
		duration = 5;
		priority = 0;
		difficulty[] = {};
	};
	class SubmarineFail : SubmarineOk {
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
		description = "$STR_GSRI_FREMM_submarineFail";
	};
	class SubmarineInfo : SubmarineOk {
		iconPicture = "\A3\ui_f\data\map\mapcontrol\quay_ca.paa";
		description = "$STR_GSRI_FREMM_submarineInfo";
	};
	class HeliInfo {
		title = "GSRI Insertion System";
		iconPicture = "\A3\ui_f\data\map\vehicleicons\iconhelicopter_ca.paa";
		iconText = "";
		description = "$STR_GSRI_FREMM_heliInfo";
		color[] = {1,1,1,1};
		duration = 5;
		priority = 0;
		difficulty[] = {};
	};
	class HeliDelete : HeliInfo {
		description = "$STR_GSRI_FREMM_heliDelete";
	};
	class HeliMoved : HeliInfo {
		description = "$STR_GSRI_FREMM_heliMoved";
	};
	class HeliFRIES : HeliInfo {
		description = "$STR_GSRI_FREMM_heliFRIES";
	};
};