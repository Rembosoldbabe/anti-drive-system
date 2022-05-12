
#include <a_samp>

#define MAX_WARININGS (3)

static warnings[MAX_PLAYERS char] = {0,...};

public OnFilterScriptInit()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    warnings{i} = 0;
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	warnings{playerid} = 0;
	return 1;
}

public OnPlayerDisconnect(playerid)
{
	warnings{playerid} = 0;
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid)
{
	new str[60];
	new Float:hp;
	GetPlayerHealth(playerid, hp);
	if(IsPlayerNPC(issuerid) || !IsPlayerInAnyVehicle(issuerid)) return 0;
	if(weaponid > 21 && weaponid < 34 || weaponid == 38)
	{
	    SetPlayerHealth(playerid, hp);
		TogglePlayerControllable(issuerid, 0);
		warnings{issuerid} ++;
		if(warnings{issuerid} < MAX_WARININGS)
		{
		    format(str, sizeof(str), "{FFFFFF}Ardajexot Maqanit Aravis {FF0000}%d{FFFFFF}/{FF0000}%d", warnings{issuerid}, MAX_WARININGS);
		    ShowPlayerDialog(issuerid, 12221, DIALOG_STYLE_MSGBOX, "{FF0000}Drive-By", str, "Ok", "");
		    TogglePlayerControllable(issuerid, 1);
		}
		if(warnings{issuerid} >= MAX_WARININGS)
		{
		    ShowPlayerDialog(issuerid, 12221, DIALOG_STYLE_MSGBOX, "{FF0000}Drive-By", "{FF0000}Tqven Gaikiket Antidrives gamo", "Ok", "");
		    SetTimerEx("KickPlayer", 200, false, "i", issuerid);
		}
	}
	return 0;
}

forward KickPlayer(playerid);

public KickPlayer(playerid)
{
	return Kick(playerid);
}
