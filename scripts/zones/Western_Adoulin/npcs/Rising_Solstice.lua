-----------------------------------
-- Area: Western Adoulin
-- NPC: Rising Solstice
-- Type: Standard NPC and Quest Giver
-- !pos -154 4 -29 256
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")

local quests = tpz.quest.involvedQuests({
    require("scripts/quests/adoulin/a_certain_substitute_patrolman")
})
-----------------------------------

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    local SOA_Mission = player:getCurrentMission(SOA)

    if SOA_Mission >= tpz.mission.id.soa.LIFE_ON_THE_FRONTIER then
        if (SOA_Mission >= tpz.mission.id.soa.BEAUTY_AND_THE_BEAST) and (SOA_Mission <= tpz.mission.id.soa.SALVATION) then
            -- Speech while Arciela is 'kidnapped'
            player:startEvent(150)
        else
            if not quests.onTrigger(player, npc) then
                -- Standard dialogue, after joining colonization effort
                player:startEvent(580)
            end
        end
    else
        -- Dialogue prior to joining colonization effort
        player:startEvent(502)
    end
end;

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    quests.onEventFinish(player, csid, option)
end
