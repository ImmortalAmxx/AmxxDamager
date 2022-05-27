#include <AmxModX>
#include <ReApi>

//#define ZP43_Support
#if defined ZP43_Support
    #include <ZombiePlague>
#endif

new const szPluginInfo[][] = {
    "[ReAPI] Addon: Damager",
    "0.1",
    "ImmortalAmxx"
};

public plugin_init() {
    register_plugin(
        .plugin_name = szPluginInfo[0],
        .version = szPluginInfo[1],
        .author = szPluginInfo[2]
    );

    RegisterHookChain(RG_CBasePlayer_TakeDamage, "RG_CBasePlayer_TakeDamage_Post", .post = true);
}

public RG_CBasePlayer_TakeDamage_Post(iVictim, pevInflictor, iAttacker, Float:flDamage) {
    if(!is_user_connected(iAttacker)) 
        return HC_CONTINUE;

    #if defined ZP43_Support
        if(zp_get_user_zombie(iAttacker) || zp_get_user_nemesis(iAttacker))
            client_print(iAttacker, print_center, "Жизней: %1.f | Брони: %1.f", get_entvar(iVictim, var_health), get_entvar(iVictim, var_armorvalue));
        else
            client_print(iAttacker, print_center, "Урон: %1.f | Жизней: %1.f", flDamage, get_entvar(iVictim, var_health));
    #else
        client_print(iAttacker, print_center, "Урон: %1.f | Жизней: %1.f", flDamage, get_entvar(iVictim, var_health));
    #endif

    return HC_CONTINUE;
}