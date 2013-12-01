-- **********************************************
-- * Name: Battleground Legends                 *
-- * Description: A battleground kill announcer *
-- * Author: Mihapro @MoltenWoW                 *
-- **********************************************

BGL_Options = CreateFrame("frame", "BGL_Options", UIParent)
function BGL_Options:Initialize()
    BGL_Options:Hide()
    
    BGL_Options:SetBackdrop({bgFile = "Interface\\TabardFrame\\TabardFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 25, insets = {left = 4, right = 4, top = 4, bottom = 4}})
    BGL_Options:SetBackdropColor(0, 0, 0, 0.7)
    BGL_Options:SetBackdropBorderColor(1,0.85,0)
    
    BGL_Options:SetPoint("TOP", 0, -160)
    BGL_Options:SetWidth(260)
    BGL_Options:SetHeight(172)
    BGL_Options:EnableMouse(true)
    BGL_Options:SetMovable(true)
    BGL_Options:RegisterForDrag("LeftButton")
    BGL_Options:SetUserPlaced(true)
    BGL_Options:SetScript("OnDragStart", function(self) self:StartMoving() end)
    BGL_Options:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    BGL_Options:SetFrameStrata("FULLSCREEN_DIALOG")
    
    local Title = BGL_Options:CreateFontString("BGL_Title", "ARTWORK", "GameFontNormal")
    Title:SetPoint("TOPLEFT", 12, -12)
    Title:SetTextColor(1,1,1) 
    Title:SetText("|cFF"..BGL.Colors["TITLE"].."Battleground Legends|r ("..BGL.Version..") - Options")
    Title:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
    Title:SetShadowOffset(1, -1)
    
    local Button = CreateFrame("button","BGL_BtnClose", BGL_Options, "UIPanelButtonTemplate")
    Button:SetHeight(14)
    Button:SetWidth(14)
    Button:SetPoint("TOPRIGHT", -12, -11)
    Button:SetText("x")
    Button:SetScript("OnClick", function(self) BGL_Options:Hide() end)
    
    local CheckBox
    CheckBox = CreateFrame("CheckButton", "BGL_CheckBox0", BGL_Options, "UICheckButtonTemplate")
    CheckBox:SetWidth(20)
    CheckBox:SetHeight(20)
    CheckBox:SetPoint("TOPLEFT", 8, -24)
    _G["BGL_CheckBox0Text"]:SetText("Enable battleground kill announcements")
    CheckBox:SetScript("OnShow",  function(self) self:SetChecked(BGL.Settings["ENABLED"]); _G["BGL_CheckBox0Text"]:SetTextColor(BGL.Settings["ENABLED"] and 0 or 1,BGL.Settings["ENABLED"] and 1 or 0,0); end)
    CheckBox:SetScript("OnClick", function(self) BGL.Settings["ENABLED"] = not BGL.Settings["ENABLED"]; _G["BGL_CheckBox0Text"]:SetTextColor(BGL.Settings["ENABLED"] and 0 or 1,BGL.Settings["ENABLED"] and 1 or 0,0); end)
    
    CheckBox = CreateFrame("CheckButton", "BGL_CheckBox1", BGL_Options, "UICheckButtonTemplate")
    CheckBox:SetWidth(20)
    CheckBox:SetHeight(20)
    CheckBox:SetPoint("TOPLEFT", 8, -40)
    _G["BGL_CheckBox1Text"]:SetTextColor(1,1,1)
    _G["BGL_CheckBox1Text"]:SetText("Print to chatframe")
    CheckBox:SetScript("OnShow",  function(self) self:SetChecked(BGL.Settings["ANNOUNCE_CHAT"]) end)
    CheckBox:SetScript("OnClick", function(self) BGL.Settings["ANNOUNCE_CHAT"] = not BGL.Settings["ANNOUNCE_CHAT"] end)
    
    CheckBox = CreateFrame("CheckButton", "BGL_CheckBox2", BGL_Options, "UICheckButtonTemplate")
    CheckBox:SetWidth(20)
    CheckBox:SetHeight(20)
    CheckBox:SetPoint("TOPLEFT", 8, -56)
    _G["BGL_CheckBox2Text"]:SetTextColor(1,1,1)
    _G["BGL_CheckBox2Text"]:SetText("Print on screen")
    CheckBox:SetScript("OnShow",  function(self) self:SetChecked(BGL.Settings["ANNOUNCE_SCREEN"]) end)
    CheckBox:SetScript("OnClick", function(self) BGL.Settings["ANNOUNCE_SCREEN"] = not BGL.Settings["ANNOUNCE_SCREEN"] end)
    
    CheckBox = CreateFrame("CheckButton", "BGL_CheckBox3", BGL_Options, "UICheckButtonTemplate")
    CheckBox:SetWidth(20)
    CheckBox:SetHeight(20)
    CheckBox:SetPoint("TOPLEFT", 8, -72)
    _G["BGL_CheckBox3Text"]:SetTextColor(1,1,1)
    _G["BGL_CheckBox3Text"]:SetText("Enable sound")
    CheckBox:SetScript("OnShow",  function(self) self:SetChecked(BGL.Settings["ANNOUNCE_SOUND"]) end)
    CheckBox:SetScript("OnClick", function(self) BGL.Settings["ANNOUNCE_SOUND"] = not BGL.Settings["ANNOUNCE_SOUND"] end)
    
    local FS = BGL_Options:CreateFontString("BGL_FS1", "ARTWORK", "GameFontNormal")
    FS:SetPoint("TOPLEFT", 8, -94)
    FS:SetText("Sound pack:")
    FS:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
    
    self.CB_SP = {}
    local LocY = -104
    for i=1,#BGL.SoundPacks do
        local CheckBox = CreateFrame("CheckButton", "BGL_CB_SP_"..BGL.SoundPacks[i].Short, BGL_Options, "UICheckButtonTemplate")
        CheckBox:SetWidth(20)
        CheckBox:SetHeight(20)
        CheckBox:SetPoint("TOPLEFT", 8, LocY)
        _G["BGL_CB_SP_"..BGL.SoundPacks[i].Short.."Text"]:SetTextColor(1,1,1)
        _G["BGL_CB_SP_"..BGL.SoundPacks[i].Short.."Text"]:SetText(BGL.SoundPacks[i].Name)
        CheckBox:SetScript("OnShow",  function(self) self:SetChecked(BGL.Settings["SOUNDPACK"] == i) end)
        CheckBox:SetScript("OnClick", function(self) BGL_Options:UncheckSoundPacks(); self:SetChecked(true); BGL.Settings["SOUNDPACK"] = i; end)
        self.CB_SP[i] = CheckBox
        LocY = LocY - 14
    end
    
    local Button
    Button = CreateFrame("button", "BGL_Button", BGL_Options, "UIPanelButtonTemplate")
    Button:SetHeight(18)
    Button:SetWidth(72)
    Button:SetPoint("BOTTOMRIGHT", -12, 12)
    Button:SetText("Preview")
    Button:SetScript("OnClick", function(self)
        local TeamFaction, EnemyFaction = UnitFactionGroup("player") == "Horde" and 0 or 1, UnitFactionGroup("player") == "Horde" and 1 or 0
        BGL.NumPlayers = {[TeamFaction] = 1, [EnemyFaction] = 3}
        BGL.PlayerTable["Test Mage"] = {Faction = EnemyFaction, Class = "MAGE"}
        BGL.PlayerTable["Test Hunter"] = {Faction = EnemyFaction, Class = "HUNTER"}
        BGL.PlayerTable["Test Shaman"] = {Faction = EnemyFaction, Class = "SHAMAN"}
        BGL:RescheduleTimer("PREVIEW1", 1)
        BGL:RescheduleTimer("PREVIEW2", 4)
        BGL:RescheduleTimer("PREVIEW3", 7)
        BGL:RescheduleTimer("PREVIEW4", 10)
    end)
end

function BGL_Options:UncheckSoundPacks()
    for _,CB in pairs(self.CB_SP) do
        CB:SetChecked(false)
    end
end
