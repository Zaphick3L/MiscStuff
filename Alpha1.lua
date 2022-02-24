_G.EnableAnimations = false
_G.Net = false
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zaphick3L/MiscStuff/main/UILibrary.lua"))()
local main = lib:Create("Unim Hub")
local HomeTab = main:Tab("Home")
local ReanimateTab = main:Tab("Reanimate")
local HatScriptTab = main:Tab("Hat Scripts")
HomeTab:Label("Version: ALPHA 1")
ReanimateTab:Toggle("Enable Animations", function(a)
	_G.EnableAnimations = a
end)

ReanimateTab:Toggle("Enable Net Bypass", function(a)
	_G.Net = a
	spawn(function() while _G.Net do game:GetService("RunService").Stepped:Wait()
		setsimulationradius(1000,1000)
		game.Players.LocalPlayer.MaximumSimulationRadius = 1000
	end end)
end)

ReanimateTab:Button("Fling Reanimate", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Zaphick3L/MiscStuff/main/FlingReanimate.lua"))()
end)

ReanimateTab:Button("Bullet Reanimate", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Zaphick3L/MiscStuff/main/BulletReanimation.lua"))()
end)

HatScriptTab:HatScript("Dark Katana","6655796738", function()
	TheHatLol = "B&WKatanaAccessory"
	TheHatLol2 = TheHatLol -- "Police K4LAS [Front]"
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Zaphick3L/MiscStuff/main/ScriptStuff.lua"))()

	if _G.BulletReanimate == true then
		local bulchar = workspace[game.Players.LocalPlayer.Name]
		local bullet = bulchar:FindFirstChild("LowerTorso") or bulchar:FindFirstChild("Right Leg")
		_G.Disconnect = true

		local highlight = Instance.new("SelectionBox",bullet)
		highlight.Adornee = bullet
		local bp = Instance.new("BodyPosition", bullet)
		bp.MaxForce = Vector3.new(9e9,9e9,9e9)
		bp.D = 125
		bp.P = 40000
		local mouse = game.Players.LocalPlayer:GetMouse()
		local mousehold = false
		mouse.Button1Down:Connect(function()
			mousehold = true
			wait(0.4)
			mousehold = false
		end)
				
		local bulletloop
		local function fling()
			setsimulationradius(1000)
			local t = 5
			local hue = tick() % t / t -- took rainbow thing from project cat v1
			highlight.Color3 = Color3.fromHSV(hue, 1, 1)
			
			bullet.RotVelocity = Vector3.new(17500,17500,17500)
			if mousehold then
				if mouse.Target ~= nil then
					bp.Position = bulchar:FindFirstChild("B&WKatanaAccessory").Handle.CFrame.p + Vector3.new(0,0,math.random(-1,1))
				end
			else
				bp.Position = game.Players.LocalPlayer.Character.Torso.CFrame.p + Vector3.new(0,-15,0)
			end
		end

		bulletloop = game:GetService("RunService").Heartbeat:Connect(fling)
		bulchar.Humanoid.Died:Connect(function()
			bulletloop:Disconnect()
		end)
	end
	-- takes a moment to load due to reanimate loading via loadstring (its for hub) thats why.
	-- hat: 6655796738
	Position = "Idle"
	local attacksoundid = "rbxassetid://5065732137"
	_G.AttackWait1 = 0.2
	_G.AttackWait2 = 0.2
	local Special = false
	local Attack = false
	local AttackFrame = 0
	local Locked = false
	local Player = game.Players.LocalPlayer
	local Mouse = Player:GetMouse()
	local Character = Player.Character.Raw
	Character.Animate.Disabled = true

	local Torso = Character:FindFirstChild("Torso")
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	local RS = Torso:FindFirstChild("Right Shoulder")
	local LS = Torso:FindFirstChild("Left Shoulder")
	local RH = Torso:FindFirstChild("Right Hip")
	local LH = Torso:FindFirstChild("Left Hip")
	local Root = Character:FindFirstChild("HumanoidRootPart")
	local Neck = Torso:FindFirstChild("Neck")
	local RJ = Root:FindFirstChild("RootJoint")
	local UserInputService = game:GetService("UserInputService")
	Humanoid.WalkSpeed = 45
	reanim = Character

	local Hat = Player.Character:FindFirstChild("B&WKatanaAccessory")
	local Clone = Hat:Clone()
	Clone.Parent = Character
	Clone.Handle.Transparency = 1
	local function Align(P0,P1,Position,Orientation)
		local AlignPosition = Instance.new("AlignPosition", P0)
		local AlignOrientation = Instance.new("AlignOrientation", P0)
		local Attachment1 = Instance.new("Attachment", P0)
		local Attachment2 = Instance.new("Attachment", P1)
		-- Main Attach Thingy:
		AlignPosition.Attachment0,AlignPosition.Attachment1 = Attachment1,Attachment2 -- Shortcut
		AlignOrientation.Attachment0,AlignOrientation.Attachment1 = Attachment1,Attachment2 -- Shortcut
		-- Properties:

		AlignPosition.MaxForce = 9e9
		AlignOrientation.MaxTorque = 9e9
		AlignPosition.Responsiveness = 200
		AlignOrientation.Responsiveness = 200

		-- Rotate/Position
		Attachment1.Position = Position or Vector3.new(0,0,0)
		Attachment1.Orientation = Orientation or Vector3.new(0,0,0)
	end
	Hat.Handle.AccessoryWeld:Destroy()
	Align(Hat.Handle,Clone.Handle)

	local soundeffect = Instance.new("Sound", Hat.Handle)
	soundeffect.SoundId = attacksoundid

	UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if Locked == false then
			Attack = true
			Locked = true
			AttackFrame = 1
			wait(_G.AttackWait1)
			soundeffect:Play()
			AttackFrame = 2
			wait(_G.AttackWait2)
			Attack = false
			AttackFrame = 0
			Locked = false
			end
		end
	end)


	spawn(function() while game:GetService("RunService").RenderStepped:Wait() do
		for i, v in pairs(Humanoid:GetPlayingAnimationTracks()) do
			v:Stop()
		end
		if Root.Velocity.y > 1 and Attack == false then
			Position = "Jump"
		elseif Root.Velocity.y < -1 and Attack == false and Special == false then
			Position = "Fall"
		elseif Root.Velocity.Magnitude < 2 and Attack == false and Special == false then -- idle
			Position = "Idle"
		elseif Root.Velocity.Magnitude > 20 and Attack == false and Special == false then -- idle
			Position = "Run"
		elseif Root.Velocity.Magnitude > 20 and Attack == true and Special == false and AttackFrame == 1 then -- idle
			Position = "RunAttack1"
		elseif Root.Velocity.Magnitude > 20 and Attack == true and Special == false and AttackFrame == 2 then -- idle
			Position = "RunAttack2"	
		elseif Attack == true and Special == false and AttackFrame == 1 then
			Position = "Attack1"
		elseif Attack == true and Special == false and AttackFrame == 2 then
			Position = "Attack2"
		elseif Special == true and Attack == false then
			Position = "Special"
		end
	end end)
	local Sine = 1
	local Speed = 1
	-- combability with nexo
	local sine = 1
	local speed = 1
	local CF = CFrame.new
	local RAD = math.rad
	local ANGLES = CFrame.Angles

	-- combability with nexo
	local NECK = Torso:FindFirstChild("Neck")
	NECK.C0 = CF(0,1,0)*ANGLES(RAD(0),RAD(0),RAD(0))
	NECK.C1 = CF(0,-0.5,0)*ANGLES(RAD(0),RAD(0),RAD(0))
	RJ.C1 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
	RJ.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
	RS.C1 = CF(-0.5,0.5,0)*ANGLES(RAD(0),RAD(0),RAD(0))
	LS.C1 = CF(0.5,0.5,0)*ANGLES(RAD(0),RAD(0),RAD(0))
	RH.C1 = CF(0,1,0)*ANGLES(RAD(0),RAD(0),RAD(0))
	LH.C1 = CF(0,1,0)*ANGLES(RAD(0),RAD(0),RAD(0))
	RH.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
	LH.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
	RS.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
	LS.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
	function HatSetup(Hat,Part,C1,C0,Number)
	Character[Hat].Handle.AccessoryWeld.Part1=Character[Part]
	Character[Hat].Handle.AccessoryWeld.C1=C1 or CFrame.new()
	Character[Hat].Handle.AccessoryWeld.C0=C0 or CFrame.new()--3bbb322dad5929d0d4f25adcebf30aa5
	end


	HatSetup('B&WKatanaAccessory','Right Arm',CFrame.new(),reanim['B&WKatanaAccessory'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),1.3+0*math.cos(sine/13),-1.8+0*math.cos(sine/13))*ANGLES(RAD(190+0*math.cos(sine/13)),RAD(3+0*math.cos(sine/13)),RAD(177+0*math.cos(sine/13))),1),false)

	spawn(function()
		while game:GetService("RunService").RenderStepped:Wait() do
			Sine = Sine + Speed
			-- combability with nexo
			sine =sine + speed
			if Position == "Idle" then
				NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),-0.03+0.1*math.sin(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RS.C0 = RS.C0:Lerp(CF(1+0.05*math.sin(sine/25),0.5+0.1*math.cos(sine/25),0+0*math.cos(sine/25))*ANGLES(RAD(47+0*math.cos(sine/25)),RAD(-2+0*math.cos(sine/25)),RAD(-46+0*math.cos(sine/25))),.3)
				LS.C0 = LS.C0:Lerp(CF(-1.+0.05*math.sin(sine/25),0.5+0.05*math.cos(sine/25),0+0*math.cos(sine/25))*ANGLES(RAD(54+0*math.cos(sine/25)),RAD(-17+0*math.cos(sine/25)),RAD(61+0*math.cos(sine/25))),.3)
				RH.C0 = RH.C0:Lerp(CF(0.56+0.03*math.sin(sine/13),-1+0.05*math.sin(sine/13),-0.2+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(-11+0*math.cos(sine/13)),RAD(3+0*math.cos(sine/13))),.3)
				LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.cos(sine/13),-1+0.05*math.sin(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				reanim['B&WKatanaAccessory'].Handle.AccessoryWeld.C0 = reanim['B&WKatanaAccessory'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),1.3+0*math.cos(sine/13),-1.8+0*math.cos(sine/13))*ANGLES(RAD(190+0*math.cos(sine/13)),RAD(3+0*math.cos(sine/13)),RAD(177+0*math.cos(sine/13))),.3)
			elseif Position == "Run" then
				NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/6),0+0*math.cos(sine/6),0+0*math.cos(sine/6))*ANGLES(RAD(-19+-2*math.cos(sine/6)),RAD(0+7*math.cos(sine/6)),RAD(0+-4*math.cos(sine/6))),.3)
				RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/8),0.5+0*math.cos(sine/8),0+0*math.cos(sine/8))*ANGLES(RAD(0+88*math.sin(sine/8)),RAD(-2+12*math.cos(sine/8)),RAD(-4+0*math.cos(sine/8))),.3)
				LS.C0 = LS.C0:Lerp(CF(-1+0*math.cos(sine/8),0.5+0*math.cos(sine/8),0+0*math.cos(sine/8))*ANGLES(RAD(0+-74*math.sin(sine/8)),RAD(0+10*math.cos(sine/8)),RAD(7+0*math.cos(sine/8))),.3)
				RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/6),-1+0*math.cos(sine/6),0+0*math.cos(sine/6))*ANGLES(RAD(0+76*math.cos(sine/6)),RAD(0+0*math.cos(sine/6)),RAD(3+0*math.cos(sine/6))),.3)
				LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.sin(sine/6),-1+0*math.cos(sine/6),0+0*math.cos(sine/6))*ANGLES(RAD(0+-76*math.cos(sine/6)),RAD(0+0*math.cos(sine/6)),RAD(0+0*math.cos(sine/6))),.3)
				reanim['B&WKatanaAccessory'].Handle.AccessoryWeld.C0 = reanim['B&WKatanaAccessory'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),1.3+0*math.cos(sine/13),-1.8+0*math.cos(sine/13))*ANGLES(RAD(190+0*math.cos(sine/13)),RAD(3+0*math.cos(sine/13)),RAD(177+0*math.cos(sine/13))),.3)
			elseif Position == "Jump" then
				NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),0+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(7+2*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/13),0.5+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(1+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(30+2*math.cos(sine/13))),.3)
				LS.C0 = LS.C0:Lerp(CF(-1+0*math.cos(sine/13),0.5+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(1+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(-40+-2*math.cos(sine/13))),.3)
				RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/13),-0.5+0*math.cos(sine/13),-0.3+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.cos(sine/13),-1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				reanim['B&WKatanaAccessory'].Handle.AccessoryWeld.C0 = reanim['B&WKatanaAccessory'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),1.3+0*math.cos(sine/13),-1.8+0*math.cos(sine/13))*ANGLES(RAD(190+0*math.cos(sine/13)),RAD(3+0*math.cos(sine/13)),RAD(177+0*math.cos(sine/13))),.3)
			elseif Position == "Fall" then
				NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),0+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(-6+2*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/13),0.5+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(1+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(10+2*math.cos(sine/13))),.3)
				LS.C0 = LS.C0:Lerp(CF(-1+0*math.cos(sine/13),0.5+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(1+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(-10+-3*math.cos(sine/13))),.3)
				RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/13),-0.76+0*math.cos(sine/13),-0.1+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.cos(sine/13),-1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				reanim['B&WKatanaAccessory'].Handle.AccessoryWeld.C0 = reanim['B&WKatanaAccessory'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),1.3+0*math.cos(sine/13),-1.8+0*math.cos(sine/13))*ANGLES(RAD(190+0*math.cos(sine/13)),RAD(3+0*math.cos(sine/13)),RAD(177+0*math.cos(sine/13))),.3)
			elseif Position == "Attack1" then
				NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),0+0.05*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(14+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/13),0.5+0.05*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(166+0*math.cos(sine/13)),RAD(-6+0*math.cos(sine/13)),RAD(10+0*math.cos(sine/13))),.3)
				LS.C0 = LS.C0:Lerp(CF(-1+0*math.cos(sine/13),0.5+0.05*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(-33+5*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/13),-1+0*math.cos(sine/13),-0.1+0*math.cos(sine/13))*ANGLES(RAD(-15+0*math.cos(sine/13)),RAD(-24+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.cos(sine/13),-1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(-17+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				reanim['B&WKatanaAccessory'].Handle.AccessoryWeld.C0 = reanim['B&WKatanaAccessory'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),1.3+0*math.cos(sine/13),-1.8+0*math.cos(sine/13))*ANGLES(RAD(21+0*math.cos(sine/13)),RAD(180+0*math.cos(sine/13)),RAD(3+0*math.cos(sine/13))),.3)
			elseif Position == "Attack2" then
				NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),0+0.05*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/13),0.5+0.05*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(5+0*math.cos(sine/13)),RAD(14+0*math.cos(sine/13)),RAD(-24+0*math.cos(sine/13))),.3)
				LS.C0 = LS.C0:Lerp(CF(-1+0*math.cos(sine/13),0.5+0.05*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(5+5*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/13),-1+0*math.cos(sine/13),-0.1+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(-24+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.cos(sine/13),-1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				reanim['B&WKatanaAccessory'].Handle.AccessoryWeld.C0 = reanim['B&WKatanaAccessory'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),1.3+0*math.cos(sine/13),-1.8+0*math.cos(sine/13))*ANGLES(RAD(21+0*math.cos(sine/13)),RAD(180+0*math.cos(sine/13)),RAD(3+0*math.cos(sine/13))),.3)
			elseif Position == "RunAttack1" then
				NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),0+0.05*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(14+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/13),0.5+0.05*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(166+0*math.cos(sine/13)),RAD(-6+0*math.cos(sine/13)),RAD(10+0*math.cos(sine/13))),.3)
				LS.C0 = LS.C0:Lerp(CF(-1+0*math.cos(sine/13),0.5+0.05*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(-33+5*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/6),-1+0*math.cos(sine/6),0+0*math.cos(sine/6))*ANGLES(RAD(0+76*math.cos(sine/6)),RAD(0+0*math.cos(sine/6)),RAD(3+0*math.cos(sine/6))),.3)
				LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.sin(sine/6),-1+0*math.cos(sine/6),0+0*math.cos(sine/6))*ANGLES(RAD(0+-76*math.cos(sine/6)),RAD(0+0*math.cos(sine/6)),RAD(0+0*math.cos(sine/6))),.3)
				reanim['B&WKatanaAccessory'].Handle.AccessoryWeld.C0 = reanim['B&WKatanaAccessory'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),1.3+0*math.cos(sine/13),-1.8+0*math.cos(sine/13))*ANGLES(RAD(21+0*math.cos(sine/13)),RAD(180+0*math.cos(sine/13)),RAD(3+0*math.cos(sine/13))),.3)
			elseif Position == "RunAttack2" then
				NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),0+0.05*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/13),0.5+0.05*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(5+0*math.cos(sine/13)),RAD(14+0*math.cos(sine/13)),RAD(-24+0*math.cos(sine/13))),.3)
				LS.C0 = LS.C0:Lerp(CF(-1+0*math.cos(sine/13),0.5+0.05*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(5+5*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
				RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/6),-1+0*math.cos(sine/6),0+0*math.cos(sine/6))*ANGLES(RAD(0+76*math.cos(sine/6)),RAD(0+0*math.cos(sine/6)),RAD(3+0*math.cos(sine/6))),.3)
				LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.sin(sine/6),-1+0*math.cos(sine/6),0+0*math.cos(sine/6))*ANGLES(RAD(0+-76*math.cos(sine/6)),RAD(0+0*math.cos(sine/6)),RAD(0+0*math.cos(sine/6))),.3)
				reanim['B&WKatanaAccessory'].Handle.AccessoryWeld.C0 = reanim['B&WKatanaAccessory'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),1.3+0*math.cos(sine/13),-1.8+0*math.cos(sine/13))*ANGLES(RAD(21+0*math.cos(sine/13)),RAD(180+0*math.cos(sine/13)),RAD(3+0*math.cos(sine/13))),.3)
				
			end
		end
	end)
	
end)

HatScriptTab:HatScript("Drunk Gunner","6202087882", function()
	TheHatLol = "Police K4LAS [Front]"
TheHatLol2 = TheHatLol -- "Police K4LAS [Front]"
loadstring(game:HttpGet("https://raw.githubusercontent.com/Zaphick3L/MiscStuff/main/ScriptStuff.lua"))()

if _G.BulletReanimate == true then
	local bulchar = workspace[game.Players.LocalPlayer.Name]
	local bullet = bulchar:FindFirstChild("LowerTorso") or bulchar:FindFirstChild("Right Leg")
	_G.Disconnect = true

	local highlight = Instance.new("SelectionBox",bullet)
	highlight.Adornee = bullet
	local bp = Instance.new("BodyPosition", bullet)
	bp.MaxForce = Vector3.new(9e9,9e9,9e9)
	bp.D = 125
	bp.P = 40000
	local mouse = game.Players.LocalPlayer:GetMouse()
	local mousehold = false
	mouse.Button1Down:Connect(function()
		mousehold = true
		wait(0.4)
		mousehold = false
	end)
			
	local bulletloop
	local function fling()
		local t = 5
		local hue = tick() % t / t -- took rainbow thing from project cat v1
		highlight.Color3 = Color3.fromHSV(hue, 1, 1)
		
		bullet.RotVelocity = Vector3.new(17500,17500,17500)
		if mousehold then
			if mouse.Target ~= nil then
				bp.Position = mouse.Hit.p
			end
		else
			bp.Position = game.Players.LocalPlayer.Character.Torso.CFrame.p + Vector3.new(0,-15,0)
		end
	end

	bulletloop = game:GetService("RunService").Heartbeat:Connect(fling)
	bulchar.Humanoid.Died:Connect(function()
		bulletloop:Disconnect()
	end)
end
local attacksoundid = "rbxassetid://259016349"
_G.AttackWait1 = 0.2
_G.AttackWait2 = 0.2
local Special = false
local Attack = false
local AttackFrame = 0
local Locked = false
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Character = Player.Character.Raw
Character.Animate.Disabled = true
wait(0.5)
local Torso = Character:FindFirstChild("Torso")
local Humanoid = Character:FindFirstChildOfClass("Humanoid")
local RS = Torso:FindFirstChild("Right Shoulder")
local LS = Torso:FindFirstChild("Left Shoulder")
local RH = Torso:FindFirstChild("Right Hip")
local LH = Torso:FindFirstChild("Left Hip")
local Root = Character:FindFirstChild("HumanoidRootPart")
local Neck = Torso:FindFirstChild("Neck")
local RJ = Root:FindFirstChild("RootJoint")
local UserInputService = game:GetService("UserInputService")
Humanoid.WalkSpeed = 25
reanim = Character

local Hat = Player.Character:FindFirstChild("Police K4LAS [Front]")
local Clone = Hat:Clone()
Clone.Parent = Character
Clone.Handle.Transparency = 1
local function Align(P0,P1,Position,Orientation)
    local AlignPosition = Instance.new("AlignPosition", P0)
    local AlignOrientation = Instance.new("AlignOrientation", P0)
    local Attachment1 = Instance.new("Attachment", P0)
    local Attachment2 = Instance.new("Attachment", P1)
    -- Main Attach Thingy:
    AlignPosition.Attachment0,AlignPosition.Attachment1 = Attachment1,Attachment2 -- Shortcut
    AlignOrientation.Attachment0,AlignOrientation.Attachment1 = Attachment1,Attachment2 -- Shortcut
    -- Properties:

    AlignPosition.MaxForce = 9e9
    AlignOrientation.MaxTorque = 9e9
    AlignPosition.Responsiveness = 200
    AlignOrientation.Responsiveness = 200

    -- Rotate/Position
    Attachment1.Position = Position or Vector3.new(0,0,0)
    Attachment1.Orientation = Orientation or Vector3.new(0,0,0)
end
Hat.Handle.AccessoryWeld:Destroy()
Align(Hat.Handle,Clone.Handle)

local soundeffect = Instance.new("Sound", Hat.Handle)
soundeffect.SoundId = attacksoundid

UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		if Locked == false then
		Attack = true
		Locked = true
		AttackFrame = 1
		wait(_G.AttackWait1)
		soundeffect:Play()
		AttackFrame = 2
		wait(_G.AttackWait2)
		Attack = false
		AttackFrame = 0
		Locked = false
		end
	end
end)


spawn(function() while game:GetService("RunService").RenderStepped:Wait() do
			for i, v in pairs(Humanoid:GetPlayingAnimationTracks()) do
			v:Stop()
		end
	if Root.Velocity.y > 1 and Attack == false then
		Position = "Jump"
	elseif Root.Velocity.y < -1 and Attack == false and Special == false then
		Position = "Fall"
	elseif Root.Velocity.Magnitude < 2 and Attack == false and Special == false then -- idle
		Position = "Idle"
	elseif Root.Velocity.Magnitude > 20 and Attack == false and Special == false then -- idle
		Position = "Run"
	elseif Root.Velocity.Magnitude > 20 and Attack == true and Special == false and AttackFrame == 1 then -- idle
		Position = "RunAttack1"
	elseif Root.Velocity.Magnitude > 20 and Attack == true and Special == false and AttackFrame == 2 then -- idle
		Position = "RunAttack2"	
	elseif Attack == true and Special == false and AttackFrame == 1 then
		Position = "Attack1"
	elseif Attack == true and Special == false and AttackFrame == 2 then
		Position = "Attack2"
	elseif Special == true and Attack == false then
		Position = "Special"
	end
end end)
local Sine = 1
local Speed = 1
-- combability with nexo
local sine = 1
local speed = 1
local CF = CFrame.new
local RAD = math.rad
local ANGLES = CFrame.Angles

-- combability with nexo
local NECK = Torso:FindFirstChild("Neck")
NECK.C0 = CF(0,1,0)*ANGLES(RAD(0),RAD(0),RAD(0))
NECK.C1 = CF(0,-0.5,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RJ.C1 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RJ.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RS.C1 = CF(-0.5,0.5,0)*ANGLES(RAD(0),RAD(0),RAD(0))
LS.C1 = CF(0.5,0.5,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RH.C1 = CF(0,1,0)*ANGLES(RAD(0),RAD(0),RAD(0))
LH.C1 = CF(0,1,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RH.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
LH.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RS.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
LS.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
function HatSetup(Hat,Part,C1,C0,Number)
Character[Hat].Handle.AccessoryWeld.Part1=Character[Part]
Character[Hat].Handle.AccessoryWeld.C1=C1 or CFrame.new()
Character[Hat].Handle.AccessoryWeld.C0=C0 or CFrame.new()--3bbb322dad5929d0d4f25adcebf30aa5
end

HatSetup('Police K4LAS [Front]','Right Arm',CFrame.new(),reanim['Police K4LAS [Front]'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),-0.5+0*math.cos(sine/13),-0.4+0*math.cos(sine/13))*ANGLES(RAD(268+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),1),false)



spawn(function()
	while game:GetService("RunService").RenderStepped:Wait() do
		Sine = Sine + Speed
		-- combability with nexo
		sine =sine + speed
		if Position == "Idle" then

		NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
		RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/21),0+0.05*math.sin(sine/21),0+0*math.cos(sine/21))*ANGLES(RAD(1+0*math.cos(sine/21)),RAD(0+0*math.cos(sine/21)),RAD(0+0*math.cos(sine/21))),.3)
		RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/23),0.5+0.1*math.cos(sine/23),0+0*math.cos(sine/23))*ANGLES(RAD(260+0*math.cos(sine/23)),RAD(12+0*math.cos(sine/23)),RAD(-68+0*math.cos(sine/23))),.3)
		LS.C0 = LS.C0:Lerp(CF(-1+0*math.cos(sine/13),0.5+0.05*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+-8*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(-4+0*math.cos(sine/13))),.3)
		RH.C0 = RH.C0:Lerp(CF(0.5+0*math.sin(sine/13),-0.9+0.05*math.cos(sine/13),-0.2+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(-8+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
		LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.sin(sine/13),-0.9+0.05*math.cos(sine/13),-0.2+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(16+0*math.cos(sine/13)),RAD(1+0*math.cos(sine/13))),.3)
		reanim['Police K4LAS [Front]'].Handle.AccessoryWeld.C0 = reanim['Police K4LAS [Front]'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),-0.5+0*math.cos(sine/13),-0.4+0*math.cos(sine/13))*ANGLES(RAD(268+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)


		elseif Position == "Run" then
			NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/28),0+0*math.cos(sine/28),0+0*math.cos(sine/28))*ANGLES(RAD(0+5*math.sin(sine/28)),RAD(0+0*math.cos(sine/28)),RAD(0+-6*math.cos(sine/28))),.3)
			RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/13),0.5+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+45*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(10+0*math.cos(sine/13))),.3)
			LS.C0 = LS.C0:Lerp(CF(-0.9+0*math.cos(sine/13),0.5+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(16+0*math.cos(sine/13))),.3)
			RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/13),-1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+52*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.cos(sine/13),-1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+-52*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			reanim['Police K4LAS [Front]'].Handle.AccessoryWeld.C0 = reanim['Police K4LAS [Front]'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),-0.5+0*math.cos(sine/13),-1+0*math.cos(sine/13))*ANGLES(RAD(268+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)


		elseif Position == "Jump" then
			NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),0+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(7+2*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/13),0.5+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(1+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(30+2*math.cos(sine/13))),.3)
			LS.C0 = LS.C0:Lerp(CF(-1+0*math.cos(sine/13),0.5+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(1+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(-40+-2*math.cos(sine/13))),.3)
			RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/13),-0.5+0*math.cos(sine/13),-0.3+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.cos(sine/13),-1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			reanim['Police K4LAS [Front]'].Handle.AccessoryWeld.C0 = reanim['Police K4LAS [Front]'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),-0.5+0*math.cos(sine/13),-1+0*math.cos(sine/13))*ANGLES(RAD(268+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
		elseif Position == "Fall" then
			NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),0+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(-6+2*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/13),0.5+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(1+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(10+2*math.cos(sine/13))),.3)
			LS.C0 = LS.C0:Lerp(CF(-1+0*math.cos(sine/13),0.5+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(1+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(-10+-3*math.cos(sine/13))),.3)
			RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/13),-0.76+0*math.cos(sine/13),-0.1+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.cos(sine/13),-1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			reanim['Police K4LAS [Front]'].Handle.AccessoryWeld.C0 = reanim['Police K4LAS [Front]'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),-0.5+0*math.cos(sine/13),-1+0*math.cos(sine/13))*ANGLES(RAD(268+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			
		elseif Position == "Attack1" then
			NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),0+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/13),0.5+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(75+3*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(10+0*math.cos(sine/13))),.3)
			LS.C0 = LS.C0:Lerp(CF(-0.9+0*math.cos(sine/13),0.5+0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(16+0*math.cos(sine/13))),.3)
			RH.C0 = RH.C0:Lerp(CF(0.5+0*math.sin(sine/13),-0.9+0.05*math.cos(sine/13),-0.2+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(-8+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.sin(sine/13),-0.9+0.05*math.cos(sine/13),-0.2+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(16+0*math.cos(sine/13)),RAD(1+0*math.cos(sine/13))),.3)
			reanim['Police K4LAS [Front]'].Handle.AccessoryWeld.C0 = reanim['Police K4LAS [Front]'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),-0.5+0*math.cos(sine/13),-1.2+0*math.cos(sine/13))*ANGLES(RAD(92+0*math.cos(sine/13)),RAD(3+0*math.cos(sine/13)),RAD(179+0*math.cos(sine/13))),.3)
		elseif Position == "Attack2" then
			NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),0+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/13),0.5+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(134+3*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(10+0*math.cos(sine/13))),.3)
			LS.C0 = LS.C0:Lerp(CF(-0.9+0*math.cos(sine/13),0.5+0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(16+0*math.cos(sine/13))),.3)
			RH.C0 = RH.C0:Lerp(CF(0.5+0*math.sin(sine/13),-0.9+0.05*math.cos(sine/13),-0.2+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(-8+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.sin(sine/13),-0.9+0.05*math.cos(sine/13),-0.2+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(16+0*math.cos(sine/13)),RAD(1+0*math.cos(sine/13))),.3)
			reanim['Police K4LAS [Front]'].Handle.AccessoryWeld.C0 = reanim['Police K4LAS [Front]'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),-0.5+0*math.cos(sine/13),-1.2+0*math.cos(sine/13))*ANGLES(RAD(92+0*math.cos(sine/13)),RAD(3+0*math.cos(sine/13)),RAD(179+0*math.cos(sine/13))),.3)
		elseif Position == "RunAttack1" then
			NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),0+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/13),0.5+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(92+3*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(10+0*math.cos(sine/13))),.3)
			LS.C0 = LS.C0:Lerp(CF(-0.9+0*math.cos(sine/13),0.5+0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(16+0*math.cos(sine/13))),.3)
			RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/13),-1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+52*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.cos(sine/13),-1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+-52*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			reanim['Police K4LAS [Front]'].Handle.AccessoryWeld.C0 = reanim['Police K4LAS [Front]'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),-0.5+0*math.cos(sine/13),-1.2+0*math.cos(sine/13))*ANGLES(RAD(92+0*math.cos(sine/13)),RAD(3+0*math.cos(sine/13)),RAD(179+0*math.cos(sine/13))),.3)
		elseif Position == "RunAttack2" then
			NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),0+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/13),0.5+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(134+3*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(10+0*math.cos(sine/13))),.3)
			LS.C0 = LS.C0:Lerp(CF(-0.9+0*math.cos(sine/13),0.5+0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(16+0*math.cos(sine/13))),.3)
			RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/13),-1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+52*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.cos(sine/13),-1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+-52*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
			reanim['Police K4LAS [Front]'].Handle.AccessoryWeld.C0 = reanim['Police K4LAS [Front]'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),-0.5+0*math.cos(sine/13),-1.2+0*math.cos(sine/13))*ANGLES(RAD(92+0*math.cos(sine/13)),RAD(3+0*math.cos(sine/13)),RAD(179+0*math.cos(sine/13))),.3)
		end
	end
end)
	
	
end)
