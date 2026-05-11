-- Utils Module
-- Berisi utility functions yang reusable untuk Music System

local Utils = {}

-- ===== COOLDOWN MANAGEMENT =====
-- Tracking table untuk cooldown (harus disimpan di caller)
-- Usage: 
--   local lastReqAt = {}
--   if Utils.isOnCooldown(lastReqAt, player.UserId, 5) then return end

function Utils.isOnCooldown(lastTbl: {[number]: number}, uid: number, cd: number): boolean
	local now = os.clock()
	local prev = lastTbl[uid]
	if prev and (now - prev) < cd then 
		return true 
	end
	lastTbl[uid] = now
	return false
end

-- ===== UI UTILITIES =====
-- Clear all children dari frame kecuali template
function Utils.clearFrame(frame: Frame, template: GuiObject?)
	for _, child in ipairs(frame:GetChildren()) do
		if child:IsA("TextButton") and child ~= template then
			child:Destroy()
		end
	end
end

-- ===== SORTING =====
-- Sort list secara alfabetis (case-insensitive)
function Utils.sortAlphabetically(list: {string}): {string}
	table.sort(list, function(a, b)
		return string.lower(a) < string.lower(b)
	end)
	return list
end

-- Sort table by keys alfabetis
function Utils.getSortedKeys(tbl: {[string]: any}): {string}
	local keys = {}
	for key in pairs(tbl) do
		table.insert(keys, key)
	end
	table.sort(keys, function(a, b)
		return string.lower(a) < string.lower(b)
	end)
	return keys
end

-- ===== AUTHORIZATION (Placeholder - bisa dikustomisasi) =====
-- Cek apakah player punya akses (default: semua player)
function Utils.hasAccess(player: Player): boolean
	return true
end

-- Cek apakah player bisa reorder queue (default: semua player)
function Utils.canReorder(player: Player): boolean
	return true
end

return Utils
