---------------------------------------------------------------------------------------------------
-- func: !checkquest <logID> <questID> {player}
-- desc: Prints status of the quest to the in game chatlog
---------------------------------------------------------------------------------------------------

require("scripts/globals/quests");

cmdprops =
{
    permission = 1,
    parameters = "sss"
};

function error(player, msg)
    player:PrintToPlayer(msg);
    player:PrintToPlayer("!checkquest <logID> <questID> {player}");
end;

function onTrigger(player,logId,questId,target)

    -- validate logId
    local questLog = GetQuestLogInfo(logId);
    if (questLog == nil) then
        error(player, "Invalid logID.");
        return;
    end
    local logName = questLog.full_name;
    logId = questLog.quest_log;

    -- validate questId
    local areaQuestIds = tpz.quest.id[tpz.quest.area[logId]];
    if (questId ~= nil) then
        questId = tonumber(questId) or areaQuestIds[string.upper(questId)];
    end
    if (questId == nil or questId < 0) then
        error(player, "Invalid questID.");
        return;
    end

    -- validate target
    local targ;
    if (target == nil) then
        targ = player:getCursorTarget();
        if (targ == nil or not targ:isPC()) then
            targ = player;
        end
    else
        targ = GetPlayerByName(target);
        if (targ == nil) then
            error(player, string.format("Player named '%s' not found!", target));
            return;
        end
    end

    -- get quest status
    local status = targ:getQuestStatus(logId,questId);
    switch (status): caseof
    {
        [0] = function (x) status = "AVAILABLE"; end,
        [1] = function (x) status = "ACCEPTED"; end,
        [2] = function (x) status = "COMPLETED"; end,
    }

    -- fetch a quest table if there is one
    local quest = tpz.quest.getQuest(logId, questId)

    local quest_status_string = ''

    -- show quest status
    if quest then
        quest_status_string = quest_status_string .. string.format("%s's status for %s quest '%s' is: %s", targ:getName(), logName, quest.name, status)
    else
        quest_status_string = quest_status_string .. string.format("%s's status for %s quest ID %i is: %s", targ:getName(), logName, questId, status )
    end

    -- print any known quest vars
    if quest then
        quest_status_string = quest_status_string .. string.format("\nCurrently on stage: %i", quest.getStage(targ))
        if quest.vars.additional then
            local quest_vars_string = ''
            for name, var in pairs(quest.vars.additional) do
                quest_vars_string = string.format(quest_vars_string.. ", %s: %i", name, quest.getVar(targ, name))
            end
            if string.len(quest_vars_string) > 1 then
                quest_vars_string = string.format("\n%s's additional quest vars are".. quest_vars_string, targ:getName())
                quest_status_string = quest_status_string .. quest_vars_string
            end
        end

        local held_items_string = '' -- See if the quest is holding any items for the player
        local held_item = quest.holdingItem(player)
        local stack = 1
        while held_item and held_item > 0 do
            held_items_string = held_items_string .. string.format(", %i", held_item)
            stack = stack + 1
            held_item = quest.holdingItem(player, stack)
        end
        if string.len(held_items_string) > 1 then
            held_items_string = string.format("\nFollowing held for %s".. held_items_string, targ:getName())
            quest_status_string = quest_status_string .. held_items_string
        end
    end

    player:PrintToPlayer(quest_status_string)
end;
