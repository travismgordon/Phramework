// F3 - Folk ARPS Assign Gear Script (Server-side)
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// DECLARE VARIABLES AND FUNCTIONS

private ["_faction","_typeofUnit","_unit"];

// ====================================================================================

// DETECT unit FACTION
// The following code detects what faction the unit's slot belongs to, and stores
// it in the private variable _faction. It can also be passed as an optional parameter.

_typeofUnit = toLower (_this select 0);
_unit = _this select 1;

_faction = toLower (faction _unit);
if(count _this > 2) then
{
  _faction = toLower (_this select 2);
};

// ====================================================================================

// INSIGNIA
// This block will give units insignia on their uniforms.
[_unit,_typeofUnit] spawn {
	#include "f_assignInsignia.sqf"
};

// ====================================================================================

// DECIDE IF THE SCRIPT SHOULD RUN
// Depending on locality the script decides if it should run

if !(local _unit) exitWith {};

// ====================================================================================

// SET A PUBLIC VARIABLE
// A public variable is set on the unit, indicating their type. This is mostly relevant for the F3 respawn component

_unit setVariable ["f_var_assignGear",_typeofUnit,true];

// ====================================================================================

// DECLARE VARIABLES AND FUNCTIONS 2

private [
"_glrifle","_glriflemag","_glriflemag_tr","_glmag",
"_glsmokewhite","_glsmokegreen","_glsmokered",
"_glflarewhite","_glflarered","_glflareyellow","_glflaregreen",
"_AR","_ARmag","_ARmag_tr",
"_MMG","_MMGmag","_MMGmag_tr",
"_HMG","_HMGmount",
"_RAT","_RATmag",
"_MAT","_MATmag1","_MATmag2",
"_HAT","_HATmag1","_HATmag2",
"_MTR","_MTRmount",
"_RAA","_RAAmag",
"_SNrifle","_SNriflemag",
"_pistol","_pistolmag",
"_grenade","_smokegrenade","_smokegrenadegreen",
"_rifle","_riflemag","_riflemag_tr",
"_carbine","_carbinemag","_carbinemag_tr",
"_smg","_smgmag","_smgmag_tr",
"_bagsmall","_bagmedium","_baglarge",
"_ATmine","_satchel",
"_medkit","_rifle_attach",
"_carbine_attach","_smg_attach",
"_glrifle_attach","_AR_attach",
"_MMG_attach","_SNrifle_attach"
,"_APmine", "_nvg",
"_chemgreen","_chemred","_chemblue","_chemyellow"
];

// ====================================================================================

// This variable simply tracks the progress of the gear assignation process, for other
// scripts to reference.

_unit setVariable ["f_var_assignGear_done",false,true];

// ====================================================================================

// DEBUG
if (f_var_debugMode == 1) then
{
	_unit sideChat format ["DEBUG (assignGear.sqf): unit faction: %1",_faction];
};

// ====================================================================================

// ====================================================================================

// GEAR: BLUFOR > NATO
// The following block of code executes only if the unit is in a NATO slot; it
// automatically includes a file which contains the appropriate equipment data.


if (_faction == "blu_f") then {
#include "f_assignGear_nato.sqf"
};


// ====================================================================================

// GEAR: OPFOR > CSAT
// The following block of code executes only if the unit is in a CSAT slot; it
// automatically includes a file which contains the appropriate equipment data.

if (_faction == "opf_f") then {
	#include "f_assignGear_csat.sqf"
};

// ====================================================================================

// GEAR: INDEPEDENT > AAF
// The following block of code executes only if the unit is in a AAF slot; it
// automatically includes a file which contains the appropriate equipment data.

if(_faction == "ind_f") then {
	#include "f_assignGear_aaf.sqf";
};

// ====================================================================================

// This variable simply tracks the progress of the gear assignation process, for other
// scripts to reference.

_unit setVariable ["f_var_assignGear_done",true,true];

// ====================================================================================

// DEBUG

// ====================================================================================

// ERROR CHECKING
// If the faction of the unit cannot be defined, the script exits with an error.

if (isNil "_carbine") then { //_carbine should exist unless no faction has been called
	player globalchat format ["DEBUG (assignGear.sqf): Faction %1 is not defined.",_faction];
} else {
 	if (f_var_debugMode == 1) then	{
		player sideChat format ["DEBUG (assignGear.sqf): Gear for %1: %1 slot selected.",_unit,_faction,_typeofUnit];
	};
};

// ====================================================================================
