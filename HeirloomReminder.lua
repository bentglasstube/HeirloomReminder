function CheckSlot(slot)
  local itemID = GetInventoryItemID("player", slot);
  if itemID ~= nil then
    local _, _, quality = GetItemInfo(itemID);
    if quality == 7 then
      return 1;
    end
  end

  return 0;
end

function CheckAllSlots()
  local level = UnitLevel("player");
  local missing = {}

  if level < 85 then
    if CheckSlot(1)  == 0 then table.insert(missing, "helm");  end
    if CheckSlot(7)  == 0 then table.insert(missing, "legs");  end
    if CheckSlot(15) == 0 then table.insert(missing, "cloak"); end

    if level < 80 then
      if CheckSlot(3)  == 0 then table.insert(missing, "shoulders"); end
      if CheckSlot(5)  == 0 then table.insert(missing, "chest");     end
    end
  end

  local num = getn(missing)
  if num > 0 then
    local text = missing[1]
    for i = 2, num do
      text = text .. ", " .. missing[i]
    end

    ChatFrame1:AddMessage("|cffff0000Heirloom Reminder:|r |cffe6cc80Missing " .. text);
  end
end

local EventFrame = CreateFrame("Frame");
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
EventFrame:SetScript("OnEvent", function(self, event, ...)
  CheckAllSlots();
end)

