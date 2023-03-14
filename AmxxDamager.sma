/**
	Благодарности: b0t. (Помощь с get_gametime());
*/

#include <amxmodx>
#include <reapi>
#include <zombieplague>

const Float:g_fStreakRemove = 3.0; // Время стрика.

public plugin_init()
{
    register_plugin("[ZP 4.3] Addon: Damager", "1.0.0", "ImmortalAmxx");

    RegisterHookChain(RG_CBasePlayer_TakeDamage, "CBasePlayer_TakeDamage_Post", true);
}

public CBasePlayer_TakeDamage_Post(VictimId, iInflictor, AttackerId, Float: flDamage, iBitsType)
{
    if(!is_user_connected(AttackerId))
    {
        return;
    }

    static Float:fStreakDamage[33], Float:p_fGameTime[33];
    
	if(get_gametime() >= p_fGameTime[AttackerId])
	{
		fStreakDamage[AttackerId] = flDamage;
	}
	else
	{
		fStreakDamage[AttackerId] += flDamage;
	}
	
    p_fGameTime[AttackerId] = get_gametime() + g_fStreakRemove;

    if(zp_get_user_zombie(VictimId) || zp_get_user_nemesis(VictimId))
    {
        client_print(AttackerId,print_center,
            "Жизни: %.0f | Урон: %.0f | Стрик: %.0f",
            Float:get_entvar(VictimId,var_health),
            flDamage,
            fStreakDamage[AttackerId]
        );
    }
    else
    {
        client_print(AttackerId, print_center,
        "Жизни: %.0f | Брони: %.0f",
            Float:get_entvar(VictimId, var_health), 
            Float:get_entvar(VictimId, var_armorvalue)
        );
    }
}
