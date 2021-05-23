class CfgPatches
{
	class gsri_flags
	{
		author = "www.gsri.team";
		requiredAddons[] = { "A3_Structures_F_Mil_Flags", "A3_Structures_F" };
		units[] = { "gsri_flags_gsri", "gsri_flags_fr" };
		weapons[] = {};
	};
};


class CfgVehicles
{	class FlagCarrier;
	class gsri_flags_gsri : FlagCarrier
	{
		author="www.gsri.team";
		class SimpleObject
		{
			eden=0;
			animate[]=
			{				
				{
					"flag",
					0
				}
			};
			hide[]={};
			verticalOffset=3.977;
			verticalOffsetWorld=0;
			init="''";
		};
		editorPreview="\fr\gsri\flags\flag_gsri.jpg";
		scope=2;
		scopeCurator=2;
		displayName="$STR_GSRI_FLAG_GSRI";
		hiddenSelectionsTextures[]=
		{
			"\A3\Structures_F\Mil\Flags\Data\Mast_mil_CO.paa"
		};
		hiddenSelectionsMaterials[]=
		{
			"\A3\Structures_F\Mil\Flags\Data\Mast_mil.rvmat"
		};
		class EventHandlers
		{
			init="(_this select 0) setFlagTexture '\fr\gsri\flags\flag_gsri_CO.paa'";
		};
	};

	class gsri_flags_fr : FlagCarrier
	{
		author="www.gsri.team";
		class SimpleObject
		{
			eden=0;
			animate[]=
			{				
				{
					"flag",
					0
				}
			};
			hide[]={};
			verticalOffset=3.977;
			verticalOffsetWorld=0;
			init="''";
		};
		editorPreview="\fr\gsri\flags\flag_fr.jpg";
		scope=2;
		scopeCurator=2;
		displayName="$STR_GSRI_FLAG_FR";
		hiddenSelectionsTextures[]=
		{
			"\A3\Structures_F\Mil\Flags\Data\Mast_mil_CO.paa"
		};
		hiddenSelectionsMaterials[]=
		{
			"\A3\Structures_F\Mil\Flags\Data\Mast_mil.rvmat"
		};
		class EventHandlers
		{
			init="(_this select 0) setFlagTexture '\fr\gsri\flags\flag_fr_CO.paa'";
		};
	};
}