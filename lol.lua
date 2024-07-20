-- made by ipufo (bisbord)
shared.settings = {
    soundDelay = 0.9
}

local Audio, ContentProvider = {
    Audios = {}
}, game:GetService'ContentProvider'

function Audio:Play(Id, TimePosition, Pitch, Volume, Loop, Cframe)
    local s
    if type(Id) == 'number' then
        s = Instance.new('Sound')
        s.SoundId = 'rbxassetid://'..Id
        s.Parent = ReplicatedStorage
        ContentProvider:PreloadAsync({
            s
        })
        repeat RunService.Stepped:Wait() until (s.TimeLength > 1)
        local sup
        sup = true
        local timeLength = s.TimeLength
        local otick = tick()
        s:Destroy()
        for i, v in self.Audios do
            if i == 'rbxassetid://' .. Id then
                v = nil
            end
        end
        self.Audios['rbxassetid://' .. Id] = {Time = 0}
        local function fireaudio()
            if (
                not Lighting.TS.Value and
                Player.Character:FindFirstChildOfClass('Humanoid') and
                Player.Character:FindFirstChild('HumanoidRootPart')
            ) then
                ReplicatedStorage.FOTPSDamage2:FireServer(Player.Character:FindFirstChildOfClass('Humanoid'), Cframe or Player.Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(0, -2, 0), 0, 0, Vector3.zero, math.huge, s.SoundId, Pitch or 1, Volume or 5)
            else
                print('boop')
            end
        end
        task.spawn(function()
            if timeLength >= shared.settings.soundDelay then
                for i = 1, math.ceil((timeLength / shared.settings.soundDelay) / (Pitch or 1)) * if Loop then 9999 else 1 do
                    self.Audios['rbxassetid://' .. Id].Time = (tick() - otick) + TimePosition or 0
                    print(self.Audios['rbxassetid://' .. Id].Time)
                    if type(self.Audios['rbxassetid://' .. Id]) ~= nil and sup and 'i hope every single one of you die.' then
                        fireaudio()
                    else
                        break
                    end
                    task.wait(shared.settings.soundDelay)
                end
                table.clear(self.Audios)
            else
                local tp = Instance.new('Sound', game.Players.LocalPlayer.PlayerGui)
                tp.SoundId = 'rbxassetid://602163388'
                tp.Volume = 10
                local sfx = Instance.new('DistortionSoundEffect', tp)
                sfx.Level = 10
                tp:Play()
                tp.Looped = false
                fireaudio()
            end
        end)
    end
end

function Audio:Stop()
    table.clear(Audio.Audios)
end

return Audio
