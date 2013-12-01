-- **********************************************
-- * Name: Battleground Legends                 *
-- * Description: A battleground kill announcer *
-- * Author: Mihapro @MoltenWoW                 *
-- **********************************************

BGL_Announcer = CreateFrame("frame", "BGL_Announcer", UIParent)
function BGL_Announcer:Initialize()
    self:SetBackdrop({bgFile = "", edgeFile = "", edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0}})
    self:SetBackdropColor(0, 0, 0, 0)
    self:SetPoint("TOP", 0, -160)
    self:SetWidth(500)
    self:SetHeight(232)
    self:SetScript("OnUpdate", function(self, elapsed)
        if self.Outro then
            if BGL.Settings["ANNOUNCE_SCREEN"] and self.HasText then 
                self.Alpha = self.Alpha - elapsed*3
                if self.Alpha <= 0 then
                    self.Alpha = 0
                    self.Active = false
                    self.Outro = false
                end
            else
                self.Alpha = 0
                self.Active = false
                self.Outro = false
            end
            self:UpdateAlpha()
        elseif self.Intro then
            if BGL.Settings["ANNOUNCE_SCREEN"] and self.HasText then
                self.Alpha = self.Alpha + elapsed*3
                if self.Alpha >= 1 then
                    self.Alpha = 1
                    self.Intro = false
                end
            else
                self.Alpha = 0
                self.Intro = false
            end
            self:UpdateAlpha()
        elseif self.Active then
            self.ActiveTimer = self.ActiveTimer - elapsed
            if #BGL.AnnounceQueue > 0 and self.ActiveTimer <= 0.5 or self.ActiveTimer <= 0 then 
                self.Outro = true
            end
        elseif #BGL.AnnounceQueue > 0 then
            for i,Announcement in pairs(BGL.AnnounceQueue) do
                self:Change(Announcement)
                table.remove(BGL.AnnounceQueue,i)
                self.HasText = Announcement.Text ~= nil
                self.Intro = true
                self.Active = true
                break
            end
        end
    end)
    
    self.FontString = self:CreateFontString("BGL_A_FS", "ARTWORK", "GameFontNormal")
    self.FontString:SetPoint("TOP",0,-30)
    self.FontString:SetText("")
    self.FontString:SetFont("Interface\\AddOns\\BGLegends\\Fonts\\ARLRDBD.TTF", 32, "OUTLINE") --"Fonts\\FRIENDS.TTF"
    self.FontString:SetTextColor(1,1,1,0)
    self.FontString:SetShadowColor(1,1,1,0)
    self.FontString:SetShadowOffset(-1,-1)
    
    self.TextureLeft = self:CreateTexture(nil,"CENTER")
    self.TextureLeft:SetPoint("RIGHT","BGL_A_FS","LEFT",-10,0)
    self.TextureLeft:SetWidth(32)
    self.TextureLeft:SetHeight(32)
    self.TextureLeft:SetVertexColor(1,1,1,0)
    
    self.TextureRight = self:CreateTexture(nil,"CENTER")
    self.TextureRight:SetPoint("LEFT","BGL_A_FS","RIGHT",10,0)
    self.TextureRight:SetWidth(32)
    self.TextureRight:SetHeight(32)
    self.TextureRight:SetVertexColor(1,1,1,0)
    
    self.Intro = false
    self.Active = false
    self.ActiveTimer = 0
    self.Outro = false
    self.Alpha = 0

    self.Initialized = true
    self:Show()
end

function BGL_Announcer:UpdateAlpha()
    local r,g,b = self.FontString:GetShadowColor()
    self.FontString:SetTextColor(r,g,b,self.Alpha)
    self.FontString:SetShadowColor(r,g,b,self.Alpha/2)
    self.TextureLeft:SetVertexColor(1,1,1,self.Alpha)
    self.TextureRight:SetVertexColor(1,1,1,self.Alpha)
end

function BGL_Announcer:Change(Announcement)
    self.FontString:SetText(Announcement.Text)
    local r,g,b = unpack(Announcement.Color)
    self.FontString:SetTextColor(r,g,b,self.Alpha)
    self.FontString:SetShadowColor(r,g,b,self.Alpha/2)
    self.TextureLeft:SetTexture(Announcement.LeftIcon or "")
    self.TextureRight:SetTexture(Announcement.RightIcon or "")
    self.ActiveTimer = Announcement.Time or 2
    
    if BGL.Settings["ANNOUNCE_SOUND"] then
        PlaySoundFile(Announcement.Sound or "")
    end
end