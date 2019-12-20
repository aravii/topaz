-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--  Mob: Dark Aspic
-- Note: PH for Sewer Syrup
-----------------------------------
local ID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 610, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.SEWER_SYRUP_PH, 10, math.random(7200, 14400)) -- 2 to 4 hours
end
