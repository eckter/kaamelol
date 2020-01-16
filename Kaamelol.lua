local addon_name = "Kaamelol"
local frame_name = addon_name .. "Frame"
local frame = CreateFrame("Frame", frame_name)
local cmd_name = "/kaamelol"

C_ChatInfo.RegisterAddonMessagePrefix(addon_name)

frame:RegisterEvent("CHAT_MSG_ADDON")

frame:SetScript("OnEvent", function(self, event_name, ...)
    return self[event_name](self, event_name, ...)
end)

function kaamelol_play(msg)
	root = "Interface/AddOns/" .. addon_name .. "/sounds/"
	path = root .. msg .. ".mp3"
	PlaySoundFile(path, "Master")
    return true
end

function kaamelol_broadcast(msg)
    chan, rest = strsplit(" ", msg, 2)
	chan = string.upper(chan)
	if chan == "WHISPER" then
		target, rest = strsplit(" ", rest, 2)
	else
		target = ""
	end
	C_ChatInfo.SendAddonMessage(addon_name, rest, chan, target);
    return true
end

function kaamelol_run_command(cmd, args)
    if cmd == "play" then
        return kaamelol_play(args)
    elseif cmd == "broad" then
		return kaamelol_broadcast(args)
	else
		return false
	end
end

SLASH_KAAMELOL1 = cmd_name
SlashCmdList["KAAMELOL"] = function(msg)
    cmd, args = strsplit(" ", msg, 2)
    if not kaamelol_run_command(cmd, args) then
        print(addon_name .. " usage:")
    end
end


function frame:CHAT_MSG_ADDON(event, prefix, msg)
	if prefix == addon_name then
		kaamelol_play(msg)
	end
end


