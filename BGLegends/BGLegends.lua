-- ************************************************************
-- * AddOn Name: Battleground Legends                         *
-- * Description: A battleground kill announcer               *
-- * Author: Mihapro                                          *
-- * Expansion: Wrath of the Lich King, patch 3.3.5a (12340)  *
-- ************************************************************

BGL = CreateFrame("frame","BGLFrame")
BGL.Version = "v1.22"
BGL.Classes = {
    ["DEATHKNIGHT"] = {Color = "C41F3B", Icon = "death knight.TGA"},
    ["DEATH KNIGHT"] = {Color = "C41F3B", Icon = "death knight.TGA"},
    ["DRUID"] = {Color = "FF7D0A", Icon = "druid.TGA"},
    ["HUNTER"] = {Color = "ABD473", Icon = "hunter.TGA"},
    ["MAGE"] = {Color = "69CCF0", Icon = "mage.TGA"},
    ["PALADIN"] = {Color = "F58CBA", Icon = "paladin.TGA"},
    ["PRIEST"] = {Color = "FFFFFF", Icon = "priest.TGA"},
    ["ROGUE"] = {Color = "FFF569", Icon = "rogue.TGA"},
    ["SHAMAN"] = {Color = "0070DE", Icon = "shaman.TGA"},
    ["WARLOCK"] = {Color = "9482C9", Icon = "warlock.TGA"},
    ["WARRIOR"] = {Color = "C79C6E", Icon = "warrior.TGA"},
}
BGL.Colors = {["TITLE"] = "FFD700", ["TEXT"] = "CCCCCC"}
BGL.Events = {
    "CHAT_MSG_ADDON",
    "COMBAT_LOG_EVENT_UNFILTERED",
    "ZONE_CHANGED_NEW_AREA",
    "CHAT_MSG_BG_SYSTEM_NEUTRAL",
    "UPDATE_BATTLEFIELD_SCORE",
    "UPDATE_BATTLEFIELD_STATUS",
}
BGL.AddonUsers = {}
BGL.Timers = {}
BGL.ClassIconsFolder = "Interface\\AddOns\\BGLegends\\Textures\\"
BGL.SoundPacks = {
    [1] = {Short = "LOL", Name = "LoL: Default (EN)", SoundFolder = "LOL_Announcer"},
    [2] = {Short = "DOTA", Name = "DotA: Default (EN)", SoundFolder = "DOTA_Announcer"},
    [3] = {Short = "HON", Name = "HoN: Default (EN)", SoundFolder = "HON_Announcer"},
    [4] = {Short = "HON_2", Name = "HoN: Ms Pudding (EN)", SoundFolder = "HON_MsPudding"},
}
BGL.SoundsFolder = "Interface\\AddOns\\BGLegends\\Sounds\\"
BGL.SoundsSubfolders = {["KILL"] = "Kill", ["TEAMKILL"] = "Team Kill", ["ENEMYKILL"] = "Enemy Kill", ["OTHERKILL"] = "Other Kill", ["GAME"] = "Game"}
BGL.Sounds = {
    ["LOL"] = {
        ["TEAMKILL"] = {
            ["SLAIN"] = {{"Slain 1.OGG",3}, {"Slain 2.OGG",3}, {"Slain 3.OGG",3}},
            ["YOU_SLAIN"] = {{"You Slain 1.OGG",3}, {"You Slain 2.OGG",3}, {"You Slain 3.OGG",3}},
            ["SPREE"] = {{"Killing Spree 1.OGG",3}, {"Killing Spree 2.OGG",3}},
            ["RAMPAGE"] = {{"Rampage 1.OGG",2}, {"Rampage 2.OGG",2}},
            ["UNSTOPPABLE"] = {{"Unstoppable.OGG",2}},
            ["DOMINATING"] = {{"Dominating.OGG",2}},
            ["GODLIKE"] = {{"Godlike 1.OGG",2}, {"Godlike 2.OGG",2}},
            ["LEGENDARY"] = {{"Legendary 1.OGG",2}, {"Legendary 2.OGG",2}, {"Legendary 3.OGG",2}},
            ["DOUBLE"] = {{"Doublekill 1.OGG",2}, {"Doublekill 2.OGG",2}},
            ["TRIPLE"] = {{"Triplekill 1.OGG",2}, {"Triplekill 2.OGG",2}},
            ["QUADRA"] = {{"Quadrakill 1.OGG",2}, {"Quadrakill 2.OGG",2}},
            ["PENTA"] = {{"Pentakill 1.OGG",2}, {"Pentakill 2.OGG",2}},
        },
        ["ENEMYKILL"] = {
            ["SLAIN"] = {{"Slain 1.OGG",3},{"Slain 2.OGG",3}},
            ["YOU_SLAIN"] = {{"You Slain 1.OGG",3},{"You Slain 2.OGG",3}},
            ["SPREE"] = {{"Killing Spree 2.OGG",3}}, -- Killing Spree 1.OGG wont work :(
            ["RAMPAGE"] = {{"Rampage.OGG",3}},
            ["UNSTOPPABLE"] = {{"Unstoppable 1.OGG",3}, {"Unstoppable 2.OGG",3}},
            ["DOMINATING"] = {{"Dominating.OGG",3}},
            ["GODLIKE"] = {{"Godlike 1.OGG",3}, {"Godlike 2.OGG",3}},
            ["LEGENDARY"] = {{"Legendary 1.OGG",3}, {"Legendary 2.OGG",3}},
            ["DOUBLE"] = {{"Doublekill 1.OGG",3}, {"Doublekill 2.OGG",3}},
            ["TRIPLE"] = {{"Triplekill 1.OGG",3}, {"Triplekill 2.OGG",3}},
            ["QUADRA"] = {{"Quadrakill.OGG",3}},
            ["PENTA"] = {{"Pentakill 1.OGG",3}, {"Pentakill 2.OGG",3}},
        },
        ["OTHERKILL"] = {    
            ["FIRST_BLOOD"] = {{"First Blood.OGG",3}},
            ["EXECUTED"] = {{"Executed.OGG",2}},
            ["SHUT_DOWN"] = {{"Shut Down 1.OGG",2.5}, {"Shut Down 2.OGG",2.5}},
            ["ACE"] = {{"Ace 1.OGG",3}, {"Ace 2.OGG",3}},
        },
        ["GAME"] = {
            ["BATTLE_BEGIN_30S"] = {{"Battle Begin 30S.OGG",2}},
            ["BATTLE_BEGIN"] = {{"Battle Begin.OGG",2}},
            ["VICTORY"] = {{"Victory.OGG",2}},
            ["DEFEAT"] = {{"Defeat.OGG",2}},
        },
    },
    ["DOTA"] = {
        ["KILL"] = {
            ["FIRST_BLOOD"] = {{"First Blood.MP3",2}},
            ["KILLING_SPREE"] = {{"Killing Spree.MP3",2}},
            ["DOMINATING"] = {{"Dominating.MP3",2}},
            ["MEGA_KILL"] = {{"Mega Kill.MP3",2}},
            ["UNSTOPPABLE"] = {{"Unstoppable.MP3",2}},
            ["WICKED_SICK"] = {{"Wicked Sick.MP3",2}},
            ["MONSTER_KILL"] = {{"Monster Kill.MP3",2}},
            ["GODLIKE"] = {{"Godlike.MP3",2}},
            ["HOLY_SHIT"] = {{"Holy Shit.MP3",2}},
            ["DOUBLE"] = {{"Double Kill.MP3",2}},
            ["TRIPLE"] = {{"Triple Kill.MP3",2}},
            ["ULTRA_KILL"] = {{"Ultra Kill.MP3",2}},
            ["RAMPAGE"] = {{"Rampage.MP3",2}},
            ["OWNAGE"] = {{"Ownage.MP3",2}},
        },
        ["GAME"] = {
            ["BATTLE_BEGIN_60S"] = {{"Battle Prepare 1.MP3",3}, {"Battle Prepare 2.MP3",3}, {"Battle Prepare 3.MP3",3}},
            ["BATTLE_BEGIN_30S"] = {{"Battle Begin 30S.MP3",3}},
            ["BATTLE_BEGIN_10S"] = {{"Battle Begin 10S.MP3",3}},
            ["BATTLE_BEGIN"] = {{"Battle Begin 1.MP3",3}, {"Battle Begin 2.MP3",3}, {"Battle Begin 3.MP3",3}, {"Battle Begin 4.MP3",3}, {"Battle Begin 5.MP3",3}, {"Battle Begin 6.MP3",3}},
            ["VICTORY"] = {{"Victory 1.MP3",3}, {"Victory 2.MP3",3}},
        },
    },
    ["HON"] = {
        ["KILL"] = {
            ["DENIED"] = {{"Denied.OGG",2}},
            ["BLOODLUST"] = {{"Bloodlust.OGG",2}},
            ["DOUBLE_TAP"] = {{"Double Tap.OGG",2}},
            ["HAT_TRICK"] = {{"Hat Trick.OGG",2}},
            ["QUAD_KILL"] = {{"Quad Kill.OGG",2}},
            ["ANNIHILATION"] = {{"Annihilation.OGG",2}},
            ["GENOCIDE"] = {{"Genocide.OGG",2}},
            ["SMACKDOWN"] = {{"Smackdown.OGG",2}},
            ["ULTIMATE_WARRIOR"] = {{"Ultimate Warrior.OGG",2}},
            ["LEGENDARY"] = {{"Legendary.OGG",2}},
            ["ONSLAUGHT"] = {{"Onslaught.OGG",2}},
            ["DOMINATING"] = {{"Dominating.OGG",2}},
            ["BLOODBATH"] = {{"Bloodbath.OGG",2}},
            ["IMMORTAL"] = {{"Immortal.OGG",2}},
        },
        ["GAME"] = {
            ["VICTORY"] = {{"Victory.OGG",2}},
            ["DEFEAT"] = {{"Defeat.OGG",2}},
        },
    },
    ["HON_2"] = {
        ["KILL"] = {
            ["HUMILIATION"] = {{"Humiliation.OGG",2}},
            ["MASACRE"] = {{"Masacre.OGG",2}},
            ["DENIED"] = {{"Denied.OGG",2}},
            ["PAYBACK"] = {{"Payback.OGG",2}},
            ["BLOODLUST"] = {{"Bloodlust.OGG",2}},
            ["DOUBLE_TAP"] = {{"Double Tap.OGG",2}},
            ["HAT_TRICK"] = {{"Hat Trick.OGG",2}},
            ["QUAD_KILL"] = {{"Quad Kill.OGG",2}},
            ["ANNIHILATION"] = {{"Annihilation.OGG",2}},
            ["GENOCIDE"] = {{"Genocide.OGG",2}},
            ["SERIAL_KILLER"] = {{"Serial Killer.OGG",2}},
            ["ULTIMATE_WARRIOR"] = {{"Ultimate Warrior.OGG",2}},
            ["LEGENDARY"] = {{"Legendary.OGG",2}},
            ["ONSLAUGHT"] = {{"Onslaught.OGG",2}},
            ["SAVAGE_SICK"] = {{"Savage Sick.OGG",2}},
            ["DOMINATING"] = {{"Dominating.OGG",2}},
            ["CHAMPION_OF_NEWERTH"] = {{"Champing of Newerth.OGG",2}},
        },
        ["GAME"] = {
            ["VICTORY"] = {{"Victory.OGG",2}},
            ["DEFEAT"] = {{"Defeat.OGG",2}},
        },
    },
}
BGL.AnnounceActive = false
BGL.AnnounceTimer = 0
BGL.AnnounceQueue = {}
BGL.FirstBlood = false
BGL.SpiritHealerTimer = nil
BGL:SetScript("OnEvent", function(self, event, ...)
    self[event](self, ...)
end)
BGL:SetScript("OnUpdate", function(self, elapsed)    
    if self.SpiritHealerTimer then
        self.SpiritHealerTimer = self.SpiritHealerTimer - elapsed
    end
    if self.TeamMultiKillCount > 0 then
        self.TeamMultiKillTimer = self.TeamMultiKillTimer - elapsed
        if self.TeamMultiKillTimer <= 0 then
            self.TeamMultiKillCount = 0
        end
    end
    if self.EnemyMultiKillCount > 0 then
        self.EnemyMultiKillTimer = self.EnemyMultiKillTimer - elapsed
        if self.EnemyMultiKillTimer <= 0 then
            self.EnemyMultiKillCount = 0
        end
    end
    if self:Count(self.TeamAceTable) > 0 then
        self.TeamAceTimer = self.TeamAceTimer - elapsed
        if self.TeamAceTimer <= 0 then
            self.TeamAceTable = {}
        end
    end
    if self:Count(self.EnemyAceTable) > 0 then
        self.EnemyAceTimer = self.EnemyAceTimer - elapsed
        if self.EnemyAceTimer <= 0 then
            self.EnemyAceTable = {}
        end
    end
    for i,Timer in pairs(self.Timers) do
        if Timer.Delay > 0 then
            Timer.Delay = Timer.Delay - elapsed
            if Timer.Delay <= 0 then
                self:TimerFinished(Timer.Name)
                table.remove(self.Timers,i)
            end
        end
    end
end)
BGL.NumPlayers = {[0] = 0, [1] = 0}
BGL.PlayerTable = {}
BGL.KillingSpreeTable = {}
BGL.TeamMultiKillTimer = 0
BGL.TeamMultiKillCount = 0
BGL.EnemyMultiKillTimer = 0
BGL.EnemyMultiKillCount = 0
BGL.TeamAceTable = {}
BGL.TeamAceTimer = 0
BGL.EnemyAceTable = {}
BGL.EnemyAceTimer = 0
BGL.BattleActive = false

function BGL:ScheduleTimer(Name,Delay)
    table.insert(self.Timers, {Name = Name, Delay = Delay})
end

function BGL:RescheduleTimer(Name,Delay)
    for _,Timer in pairs(self.Timers) do
        if Timer.Name == Name then
            Timer.Delay = Delay
            return
        end
    end
    self:ScheduleTimer(Name,Delay)
end

function BGL:TimerFinished(Name)
    if Name == "PrintAddonUsers" then
        if #self.AddonUsers > 0 then
            local arr = {}
            for User,Version in pairs(self.AddonUsers) do
                local Class = select(2, UnitClass(User)) or select(6, self:GetGuildMemberInfo(User))
                local ClassColor = self.Classes[Class].Color or self.Colors["TEXT"]
                local VersionColor = Version > self.Version and "00FF00" or Version < self.Version and "FF0000" or self.Colors["TEXT"]
                table.insert(arr, "|r|cFF"..ClassColor.."|Hplayer:"..User.."|h["..User.."]|h|r|cFF"..self.Colors["TEXT"].." (|r|cFF"..VersionColor..Version.."|r|cFF"..self.Colors["TEXT"]..")")
            end
            self:Print("Addon users in your battleground group: "..table.concat(arr, ", "))
        else
            self:Print("None of players in your battleground group use this addon.")
        end
    elseif Name == "START_10S" then
        if not self.Sounds[self.SoundPacks[self.Settings["SOUNDPACK"]].Short]["GAME"]["BATTLE_BEGIN_10S"] then return end
        local FileName, MinTime = self:GetRandomSoundInfo(self.Sounds[self.SoundPacks[self.Settings["SOUNDPACK"]].Short]["GAME"]["BATTLE_BEGIN_10S"])
        local FilePath = FileName and self.SoundsFolder..self.SoundPacks[self.Settings["SOUNDPACK"]].SoundFolder.."\\"..self.SoundsSubfolders["GAME"].."\\"..FileName or ""
        table.insert(self.AnnounceQueue,{Text = "Ten seconds until the battle begins!", Sound = FilePath, Time = 3, Color = {1,0.8,0}})
    elseif Name == "START" then
        self.FirstBlood = false
        self.PlayerTable = {}
        self.PlayerTable[UnitName("player")] = {Faction = (UnitFactionGroup("player") == "Horde" and 0 or 1), Class = select(2,UnitClass("player"))}
        self.KillingSpreeTable = {}
        
        local FileName, MinTime = self:GetRandomSoundInfo(self.Sounds[self.SoundPacks[self.Settings["SOUNDPACK"]].Short]["GAME"]["BATTLE_BEGIN"])
        local FilePath = FileName and self.SoundsFolder..self.SoundPacks[self.Settings["SOUNDPACK"]].SoundFolder.."\\"..self.SoundsSubfolders["GAME"].."\\"..FileName or ""
        table.insert(self.AnnounceQueue,{Text = "The battle has begun!", Sound = FilePath, Time = 3, Color = {1,0.8,0}})

        RequestBattlefieldScoreData()
        self:RescheduleTimer("REQUEST_BATTLEFIELD_SCORE_DATA", 5)
    elseif Name == "REQUEST_BATTLEFIELD_SCORE_DATA" then
        RequestBattlefieldScoreData()
    elseif Name == "PREVIEW1" then
        self:PlayerKill(UnitName("player"), "PLAYER", "Test Mage")
    elseif Name == "PREVIEW2" then
        self:PlayerKill(UnitName("player"), "PLAYER", "Test Hunter")
    elseif Name == "PREVIEW3" then
        self:PlayerKill(UnitName("player"), "PLAYER", "Test Shaman")
    elseif Name == "PREVIEW4" then
        self:PlayerKill("Test Mage", "PLAYER", UnitName("player"))
    end
end

function BGL:GetGuildMemberInfo(Name)
    local Searching, i = true, 0
    while Searching do
        i = i + 1
        local n = GetGuildRosterInfo(i)
        if not n then break end
        if Name == n then
            return i, GetGuildRosterInfo(i)
        end
    end
end

function BGL:Unit(Name)
    local Class = self.PlayerTable[Name] and self.PlayerTable[Name].Class and self.PlayerTable[Name].Class or select(2,UnitClass(Name))
    local Color = Class and self.Classes[strupper(Class)].Color or self.Colors["TEXT"]
    return "|cFF"..Color..Name.."|r"
end

function SlashCmdList.BGL(Message, editbox)
    local Args = strupper(Message)
    if Args == "" then
        if not BGL_Options:IsVisible() then
            BGL_Options:Show()
        else
            BGL_Options:Hide()
        end
    else
        BGL:Print("Unknown command.")
    end
end

function BGL:SendAddonMessage(Args,Channel,Recipient)
    SendAddonMessage("BGL", Args, Channel or "BATTLEGROUND", Recipient)
end

function BGL:Print(Message,TextColor)
    if not Message then return end
    TextColor = TextColor or self.Colors["TEXT"]
    DEFAULT_CHAT_FRAME:AddMessage("|cFF"..self.Colors["TITLE"].."[BGLegends]:|r "..Message, tonumber(TextColor:sub(1,2),16)/255, tonumber(TextColor:sub(3,4),16)/255, tonumber(TextColor:sub(5,6),16)/255)
end

function BGL:RegisterEvents()
    for _,event in pairs(self.Events) do
        self:RegisterEvent(event)
    end
end

function BGL:PlayerKill(Source, SourceType, Dest)
    local TeamKill -- "YES"/"NO"/nil
    if self.PlayerTable[Dest] then
        TeamKill = self.PlayerTable[Dest].Faction ~= self.PlayerTable[UnitName("player")].Faction and "YES" or "NO"
    elseif SourceType == "PLAYER" and self.PlayerTable[Source] then
        TeamKill = self.PlayerTable[Source].Faction == self.PlayerTable[UnitName("player")].Faction and "YES" or "NO"
    end
    --self.SpiritHealerTimer = GetAreaSpiritHealerTime()
    
    local TargetSpreeCount = self.KillingSpreeTable[Dest] or 0
    self.KillingSpreeTable[Dest] = 0
    
    local PlayerSpreeCount
    if SourceType == "PLAYER" then
        PlayerSpreeCount = (self.KillingSpreeTable[Source] or 0) + 1
        self.KillingSpreeTable[Source] = PlayerSpreeCount
    end
    
    if SourceType ~= "OTHER" then
        if TeamKill == "YES" then
            self.TeamMultiKillTimer = 10
            self.TeamMultiKillCount = self.TeamMultiKillCount + 1
            if self:Count(self.TeamAceTable) == 0 then
                self.TeamAceTimer = 60
            end
            self.TeamAceTable[Dest] = true
        elseif TeamKill == "NO" then
            self.EnemyMultiKillTimer = 10
            self.EnemyMultiKillCount = self.EnemyMultiKillCount + 1
            if self:Count(self.EnemyAceTable) == 0 then
                self.EnemyAceTimer = 60
            end
            self.EnemyAceTable[Dest] = true
        end
    end
    
    local SP = self.SoundPacks[self.Settings["SOUNDPACK"]].Short
    local KillType, ScreenText, ChatText, ChatText2, ChatText3 FontSize = nil, "", "", nil, nil, nil
    if SP == "LOL" then
        if not FirstBlood and SourceType == "PLAYER" then -- First Blood
            FirstBlood = true        
            KillType = "FIRST_BLOOD"
            ScreenText = "FIRST BLOOD!"
            ChatText = string.format("%s has drawn first blood!", self:Unit(Source))
        elseif SourceType == "PLAYER" and (TeamKill == "YES" and self.TeamMultiKillCount >= 2 or TeamKill == "NO" and self.EnemyMultiKillCount >= 2) then -- Multi Kills
            if TeamKill == "YES" and self.TeamMultiKillCount == 2 or TeamKill == "NO" and self.EnemyMultiKillCount == 2 then -- Double
                KillType = "DOUBLE"
                ScreenText = "DOUBLE KILL!"
                ChatText = string.format("%s has slain %s for a double kill!", self:Unit(Source), self:Unit(Dest))
            elseif TeamKill == "YES" and self.TeamMultiKillCount == 3 or TeamKill == "NO" and self.EnemyMultiKillCount == 3 then -- Triple
                KillType = "TRIPLE"
                ScreenText = "TRIPLE KILL!"
                ChatText = string.format("%s has slain %s for a triple kill!", self:Unit(Source), self:Unit(Dest))
            elseif TeamKill == "YES" and self.TeamMultiKillCount == 4 or TeamKill == "NO" and self.EnemyMultiKillCount == 4 then -- Quadra
                KillType = "QUADRA"
                ScreenText = "QUADRA KILL!"
                ChatText = string.format("%s has slain %s for a quadra kill!", self:Unit(Source), self:Unit(Dest))
            elseif TeamKill == "YES" and self.TeamMultiKillCount == 5 or TeamKill == "NO" and self.EnemyMultiKillCount == 5 then -- Penta
                KillType = "PENTA"
                ScreenText = "PENTA KILL!"
                ChatText = string.format("%s has slain %s for a penta kill!", self:Unit(Source), self:Unit(Dest))
            else -- Legendary
                KillType = "LEGENDARY"
                ScreenText = "LEGENDARY KILL!"
                ChatText = string.format("%s has slain %s for a legendary kill!", self:Unit(Source), self:Unit(Dest))
            end
        elseif TargetSpreeCount >= 3 then -- Shut down
            KillType = "SHUT_DOWN"
            ScreenText = "SHUT DOWN!"
            ChatText = string.format("%s has ended %s's killing spree!", self:Unit(Source), self:Unit(Dest))
        elseif SourceType ~= "PLAYER" then -- Executed
            KillType = "EXECUTED"
            ScreenText = string.format("|cFF808080%s|r has slain %s!",Source or "<Unknown>",self:Unit(Dest))
            ChatText = string.format("|cFF808080%s|r has slain %s!",Source or "<Unknown>",self:Unit(Dest))
        elseif PlayerSpreeCount <= 2 then -- Normal Kills
            KillType = (Source == UnitName("player") or Dest == UnitName("player")) and "YOU_SLAIN" or "SLAIN"
            ScreenText = string.format("%s has slain %s!",self:Unit(Source),self:Unit(Dest))
            ChatText = string.format("%s has slain %s!",self:Unit(Source),self:Unit(Dest))
        elseif PlayerSpreeCount == 3 then -- Killing Spree
            KillType = "SPREE"
            ScreenText = string.format("%s is on a killing spree!",self:Unit(Source))
            ChatText = string.format("%s is on a killing spree!", self:Unit(Source))
        elseif PlayerSpreeCount == 4 then -- Rampage
            KillType = "RAMPAGE"
            ScreenText = string.format("%s is on a rampage!",self:Unit(Source))
            ChatText = string.format("%s is on a rampage!", self:Unit(Source))
        elseif PlayerSpreeCount == 5 then -- Unstoppable
            KillType = "UNSTOPPABLE"
            ScreenText = Source == UnitName("player") and "You are unstoppable!" or self:Unit(Source).." is unstoppable!"
            ChatText = Source == UnitName("player") and "You are unstoppable!" or self:Unit(Source).." is unstoppable!"
        elseif PlayerSpreeCount == 6 then -- Dominating
            KillType = "DOMINATING"
            ScreenText = Source == UnitName("player") and "You are dominating!" or self:Unit(Source).." is dominating!"
            ChatText = Source == UnitName("player") and "You are dominating!" or self:Unit(Source).." is dominating!"
        elseif PlayerSpreeCount == 7 then -- Godlike
            KillType = "GODLIKE"
            ScreenText = Source == UnitName("player") and "You are godlike!" or self:Unit(Source).." is godlike!"
            ChatText = Source == UnitName("player") and "You are godlike!" or self:Unit(Source).." is godlike!"
        elseif PlayerSpreeCount >= 8 then -- Legendary
            KillType = "LEGENDARY"
            ScreenText = Source == UnitName("player") and "You are legendary!" or self:Unit(Source).." is legendary!"
            ChatText = Source == UnitName("player") and "You are legendary!" or self:Unit(Source).." is legendary!"
        else
            return
        end
    elseif SP == "DOTA" then
        if TargetSpreeCount < 3 then
            ChatText = string.format("%s pwned %s's head!", self:Unit(Source), self:Unit(Dest))
        else
            ChatText = string.format("%s ended %s's killing spree!", self:Unit(Source), self:Unit(Dest))
        end
        
        if SourceType == "PLAYER" then
            if not FirstBlood and SourceType == "PLAYER" then -- First Blood
                FirstBlood = true
                KillType = "FIRST_BLOOD"
                ScreenText = string.format("%s drew first blood by killing %s!", self:Unit(Source), self:Unit(Dest))
                ChatText2 = string.format("%s just drew |cFFFF0000first blood|r!", self:Unit(Source))
            elseif PlayerSpreeCount == 3 then -- Killing Spree
                KillType = "KILLING_SPREE"
                ScreenText = string.format("%s is on a killing spree!", self:Unit(Source))
                ChatText2 = string.format("%s is on a |cFF33CC33killing spree|r!", self:Unit(Source))
            elseif PlayerSpreeCount == 4 then -- Dominating
                KillType = "DOMINATING"
                ScreenText = string.format("%s is dominating!", self:Unit(Source))
                ChatText2 = string.format("%s is |cFF9900CCdominating|r!", self:Unit(Source))
            elseif PlayerSpreeCount == 5 then -- Mega Kill
                KillType = "MEGA_KILL"
                ScreenText = string.format("%s has a Mega Kill!", self:Unit(Source))
                ChatText2 = string.format("%s has a |cFFCC0066Mega Kill|r!", self:Unit(Source))
            elseif PlayerSpreeCount == 6 then -- Unstoppable
                KillType = "UNSTOPPABLE"
                ScreenText = string.format("%s is Unstoppable!", self:Unit(Source))
                ChatText2 = string.format("%s is |cFFB82EE6Unstoppable|r!", self:Unit(Source))
            elseif PlayerSpreeCount == 7 then -- Wicked Sick
                KillType = "WICKED_SICK"
                ScreenText = string.format("%s is Wicked Sick!", self:Unit(Source))
                ChatText2 = string.format("%s is |cFF5C8A00Wicked Sick!|r", self:Unit(Source))
            elseif PlayerSpreeCount == 8 then -- Monster Kill
                KillType = "MONSTER_KILL"
                ScreenText = string.format("%s has a monster kill!!", self:Unit(Source))
                ChatText2 = string.format("%s has a |cFFE68AB8monster kill|r!!", self:Unit(Source))
            elseif PlayerSpreeCount == 9 then -- Godlike
                KillType = "GODLIKE"
                ScreenText = string.format("%s is GODLIKE!!!", self:Unit(Source))
                ChatText2 = string.format("%s is |cFFFF0000GODLIKE|r!!!", self:Unit(Source))
            elseif PlayerSpreeCount >= 10 then -- Beyond Godlike/Holy Shit (somebody stop/kill him!)
                KillType = "HOLY_SHIT"
                ScreenText = string.format("%s is beyond GODLIKE!", self:Unit(Source))
                ChatText2 = string.format("%s is |cFFFF7519beyond GODLIKE|r! Somebody "..(math.random(0,1) == 0 and "KILL" or "STOP").." HIM!!!", self:Unit(Source))
            end
            
            if TeamKill == "YES" and self.TeamMultiKillCount >= 2 or TeamKill == "NO" and self.EnemyMultiKillCount >= 2 then -- Multi Kills
                if TeamKill == "YES" and self.TeamMultiKillCount == 2 or TeamKill == "NO" and self.EnemyMultiKillCount == 2 then -- Double
                    KillType = "DOUBLE"
                    ScreenText = "DOUBLE KILL!"
                    ChatText3 = string.format("%s just got a |cFF0000FFDouble Kill!|r", self:Unit(Source))
                elseif TeamKill == "YES" and self.TeamMultiKillCount == 3 or TeamKill == "NO" and self.EnemyMultiKillCount == 3 then -- Triple
                    KillType = "TRIPLE"
                    ScreenText = "TRIPLE KILL!"
                    ChatText3 = string.format("%s just got a |cFF00E600Triple Kill|r!", self:Unit(Source))
                elseif TeamKill == "YES" and self.TeamMultiKillCount == 4 or TeamKill == "NO" and self.EnemyMultiKillCount == 4 then -- Ultra Kill
                    KillType = "ULTRA_KILL"
                    ScreenText = "ULTRA KILL!!"
                    ChatText3 = string.format("%s just got an |cFF33CCFFUltra Kill|r!", self:Unit(Source))
                elseif TeamKill == "YES" and self.TeamMultiKillCount == 5 or TeamKill == "NO" and self.EnemyMultiKillCount == 5 then -- Rampage
                    KillType = "RAMPAGE"
                    ScreenText = "RAMPAGE!!!"
                    ChatText3 = string.format("%s is on a |cFF2E8AE6Rampage|r!", self:Unit(Source))
                else -- Ownage
                    KillType = "OWNAGE"
                    ScreenText = "OWNAGE!!!"
                    ChatText3 = string.format(TeamKill == "YES" and "Your team is %s" or "Enemies are %s", "|cFFFF0000OWNING!!!|r")
                end
            end
        end
    elseif SP == "HON" or SP == "HON_2" then
        if TargetSpreeCount < 3 then
            ChatText = string.format("%s pwned %s's head!", self:Unit(Source), self:Unit(Dest))
        else
            ChatText = string.format("%s ended %s's killing spree!", self:Unit(Source), self:Unit(Dest))
        end
        
        if SourceType ~= "PLAYER" then -- Denied
            KillType = "DENIED"
            ScreenText = string.format("|cFF808080%s|r has slain %s!",Source or "<Unknown>",self:Unit(Dest))
            ChatText = string.format("|cFF808080%s|r has slain %s!",Source or "<Unknown>",self:Unit(Dest))
        elseif not FirstBlood then -- Bloodlust
            FirstBlood = true        
            KillType = "BLOODLUST"
            ScreenText = "BLOODLUST"
            ChatText2 = string.format("%s has |cFFFF0000bloodlust|r!", self:Unit(Source))
        elseif PlayerSpreeCount == 3 then -- Smackdown (HON) / Serial Killer (HON_2)
            if SP == "HON" then
                KillType = "SMACKDOWN"
                ScreenText = string.format("SMACKDOWN", self:Unit(Source))
                ChatText2 = string.format("%s got a |cFF00CC66smack down|r kill!", self:Unit(Source))
            else
                KillType = "SERIAL_KILLER"
                ScreenText = string.format("SERIAL KILLER", self:Unit(Source))
                ChatText2 = string.format("%s is a |cFF00CC66serial killer|r!", self:Unit(Source))
            end
        elseif PlayerSpreeCount == 4 then -- Ultimate Warrior
            KillType = "ULTIMATE_WARRIOR"
            ScreenText = string.format("ULTIMATE WARRIOR", self:Unit(Source))
            ChatText2 = string.format("%s is an |cFF6600CCUltimate Warrior|r!", self:Unit(Source))
        elseif PlayerSpreeCount == 5 then -- Legendary
            KillType = "LEGENDARY"
            ScreenText = string.format("LEGENDARY", self:Unit(Source))
            ChatText2 = string.format("%s is |cFFCC00FFLegendary|r!", self:Unit(Source))
        elseif PlayerSpreeCount == 6 then -- Onslaught
            KillType = "ONSLAUGHT"
            ScreenText = string.format("ONSLAUGHT", self:Unit(Source))
            ChatText2 = string.format("%s is on an |cFFFF9933Onslaught|r!", self:Unit(Source))
        elseif SP == "HON_2" and PlayerSpreeCount >= 7 or PlayerSpreeCount == 7 then -- Dominating
            KillType = "DOMINATING"
            ScreenText = string.format("DOMINATION", self:Unit(Source))
            ChatText2 = string.format("%s is |cFFED69AAdominating|r!!!", self:Unit(Source))
        elseif PlayerSpreeCount == 8 then -- Bloodbath (HON)
            KillType = "BLOODBATH"
            ScreenText = string.format("BLOODBATH", self:Unit(Source))
            ChatText2 = string.format("%s is |cFFFF0000bloodbath|r!!!", self:Unit(Source))
        elseif PlayerSpreeCount >= 9 then -- Immortal (HON)
            KillType = "IMMORTAL"
            ScreenText = string.format("IMMORTAL", self:Unit(Source))
            ChatText2 = string.format("%s is |cFFFF0000immortal|r!!!", self:Unit(Source))
        end
            
        if SourceType == "PLAYER" and (TeamKill == "YES" and self.TeamMultiKillCount >= 2 or TeamKill == "NO" and self.EnemyMultiKillCount >= 2) then -- Multi Kills
            if TeamKill == "YES" and self.TeamMultiKillCount == 2 or TeamKill == "NO" and self.EnemyMultiKillCount == 2 then -- Double
                KillType = "DOUBLE_TAP"
                ScreenText = "DOUBLE TAP"
                ChatText3 = string.format("%s just got a |cFF0000E6Double Tap|r!!", self:Unit(Source))
            elseif TeamKill == "YES" and self.TeamMultiKillCount == 3 or TeamKill == "NO" and self.EnemyMultiKillCount == 3 then -- Triple
                KillType = "HAT_TRICK"
                ScreenText = "HAT TRICK"
                ChatText3 = string.format("%s just got a |cFF66FF66Hat-trick|r!!!", self:Unit(Source))
            elseif TeamKill == "YES" and self.TeamMultiKillCount == 4 or TeamKill == "NO" and self.EnemyMultiKillCount == 4 then -- Quad Kill
                KillType = "QUAD_KILL"
                ScreenText = "QUAD KILL"
                ChatText3 = string.format("%s just got a |cFF66FF66Quad Kill|r!!!", self:Unit(Source))
            elseif TeamKill == "YES" and self.TeamMultiKillCount == 5 or TeamKill == "NO" and self.EnemyMultiKillCount == 5 
                or TeamKill == "YES" and self.TeamMultiKillCount >= 5 or TeamKill == "NO" and self.EnemyMultiKillCount >= 5 and SP == "HON" then -- Annihilation
                KillType = "ANNIHILATION"
                ScreenText = "ANNIHILATION"
                ChatText3 = string.format("%s has |cFF66FF66ANNIHILATED|r his opponents!!!", self:Unit(Source))
            else -- Masacre (HON_2)
                KillType = "MASACRE"
                ScreenText = "MASACRE"
                ChatText3 = string.format(TeamKill == "YES" and "Your team is %s" or "Enemies are %s", "|cFFFF0000OWNING!!!|r")
            end
        end
    else
        return
    end

    -- Prepare Text/Textures
    local SourceTexture = SourceType == "PLAYER" and self.PlayerTable[Source] and self.ClassIconsFolder..self.Classes[strupper(self.PlayerTable[Source].Class)].Icon or nil
    local DestTexture = self.PlayerTable[Dest] and self.ClassIconsFolder..self.Classes[strupper(self.PlayerTable[Dest].Class)].Icon or nil
    -- Prepare Sound
    local FilePath
    if KillType then
        local Category = "KILL"
        if SP == "LOL" then
            Category = (KillType == "SHUT_DOWN" or KillType == "EXECUTED" or KillType == "FIRST_BLOOD" or not TeamKill) and "OTHERKILL" or TeamKill == "YES" and "TEAMKILL" or "ENEMYKILL"
        end
        local FileName, MinTime = self:GetRandomSoundInfo(self.Sounds[SP][Category][KillType])
        FilePath = FileName and self.SoundsFolder..self.SoundPacks[self.Settings["SOUNDPACK"]].SoundFolder.."\\"..self.SoundsSubfolders[Category].."\\"..FileName or ""
    end
    -- Print to Chat
    if self.Settings["ANNOUNCE_CHAT"] then
        if ChatText then
            self:Print(ChatText, TeamKill == "YES" and "33CC33" or TeamKill == "NO" and "CC0000" or "999999")
        end
        if ChatText2 then
            self:Print(ChatText2, "999999")
        end
        if ChatText3 then
            self:Print(ChatText3, "999999")
        end
    end
    -- Add to Announce Queue
    table.insert(self.AnnounceQueue,{LeftIcon = SourceTexture, RightIcon = DestTexture, Text = ScreenText, Sound = FilePath, Time = MinTime, Color = (TeamKill == "YES" and {0.2,0.8,0.2} or TeamKill == "NO" and {0.8,0,0} or {0.6,0.6,0.6})})

    if SP == "LOL" or SP == "HON" or SP == "HON_2" then
        -- Check if Ace/Genocide
        local Ace = false
        if TeamKill == "YES" then
            local num = self.NumPlayers[UnitFactionGroup("player") == "Horde" and 1 or 0]
            if num and num >= 3 and self:Count(self.TeamAceTable) >= num then
                self.TeamAceTable = {}
                Ace = true
            end
        elseif TeamKill == "NO" and self.PlayerTable[Source] then
            local num = self.NumPlayers[UnitFactionGroup("player") == "Horde" and 0 or 1]
            if num and num >= 5 and self:Count(self.EnemyAceTable) >= num then
                self.EnemyAceTable = {}
                Ace = true
            end
        end
        -- Ace/Genocide scored by Source
        if Ace then
            local Category, Type, AceChatText, AceScreenText
            if SP == "LOL" then
                Category, Type = "OTHERKILL", "ACE"
                AceScreenText = string.format("%s has scored an ace!", self:Unit(Source))
                AceChatText = string.format("%s has scored an ace!", self:Unit(Source))
            elseif SP == "HON" or SP == "HON_2" then
                Category, Type = "KILL", "GENOCIDE"
                AceScreenText = string.format("GENOCIDE")
                local strFaction
                if TeamKill == "YES" then
                    strFaction = "|cFF00FF00"..(UnitFactionGroup("player") == "Horde" and "ALLIANCE" or "HORDE").."|r"
                else
                    strFaction = "|cFFFF0000"..(UnitFactionGroup("player") == "Horde" and "HORDE" or "ALLIANCE").."|r"
                end
                AceChatText = string.format("%s has been completely wiped out!!!", strFaction)
            end
            
            -- Prepare Sound
            local AceFileName, AceMinTime = self:GetRandomSoundInfo(self.Sounds[SP][Category][Type])
            local AceFilePath = AceFileName and self.SoundsFolder..self.SoundPacks[self.Settings["SOUNDPACK"]].SoundFolder.."\\"..self.SoundsSubfolders[Category].."\\"..AceFileName or ""
            
            -- Print to Chat
            if self.Settings["ANNOUNCE_CHAT"] then
                self:Print(AceChatText, TeamKill == "YES" and "33CC33" or TeamKill == "NO" and "CC0000")
            end
            -- Add to Announce Queue
            table.insert(self.AnnounceQueue,{LeftIcon = SourceTexture, RightIcon = "", Ace = 1, Text = AceScreenText, Sound = AceFilePath, Time = AceMinTime, Color = (TeamKill == "YES" and {0.2,0.8,0.2} or TeamKill == "NO" and {0.8,0,0})})
        end
    end
end

function GetTypeFromFlags(Flags)
    if bit.band(Flags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 then
        return "PLAYER"
    elseif bit.band(Flags, COMBATLOG_OBJECT_TYPE_PET) ~= 0 or bit.band(Flags, COMBATLOG_OBJECT_TYPE_GUARDIAN) ~= 0 then
        return "PET"
    else 
        return "OTHER"
    end
end

BGL.LastHits = {}
function BGL:COMBAT_LOG_EVENT_UNFILTERED(...)
    if not BGL.Settings["ENABLED"] or not UnitInBattleground("player") then return end
    local timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = ... -- Wotlk
--  local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags =  ... -- Cata

    if event == "SWING_DAMAGE" or event == "RANGE_DAMAGE" or event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" then
        --local overkill = select(event == "SWING_DAMAGE" and 10 or 13, ...) -- Wotlk
        --local overkill = select(event == "SWING_DAMAGE" and 13 or 16, ...) -- Cata
        if not self.PlayerTable[destName] and not GetTypeFromFlags(destFlags) ~= "PLAYER" then
            return
        end
        self.LastHits[destName] = {Source = sourceName, SourceType = GetTypeFromFlags(sourceFlags), Expire = floor(timestamp)+1}
        --[[
        if overkill > 0 then
            self:PlayerKill(sourceName, GetTypeFromFlags(sourceFlags), destName)
            self.LastHits[destName] = nil
        else
            self.LastHits[destName] = {Source = sourceName, SourceType = GetTypeFromFlags(sourceFlags), Expire = floor(timestamp)+1}
        end
        ]]
    elseif event == "UNIT_DIED" and self.LastHits[destName] then
        if floor(timestamp) <= self.LastHits[destName].Expire then
            self:PlayerKill(self.LastHits[destName].Source, self.LastHits[destName].SourceType, destName)
        end
        self.LastHits[destName] = nil
    end
end

function BGL:Count(Table)
    local i = 0
    for key,value in pairs(Table) do
        if key and value then
            i = i + 1
        end
    end
    return i
end

function BGL:ZONE_CHANGED_NEW_AREA()
    if select(2, IsInInstance()) == "pvp" then
        if self.BattleActive then return end
        self.BattleActive = true
        self.PlayerTable = {}
        self.KillingSpreeTable = {}
        RequestBattlefieldScoreData()
        self:RescheduleTimer("REQUEST_BATTLEFIELD_SCORE_DATA", 5)
    else
        self.BattleActive = false
    end
end

function BGL:UPDATE_BATTLEFIELD_SCORE()
    local NumPlayers = {}
    for i=1,GetNumBattlefieldScores() do
        local Name, _, _, _, _, Faction, _, _, Class, _, _, _, _, _, _, TalentSpec = GetBattlefieldScore(i)
        if not self.PlayerTable[Name] or not self.PlayerTable[Name].Faction or not self.PlayerTable[Name].Class then
            self.PlayerTable[Name] = {Faction = Faction, Class = Class}
        end
        NumPlayers[Faction] = (NumPlayers[Faction] or 0) + 1
    end
    self.NumPlayers = NumPlayers
end

BGL.StartSoonMessages = {
    ["The Battle for Eye of the Storm begins in 30 seconds."] = "EotS",
    ["The Battle for Arathi Basin begins in 30 seconds. Prepare yourselves!"] = "AB",
    ["The Battle for Alterac Valley begins in 30 seconds. Prepare yourselves!"] = "AV",
    ["The battle for Warsong Gulch begins in 30 seconds. Prepare yourselves!"] = "WG",
    ["The battle for Strand of the Ancients begins in 30 seconds!."] = "SotA",
    ["The battle for Strand of the Ancients begins in 30 seconds. Prepare yourselves!"] = "SotA",
    ["Round 2 begins in 30 seconds. Prepare yourselves!"] = "SotA",
    ["Round 3 begins in 30 seconds. Prepare yourselves!"] = "SotA",
    ["The battle begins in 30 seconds!"] = "IoC",
    ["The battle will begin in 30 seconds!"] = "IoC",
--  ["The battle for Twin Peaks begins in 30 seconds. Prepare yourselves!"] = "TP", -- Cata
--  ["The Battle for Gilneas begins in 30 seconds. Prepare yourselves!"] = "TBfG", -- Cata
}
function BGL:CHAT_MSG_BG_SYSTEM_NEUTRAL(Message)
    if self.StartSoonMessages[Message] then
        table.insert(self.Timers, {Name = "START_10S", Delay = 20})
        table.insert(self.Timers, {Name = "START", Delay = 30})
        
        local FileName, MinTime = self:GetRandomSoundInfo(self.Sounds[self.SoundPacks[self.Settings["SOUNDPACK"]].Short]["GAME"]["BATTLE_BEGIN_30S"])
        local FilePath = FileName and self.SoundsFolder..self.SoundPacks[self.Settings["SOUNDPACK"]].SoundFolder.."\\"..self.SoundsSubfolders["GAME"].."\\"..FileName or ""
        table.insert(self.AnnounceQueue,{Text = "Thirty seconds until the battle begins!", Sound = FilePath, Time = 5, Color = {1,0.8,0}})
    end
end

function BGL:GetRandomSoundInfo(Sounds)
    return Sounds and unpack(Sounds[math.random(1,#Sounds)]) or unpack({nil,nil})
end

function BGL:UPDATE_BATTLEFIELD_STATUS()
    if not BGL.BattleActive then return end
    local WinnerFaction = GetBattlefieldWinner()
    if WinnerFaction ~= nil then
        BGL.BattleActive = false
        
        local Win = WinnerFaction == self.PlayerTable[UnitName("player")].Faction
        local Type, Text = Win and "VICTORY" or "DEFEAT", Win and "VICTORY!" or "DEFEAT!"
        local FileName, MinTime = self:GetRandomSoundInfo(self.Sounds[self.SoundPacks[self.Settings["SOUNDPACK"]].Short]["GAME"][Type])
        local FilePath = FileName and self.SoundsFolder..self.SoundPacks[self.Settings["SOUNDPACK"]].SoundFolder.."\\"..self.SoundsSubfolders["GAME"].."\\"..FileName or ""
        table.insert(self.AnnounceQueue,{Text = Text, Sound = FilePath, Time = 5, Color = {0.8,0,0}})
    end
end

function BGL:CHAT_MSG_ADDON(Prefix,Message,Channel,Sender)
    if Prefix ~= "BGL" or Sender == UnitName("player") then return end
    local Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7 = strsplit(":",Message)
    
    if Channel == "GUILD" or Channel == "BATTLEGROUND" then
        if Arg1 == "RequestVersion" then
            self:SendAddonMessage("Version:"..self.Version, "WHISPER", Sender)
        end
    elseif Channel == "WHISPER" then
        if Arg1 == "Version" then
            self.AddonUsers[Sender] = Arg2
            self:RescheduleTimer("PrintAddonUsers", 3)
        end
    end
end

function BGL:DefineIfNotSet(Setting, Value)
    if BGL.Settings[Setting] == nil then
        BGL.Settings[Setting] = Value
    end
end

function BGL:ADDON_LOADED(addon)
    if addon ~= "BGLegends" then return end
    BGL_Settings = BGL_Settings or {}
    self.Settings = BGL_Settings
    self:DefineIfNotSet("ENABLED", true)
    self:DefineIfNotSet("SOUNDPACK", 1)
    if type(self.Settings["SOUNDPACK"]) ~= "number" then self.Settings["SOUNDPACK"] = 1 end
    self:DefineIfNotSet("ANNOUNCE_CHAT", true)
    self:DefineIfNotSet("ANNOUNCE_SCREEN", true)
    self:DefineIfNotSet("ANNOUNCE_SOUND", true)
    self:DefineIfNotSet("ANNOUNCECOLOR_GAME", {1,0.8,0})
    self:DefineIfNotSet("ANNOUNCECOLOR_TEAMKILL", {0.2,0.8,0.4})
    self:DefineIfNotSet("ANNOUNCECOLOR_ENEMYKILL", {0.8,0,0})
    
    BGL_Options:Initialize()
    BGL_Announcer:Initialize()
    
    SLASH_BGL1 = '/bgl';
    
    self.PlayerTable[UnitName("player")] = {Faction = (UnitFactionGroup("player") == "Horde" and 0 or 1), Class = select(2,UnitClass("player"))}
    
    self:Print("Addon is "..(self.Settings["ENABLED"] and "|cFF00FF00enabled|r" or "|cFFFF0000disabled|r").."! Use /BGL to show the interface.")
    self:RegisterEvents()
end

BGL:RegisterEvent("ADDON_LOADED")