-- i keeped it off because i didnt wanna copy paste that for years
if not workspace[game.Players.LocalPlayer.Name]:FindFirstChild(TheHatLol) then
			local sound = Instance.new("Sound", game.StarterGui)
		sound.SoundId = "rbxassetid://8426701399"
		sound.Volume = 3
		sound:Play()
		game.StarterGui:SetCore("SendNotification", {
			Title = "Spirit Hub",
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
			Title = "Spirit Hub",
			Text = "Missing Hat: ".. TheHatLol2
		})
		wait(2)
		sound:Destroy()
		return
end
