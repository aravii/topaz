-----------------------------------
-- Area: Batallia Downs
--   NM: Prankster Maverix
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:addMod(tpz.mod.REGAIN, 50)
end

function onMobDeath(mob, player, isKiller)
end
