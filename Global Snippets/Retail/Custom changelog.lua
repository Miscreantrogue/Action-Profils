local TMW                                   = TMW
local A     								= Action
local TeamCache								= Action.TeamCache
local EnemyTeam								= Action.EnemyTeam
local FriendlyTeam							= Action.FriendlyTeam
local LoC									= Action.LossOfControl
local Player								= Action.Player 
local MultiUnits							= Action.MultiUnits
local UnitCooldown							= Action.UnitCooldown
local ActiveUnitPlates						= MultiUnits:GetActiveUnitPlates()
local next, pairs, type, print              = next, pairs, type, print
local IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo = IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo
local UnitIsPlayer, UnitExists, UnitGUID    = UnitIsPlayer, UnitExists, UnitGUID
local PetLib                                = LibStub("PetLibrary")
local Unit                                  = Action.Unit 
local huge                                  = math.huge
local UnitBuff                              = _G.UnitBuff
local UnitIsUnit                            = UnitIsUnit
local StdUi 								= LibStub("StdUi")
-- Lua
local error                                 = error
local setmetatable                          = setmetatable
local stringformat                          = string.format
local tableinsert                           = table.insert
local TR                                    = Action.TasteRotation


-------------------------------------------------------------------------------
-- Profil Loader
-------------------------------------------------------------------------------
-- Load default profils for each class
local currentClass = select(2, UnitClass("player"))
local currentSpec = GetSpecialization()
local currentSpecName = currentSpec and select(2, GetSpecializationInfo(currentSpec)) or "None"
--print(currentSpec)

-- Druid
if currentClass == "WARRIOR" then
    Action.Data.DefaultProfile[currentClass] = "> ZakLL < Warrior"
end

if currentClass == "WARLOCK" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Warlock"
end

if currentClass == "ROGUE" then
    Action.Data.DefaultProfile[currentClass] = "> ZakLL < Rogue"
end

if currentClass == "SHAMAN" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Shaman"
end

if currentClass == "DEATHKNIGHT" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Death Knight"
end

if currentClass == "PRIEST" then
    Action.Data.DefaultProfile[currentClass] = "[ZakLL]Action - Priest"
end

if currentClass == "PALADIN" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Paladin"
end

if currentClass == "MAGE" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Mage"
end

if currentClass == "HUNTER" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Hunter"
end

if currentClass == "DEMONHUNTER" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Demon Hunter"
end

if currentClass == "DRUID" then
    Action.Data.DefaultProfile[currentClass] = "[Taste&ZakLL]Action - Druid"
end



--------------------------------------
--------- POPUP/CHANGELOG API --------
--------------------------------------

TR.Popup = {
    popupname = Action.PlayerSpec,
    message = "",
	button1 = "",
	button2 = "",
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,	
}

--Initiate everyclasses 


-- @Usage TR:CreatePopup(PlayerSpec, TR.PlayerSpec.Changelog, "OK", nil, 0, true, true)
function TR:CreatePopup(popupname, message, button1, button2, timeout, whileDead, hideOnEscape)
    local Errormessage = "Error on popup : You did not set any message."
    local Errorbutton = "Cancel"
	--local PlayerSpec = Action.PlayerSpec
	
	if popupname then
	    TR.Popup.popupname = popupname
	else
	    TR.Popup.popupname = 999
	end
	
	if message then 
	    TR.Popup.message = message
	else
	    TR.Popup.message = Errormessage
	end
	
	if button1 then
	    TR.Popup.button1 = button1
	else
	    TR.Popup.button1 = Errorbutton
	end
	
	if button2 then
	    TR.Popup.button2 = button2
	else
	    TR.Popup.button2 = Errorbutton
	end	
	
	if timeout then 
	    TR.Popup.timeout = timeout
	else
	    TR.Popup.timeout = 0
	end
	
	if whileDead then
	    TR.Popup.whileDead = whileDead
	end
	
	if hideOnEscape then
	    TR.Popup.hideOnEscape = hideOnEscape
	end   
	
	return TR.Popup.popupname, TR.Popup.message, TR.Popup.button1, TR.Popup.button2, TR.Popup.timeout, TR.Popup.whileDead, TR.Popup.hideOnEscape
	
end

-- Changelog handler for each specialisation
function TR:UpdateChangeLog()
local PlayerSpec = Action.PlayerSpec

--------------------
------ SHAMAN ------
--------------------
	-- Elemental
	if PlayerSpec == 262 then
	    ChangeLog = [[
		Welcome to Taste - Elemental Shaman !
		
List of latest changes :

- Fixed Elemental Blast behavior
- Reworked DBM opener
- Fixed Healing Surge				

As always, please report on Discord or message me directly if you need anything !
]]  

	end	
	-- Enhancement
	if PlayerSpec == 263 then
	    ChangeLog = [[
		Welcome to Taste - Enhancement Shaman !
		
List of latest changes :

- Improved PvP Logics
- Fixed Interrupts
- Added logic for Counter Strike Totem				

As always, please report on Discord or message me directly if you need anything !
]]  

	end
	
	-- Restoration
	if PlayerSpec == 264 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."					
	end
	
--------------------
----- PALADIN ------
--------------------	
	-- Retribution
	if PlayerSpec == 70 then
	    ChangeLog = [[
		Welcome to Taste - Retribution Paladin !
		
List of latest changes :

- Fixed Wake of Ashes
- Fixed Party Dispell texture icon
- Fixed Divine Storm usage
- Fixed Templar Verdict never used				
- Added Interrupt UI settings

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end
	
	-- Protection
	if PlayerSpec == 66 then
	    ChangeLog = [[
		Welcome to Taste - Protection Paladin !
		
List of latest changes :

- Fixed Auto taunt issue
- Fixed Consecration logic
- Added moves in ProfileUI			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end
	
	-- Holy
	if PlayerSpec == 65 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."					
	end

--------------------
----- WARLOCK ------
--------------------
	-- Affliction
	if PlayerSpec == 265 then
	    ChangeLog = [[
		Welcome to Taste - Affliction Warlock !
		
List of latest changes :

- Added Player ping to spells prediction
- Fixed Fear spam in certain situations			
- Added Interrupt UI settings

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Demonology
	if PlayerSpec == 266 then
	    ChangeLog = [[
		Welcome to Taste - Demonology Warlock !
		
List of latest changes :

- Third version of Imp Tracker system. Now really good ! NO MOAR LUA ERROR
- Fixed issue with DreadStalkers
- Added logic for PvP Fear (arena123)
- Added Auto NetherWard in Arena if dangerous or cc is casted by unit
- Pet Stun should be fixed now
- Added more UI settings for Implosion
- Added multiple range detection mode in ProfileUI		
- Added Interrupt UI settings

IMPORTANT: IF YOU SEE THE ROTATION IS NOT USING IMPLOSION AND YOU GOT SUFFISANT NUMBER OF IMPS THEN TRY A /RELOAD 		

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Destruction
	if PlayerSpec == 267 then
	    ChangeLog = [[
		Welcome to Taste - Destruction Warlock !
		
List of latest changes :

- Reworked AoE logic with Havoc
- Fixed issue with Chaos Bolt not being used with 4+ shards
- Fixed issue with Havoc pool when AoE is off
- Fixed Fear spam issue
- Added Interrupt UI settings

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end	
	


--------------------
----- WARRIOR ------
--------------------
	-- Arms
	if PlayerSpec == 71 then
	    ChangeLog = [[
		Welcome to Taste - Arms Warrior !
		
List of latest changes :

- Massive update for 8.3
- Fixed issue with Battle Shout spam			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Fury
	if PlayerSpec == 72 then
	    ChangeLog = [[
		Welcome to Taste - Fury Warrior !
		
List of latest changes :

- Massive update for 8.3
- Fixed issue with Battle Shout spam				

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Protection
	if PlayerSpec == 73 then
	    ChangeLog = [[
		Welcome to Taste - Protection Warrior !
		
List of latest changes :

- Massive 8.3 update
- Massive UI rework
- Reworked all defensives logic
- Fixed ShieldBlock used twice
- Fixed Rallying Cry issue
- Added UI for Rallying Cry
- Heroic Throw fix
- Victory Rush fix
- Revenge free procs should now work as intended			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end


--------------------
--- DEATHKNIGHT ----
--------------------
	-- Blood
	if PlayerSpec == 250 then
	    ChangeLog = [[
		Welcome to Taste - Blood Death Knight !
		
List of latest changes :

- Reworked all defensives logic
- Fixed Auto Taunt
- Fixed Arcane Torrent
- Improved DnD logic
- Added Area Time To Die for better AoE logic
- Improved Death Strike logic			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Frost
	if PlayerSpec == 251 then
	    ChangeLog = [[
		Welcome to Taste - Frost Death Knight !
		
List of latest changes :

- Improvement on Profile performance
- APLs update to 8.3
- Added Dummy Test option
- Reworked Breath of Sindragosa 
- Added new special macro for Breath of Sindragosa
- Fixed Pillar of Frost not being used without Breath of Sindragosa
- Added Memory of Lucid Dream UI
- Reworked Defensives logic			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Unholy
	if PlayerSpec == 252 then
	    ChangeLog = [[
		Welcome to Taste - Unholy Death Knight !
		
List of latest changes :

- Improvement on Profile performance
- APLs update to 8.3
- Added Dummy Test option
- Added PvP Features
- Pet Summon fixed
- Added UI for trinkets
- Fixed Single Target Apocalypse usage		
- Fixed Condensed Life Force logic
- Fixed Scourge Strike usage
- Reworked AoE logic with Feastering Wounds	

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end


--------------------
--- DEMON HUNTER ---
--------------------
	-- Havoc
	if PlayerSpec == 577 then
	    ChangeLog = [[
		Welcome to Taste - Havoc Demon Hunter !
		
List of latest changes :

- Added UI for BladeDance pool/sync with Eyebeam
- Added FelEruption + Manarift combo
- Added Imprison + Manarift combo
- Fixed DBM pull opener
- Added UI for Felblade PvP
			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Vengeance
	if PlayerSpec == 581 then
	    ChangeLog = [[
		Welcome to Taste - Vengeance Demon Hunter !
		
List of latest changes :

- Updated to 8.3 APLs
- Added Imprison as interrupt
- Fixed Concentrated Flame usage			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end


--------------------
------ ROGUE -------
--------------------
	-- Assassination
	if PlayerSpec == 259 then
	    ChangeLog = [[
		Welcome to Taste - Assassination Rogue !
		
List of latest changes :

- Fixed Rupture not being refreshed
- Fixed Toxic Blade usage
- Added check on Azerite Beam essence
- Fixed Crimson Tempest talent
- Updated APLs to 8.3
- Added Toxic Blade pool UI settings
- Reworked ST opener			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Outlaw
	if PlayerSpec == 260 then
	    ChangeLog = [[
		Welcome to Taste - Outlaw Rogue !
		
List of latest changes :

- Fixed Arcane Torrent logic
- Improved Profile performance
- Updated APLs to 8.3
- Fixed Auto SAP out of combat
- Update Marked For Death snipping on low health units
- Added BladeFlurry UI settings
- Added check on Azerite Beam essence				

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Subtlety
	if PlayerSpec == 261 then
	    ChangeLog = [[
		Welcome to Taste - Subtely Rogue !
		
This specialisation is currently outdated :(			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end


--------------------
------ HUNTER ------
--------------------
	-- BeastMastery
	if PlayerSpec == 253 then
	    ChangeLog = [[
		Welcome to Taste - BeastMastery Hunter !

List of latest changes :

- Fixed chat spam cause of pet spell not being in player spell bar (see above)
- Updated to 8.3 APLs
- Bestial Wrath special UI settings
- AoE detection fix
- Added new AoE detection choice for user
- Added Feign Death to avoid Thing from Beyond
- Reworked AoE rotation to improve uptime on Frenzy buff

IMPORTANT FOR BEASTMATERY : PLEASE ADD THE PET SPELL : CLAW, BITE OR SMACK DIRECTLY FROM PET SPELLBOOK TO YOUR SPELLBAR !
THIS IS USED FOR THE RANGE DETECTION BY YOUR PET WHICH IS CURRENTLY THE BEST DETECTION MODE :) ENJOY AND FEEL FREE TO TRY THE OTHER IF NEEDED FOR SPECIFICS CASES

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Marksmanship
	if PlayerSpec == 254 then
	    ChangeLog = [[
		Welcome to Taste - Marksmanship Hunter !
		
This specialisation is currently outdated :(			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Survival
	if PlayerSpec == 255 then
	    ChangeLog = [[
		Welcome to Taste - Survival Hunter !
		
This specialisation is currently outdated :(			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end


--------------------
------- MAGE -------
--------------------
	-- Arcane
	if PlayerSpec == 62 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."					
	end

	-- Fire
	if PlayerSpec == 63 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."					
	end

	-- MFrost
	if PlayerSpec == 64 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."					
	end


--------------------
------ DRUID -------
--------------------
	-- Balance
	if PlayerSpec == 102 then
	    ChangeLog = [[
		Welcome to Taste - Balance Druid !
		
This specialisation is currently outdated :(			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Feral
	if PlayerSpec == 103 then
	    ChangeLog = [[
		Welcome to Taste - Feral Druid !
		
This specialisation is currently outdated :(				

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Guardian
	if PlayerSpec == 104 then
	    ChangeLog = [[
		Welcome to Taste - Guardian Druid !
		
List of latest changes :

- Updated to 8.3 APLs
- Fix on AutoTaunt
- Fixed Arcane Torrent logic

TODO : Rework all defensives logic			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Restoration
	if PlayerSpec == 105 then
	    ChangeLog = [[
		Welcome to Taste - Restoration Druid !
		
List of latest changes :

- Fixed Catweaving rotation
- Reworked cooldowns usage
- Added more notification for user
- Profile performance improvements

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end


--------------------
------- MONK -------
--------------------
	-- Brewmaster
	if PlayerSpec == 268 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."					
	end

	-- Windwalker
	if PlayerSpec == 269 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."				
	end

	-- Mistweaver
	if PlayerSpec == 270 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."				
	end


--------------------
------ PRIEST ------
--------------------
	-- Discipline
	if PlayerSpec == 256 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."				
	end

	-- PHoly
	if PlayerSpec == 257 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."				
	end

	-- Shadow
	if PlayerSpec == 258 then
	    ChangeLog = [[
		Welcome to Taste - Shadow Priest !
		
This specialisation is currently outdated :(			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	return ChangeLog
end

-- Love Popup
StaticPopupDialogs["LOVE_POPUP"] = {
  text = "Hey there ! Thanks for clicking the love button :)\n\nLove is the most important part :)\n\nDon't forget that you can ask me whatever you want on rotations. Feedbacks are really appreciated if you got optimized gear for the current content and see some rotations mistakes !\n\nCreating good profils is long task and take a lot of time as you can imagine. I will always try to do my best to satisfy everyone so do not hesitate to discord me if needed!\n\nAlso if you really like my work you can make a little coffee donation to: paypal.me/roifok\n\nEvery donation is welcome but not mandatory.\n\nHave a good game and thanks for reading !\n\nPS:Don't forget to post logs on discord :)",
  button1 = "Okay :)",
  button2 = "Close",
  OnAccept = function()
      StaticPopup_Hide ("LOVE_POPUP")
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}

------------------------
-- CHANGELOG CALLBACK --
------------------------ 
TMW:RegisterCallback("TMW_ACTION_IS_INITIALIZED", function()
-- Spec specific Popup

local PlayerSpec = Action.PlayerSpec
local currentChangelog = TR:UpdateChangeLog()
local Errormessage = "Error on popup : You did not set any message."
local profileName = TMW.db:GetCurrentProfile()

  --  if Action.PlayerSpec then
        TR:CreatePopup(Action.PlayerSpec, currentChangelog, "Okay Taste", "Marry Me", 0, true, true)
   -- else
        --TR:CreatePopup(999, "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord.", "OK", nil, 0, true, true)
  --  end
	
	-- Create Popup Frame dynamically 
    StaticPopupDialogs[TR.Popup.popupname] = {
      text = TR.Popup.message, --"Do you want to greet the world today?",
      button1 = TR.Popup.button1, --"Yes", -- On ACCEPT
      button2 = TR.Popup.button2, --"No", -- On CANCEL
      OnAccept = function()
          StaticPopup_Hide (TR.Popup.popupname)
      end,
      OnCancel = function()
          StaticPopup_Show ("LOVE_POPUP")
      end,
      timeout = TR.Popup.timeout,
      whileDead = TR.Popup.whileDead,
      hideOnEscape = TR.Popup.hideOnEscape,
      preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
    }


    -- Check for Taste profils
    if PlayerSpec then
        if profileName:match("Taste") then
            if PlayerSpec then
                StaticPopup_Show (PlayerSpec)
	        end
        end
    end
	
end)





