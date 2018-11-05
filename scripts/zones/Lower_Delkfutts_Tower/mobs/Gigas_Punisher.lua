-----------------------------------
-- Area: Lower Delkfutt's Tower
--  MOB: Gigas Punisher
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    dsp.regime.checkRegime(player, mob, 778, 2, dsp.regime.type.GROUNDS)
end;