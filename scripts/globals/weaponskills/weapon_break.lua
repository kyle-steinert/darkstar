-----------------------------------
-- Weapon Break
-- Great Axe weapon skill
-- Skill level: 175
-- Lowers enemy's attack. Duration of effect varies with TP.
-- Lowers attack by as much as 25% if unresisted.
-- Strong against: Manticores, Orcs, Rabbits, Raptors, Sheep.
-- Immune: Crabs, Crawlers, Funguars, Quadavs, Pugils, Sahagin, Scorpion.
-- Will stack with Sneak Attack.
-- Aligned with the Thunder Gorget.
-- Aligned with the Thunder Belt.
-- Element: Water
-- Modifiers: STR:60% ; VIT:60%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
require("scripts/globals/status");
require("scripts/globals/settings");
require("scripts/globals/weaponskills");
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary)

    local params = {};
    params.numHits = 1;
    params.ftp100 = 1; params.ftp200 = 1; params.ftp300 = 1;
    params.str_wsc = 0.32; params.dex_wsc = 0.0; params.vit_wsc = 0.32; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
    params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
    params.canCrit = false;
    params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
    params.atkmulti = 1;

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.str_wsc = 0.6; params.vit_wsc = 0.6;
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, primary);

    if (damage > 0) then
        local duration = (tp/100 * 60) + 120;
        if (target:hasStatusEffect(EFFECT_ATTACK_DOWN) == false) then
            target:addStatusEffect(EFFECT_ATTACK_DOWN, 25, 0, duration);
        end
    end
    return tpHits, extraHits, criticalHit, damage;

end
