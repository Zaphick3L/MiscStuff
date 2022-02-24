if not workspace[game.Players.LocalPlayer.Name]:FindFirstChild("Raw") then
			local sound = Instance.new("Sound", game.StarterGui)
		sound.SoundId = "rbxassetid://8426701399"
		sound.Volume = 3
		sound:Play()
		game.StarterGui:SetCore("SendNotification", {
			Title = "Unim Hub",
			Text = "Not Reanimated!"
		})
		wait(2)
		sound:Destroy()
		return
end

if not workspace[game.Players.LocalPlayer.Name]:FindFirstChild(TheHatLol) then
			local sound = Instance.new("Sound", game.StarterGui)
		sound.SoundId = "rbxassetid://8426701399"
		sound.Volume = 3
		sound:Play()
		game.StarterGui:SetCore("SendNotification", {
			Title = "Unim Hub",
			Text = "Missing Hat: ".. TheHatLol
		})
		wait(2)
		sound:Destroy()
		return
end

if not workspace[game.Players.LocalPlayer.Name]:FindFirstChild(TheHatLol2) then
			local sound = Instance.new("Sound", game.StarterGui)
		sound.SoundId = "rbxassetid://8426701399"
		sound.Volume = 3
		sound:Play()
		game.StarterGui:SetCore("SendNotification", {
			Title = "Unim Hub",
			Text = "Missing Hat: ".. TheHatLol2
		})
		wait(2)
		sound:Destroy()
		return
end

if workspace[game.Players.LocalPlayer.Name]:FindFirstChild("NoYouWillNotRunScriptAgain.") then
		local sound = Instance.new("Sound", game.StarterGui)
		sound.SoundId = "rbxassetid://8426701399"
		sound.Volume = 3
		sound:Play()
		game.StarterGui:SetCore("SendNotification", {
			Title = "Unim Hub",
			Text = "Script is already Running! Reset to change a script."
		})
		wait(2)
		sound:Destroy()
		return
end

local fufufuff = Instance.new("Part", workspace[game.Players.LocalPlayer.Name])
fufufuff.Anchored = true;fufufuff.Transparency = 1;fufufuff.CanCollide = false;fufufuff.Name = "NoYouWillNotRunScriptAgain."
