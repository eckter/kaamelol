local addon_name = "Kaamelol"
local frame_name = addon_name .. "Frame"
local frame = CreateFrame("Frame", frame_name)
local cmd_name = "/kaamelol"
local cmd_name2 = "/kl"

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
	if not msg or msg == "" then
		return false
	end

    chan, rest = strsplit(" ", msg, 2)
	if not rest then
		rest = chan
		chan = "GUILD"
	else
		chan = string.upper(chan)
		if chan == "WHISPER" then
			target, rest = strsplit(" ", rest, 2)
		else
			target = ""
		end
	end
	number = tonumber(rest)
	if number then
		rest = KAAMELOL_CONTENT[number]["FILE"]
	end
	C_ChatInfo.SendAddonMessage(addon_name, rest, chan, target);
    return true
end

function kaamelol_search(msg)
	print("\nresults:")
	for i, entry in ipairs(KAAMELOL_CONTENT) do
		local title = entry["TITLE"]
		local file = entry["FILE"]

		if string.find(string.upper(title), string.upper(msg)) then
			max_length = 256
			if string.len(title) > max_length then
				title = string.sub(title, 1, max_length) .. '...'
			end
			print(i, ":", title)
		end
	end
    return true
end

function kaamelol_run_command(cmd, args)
    if cmd == "play" or cmd == "p" then
        return kaamelol_play(args)
    elseif cmd == "broad" or cmd == "b" then
		return kaamelol_broadcast(args)
	elseif cmd == "search" or cmd == "s" then
		return kaamelol_search(args)
	else
		return kaamelol_broadcast(cmd)
	end
end

SLASH_KAAMELOL1 = cmd_name
SLASH_KAAMELOL2 = cmd_name2
SlashCmdList["KAAMELOL"] = function(msg)
    cmd, args = strsplit(" ", msg, 2)
    if not kaamelol_run_command(cmd, args) then
        print("Commandes de " .. addon_name .. " :")
        print("/kl s pas faux: recherche une citation à partir de l'extrait 'pas faux', pour retrouver son numéro")
		print("/kl 31: joue la citation numéro 31 à la guilde")
		print("Pour des commandes plus poussées, demandez à Eckter")
    end
end


function frame:CHAT_MSG_ADDON(event, prefix, msg)
	if prefix == addon_name then
		kaamelol_play(msg)
	end
end


