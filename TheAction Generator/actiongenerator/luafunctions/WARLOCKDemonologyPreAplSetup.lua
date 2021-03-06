------------------------------------------
-------- DEMONOLOGY PRE APL SETUP --------
------------------------------------------

local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
	TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
	TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

-- API - Spell v2
-- Lib:AddActionsSpells(owner, spells, useManagement, useSilence, delMacros)
Pet:AddActionsSpells(266, { 
	-- number accepted
	A.Felstorm.ID, -- Felstorm -- Dont work range is in tooltip so buggy ? 
	A.LegionStrike.ID, -- Legion Strike	
}, false)

-- API - Tracker v2
-- Initialize Tracker 
-- Lib:AddTrackers(A.PlayerSpec, Lib.Data.TrackersConfigPetID[A.PlayerSpec])
Pet:AddTrackers(266, Pet.Data.TrackersConfigPetID[266])
-- /dump LibStub("PetLibrary").Data.TrackersConfigPetID[266]
--[[Pet:AddTrackers(266, { 
	[98035] = {
		name = "Dreadstalker",
		duration = 12.25,
	},
	[55659] = {
		name = "Wild Imp",
		duration = 20,
	},
	--[143622] = {
	--	name = "Wild Imp",
	--	duration = 12,
	--},
	[17252] = {
		name = "Felguard",
		duration = 28,
	},
	[135002] = {
		name = "Demonic Tyrant",
		duration = 15,
	},
    [135816] = {
        name = "Vilefiend",
        duration = 15,
    },
})]]--

--local Pointer.PetGUIDs = Pet:GetTrackerGUID()
--local Pointer.PetIDs = Pet:GetTrackerData() -- this is table with [petID] = @table 
-- Pet Lib v2
local owner								= "PlayerSpec"
local Pointer = Pet.Data.Trackers[266]
local petID, petData = next(Pointer.PetIDs) 

-- Calculate future shard count
local function FutureShard()
    local Shard = Player:SoulShards()
    local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit(player):IsCasting()
    
	if not Unit(player):IsCasting() then
        return Shard
    else
        if spellID == A.NetherPortal.ID then
            return Shard - 1
        elseif spellID == A.CallDreadstalkers.ID and Unit(player):HasBuffs(A.DemonicCallingBuff.ID, true) == 0 then
            return Shard - 2
        elseif spellID == A.BilescourgeBombers.ID then
            return Shard - 2
        elseif spellID == A.SummonVilefiend.ID then
            return Shard - 1
        elseif spellID == A.GrimoireFelguard.ID then
            return Shard - 1
        elseif spellID == A.CallDreadstalkers.ID and Unit(player):HasBuffs(A.DemonicCallingBuff.ID, true) > 0 then
            return Shard - 1
        elseif spellID == A.SummonDemonicTyrant.ID and A.BalefulInvocation:GetAzeriteRank() > 0 then
            return 5
        elseif spellID == A.HandofGuldan.ID then
            if Shard > 3 then
                return Shard - 3
            else
                return 0
            end
        elseif spellID == A.Demonbolt.ID then
            if Shard >= 4 then
                return 5
            else
                return Shard + 2
            end
        elseif spellID == A.ShadowBolt.ID then
            if Shard == 5 then
                return Shard
            else
                return Shard + 1
            end
        elseif spellID == A.SoulStrike.ID then
            if Shard == 5 then
                return Shard
            else
                return Shard + 1
            end
        else
            return Shard
        end
    end
end

---------------------------
----- PETS MANAGEMENT -----
---------------------------
-- Example of use:
--[[
/dump LibStub("PetLibrary"):GetRemainDuration(135002)
/dump LibStub("PetLibrary"):IsActive(135002)
/dump LibStub("PetLibrary"):GetMainPet()
-- Callbacks 
local Pointer.PetIDs = Pet:GetTrackerData() -- this is table with [petID] = @table 
TMW:RegisterCallback("TMW_ACTION_PET_LIBRARY_REMOVED", function(callbackEvent, PetID, PetGUID)
	print("Removed " .. PetID .. ", GUID: " .. PetGUID)
end)
TMW:RegisterCallback("TMW_ACTION_PET_LIBRARY_ADDED", function(callbackEvent, PetID, PetGUID, PetData)
	-- PetData is a @table with next keys: name, duration, count, GUIDs 
	print("Added " .. PetID .. ", his name is " .. PetData.name .. ", GUID: " .. PetGUID)
	-- If we want to modify data we can 
	Pointer.PetIDs.myVar = "custom data"
	print(Pointer.PetIDs.myVar)
end)
]]--


-- Function to check for imp count
--local function WildImpsCount()
--    return Pet:GetCount(55659) or 0
--end

-- Function to check for remaining Dreadstalker duration
local function DreadStalkersTime()
    return Pet:GetRemainDuration(98035) or 0
end

-- Function to check for remaining Grimoire Felguard duration
local function GrimoireFelguardTime()
    return Pet:GetRemainDuration(17252) or 0
end

-- Function to check for Demonic Tyrant duration
local function DemonicTyrantTime()
    return Pet:GetRemainDuration(135002) or 0
end  

-- Function to check for Vilefiend duration
local function VilefiendTime()
    return Pet:GetRemainDuration(135816) or 0
end        

-- Check for Real Tyran summoned since VoP randomly summon a Tyran for 35% of its base duration
local function RealTyrantIsActive()
    return DemonicTyrantTime() > 5.25 and true or false
end

-- Function to check for Demonic Tyrant duration
local function DemonicTyrantIsActive()
    return DemonicTyrantTime() > 0 and true or false
end 


-- Hack to record timestamp of passive imp spawn 
local function LastPassiveImpTimeStamp()
    -- Since imp is active for 20sec, track every special npcid for Inner Demons imps with duration at 19.9 to get timestamp record
    return Pet:GetRemainDuration(143622) > 19.8 and TMW.time or 0
end

-- Imps spawn every 12sec with talent Inner Demons
-- Use our previous timestamp to predict next passive Imp spawn timestamp
local function NextPassiveImpSpawn()
    return (LastPassiveImpTimeStamp() + 12) or 0 
end

local function GetGUID(unitID)
	return UnitGUID(unitID)
end 

-----------------------------------
------- CUSTOM IMP TRACKER --------
-----------------------------------

-- Protect errors
TMW:RegisterCallback("TMW_ACTION_IS_INITIALIZED", function()
    Action.TimerSet("DISABLE_PET_ERRORS", 99999, function() Pet:DisableErrors(true)  end)
end)

--TMW:RegisterCallback("TMW_ACTION_PET_LIBRARY_ADDED", function(callbackEvent, PetID, PetGUID, PetData)
	-- PetData is a @table with next keys: name, duration, count, GUIDs 
    -- Add 5 cast to PetData table for each summoned Imp
	--PetData.impcasts = 5
	--PetData.petenergy = 100
	--Pointer.PetIDs[55659].impcasts = 5
	-- Also add 5 to local TR.GuardianTable
	--TR.GuardiansTable.ImpCastsRemaing = 5
	--if PetID == 55659 then
	   -- Pointer.PetIDs[Pointer.PetGUIDs[PetGUID]].GUIDs[PetGUID].impcasts = 5
		--Pointer.PetIDs[Pointer.PetGUIDs[PetGUID]].GUIDs[PetGUID].petenergy = 100
	    --Pointer.PetIDs[PetID].GUIDs[PetGUID].impcasts = 5
	    --Pointer.PetIDs[PetID].GUIDs[PetGUID].petenergy = 100
	--end
	--print("Added " .. PetID .. ", his name is " .. PetData.name .. ", GUID: " .. PetGUID .. "and he got " .. PetData.impcasts .. " casts lefts")

--end)

--TMW:RegisterCallback("TMW_ACTION_PET_LIBRARY_REMOVED", function(callbackEvent, PetID, PetGUID)
	--Pointer.PetGUIDs[PetGUID].impcasts = 0
	--Pointer.PetGUIDs[PetGUID].petenergy = 0
	--print("Removed " .. PetID .. ", GUID: " .. PetGUID)
--end)

TMW:RegisterCallback("TMW_ACTION_PET_LIBRARY_ADDED", function(callbackEvent, PetID, PetGUID, PetData)
	-- PetData is a @table with next keys: name, duration, count, GUIDs 
	if PetID == 55659 then
	    PetData.GUIDs[PetGUID].impcasts = 5
	    PetData.GUIDs[PetGUID].petenergy = 100
		PetData.GUIDs[PetGUID].counter = 1
		--PetData.GUIDs[PetGUID].impcasts = 5
	    print("Added " .. PetID .. ", his name is " .. PetData.name .. ", he got " .. PetData.GUIDs[PetGUID].impcasts .. " cast lefts and got " .. PetData.GUIDs[PetGUID].petenergy .. " energy. GUID: " .. PetGUID)
	    -- If we want to modify data we can 
	    --Pointer.PetIDs.myVar = "custom data"
	    --print(Pointer.PetIDs.myVar)
	end
end)
--/dump LibStub("PetLibrary"):GetTrackerData().[55659].GUIDs
-------------------------------------------------------------------------------
-- Remap
-------------------------------------------------------------------------------
local A_Unit, A_GetSpellInfo, A_GetSpellLink, ActiveNameplates
local TeamCacheFriendly, TeamCacheFriendlyUNITs

-------------------------------------------------------------------------------
local A_Unit						= A.Unit
local A_GetSpellInfo				= A.GetSpellInfo
local A_GetSpellLink				= A.GetSpellLink
local ActiveNameplates				= A.MultiUnits:GetActiveUnitPlates()
local TeamCacheFriendly				= TeamCache.Friendly
local TeamCacheFriendlyUNITs		= TeamCacheFriendly.UNITs

local PetOnEventCLEU					= {
		["UNIT_DIED"] 		= "Remove",
		["UNIT_DESTROYED"] 	= "Remove",
		["UNIT_DISSIPATES"] = "Remove",		
		["PARTY_KILL"] 		= "Remove",
		["SPELL_INSTAKILL"] = "Remove",
		["SPELL_SUMMON"] 	= "Add",
}
		
TR.ImpData = {
    ImpCastsRemaing = 0,
	ImpCount = 0,
	ImpTotalEnergy = 0,
}

local function GetGUID(unitID)
	return (unitID and TeamCacheFriendlyUNITs[unitID]) or UnitGUID(unitID)
end 
	  
local function ConvertGUIDtoNPCID(GUID)
	if A_Unit then 
		local _, _, _, _, _, npc_id = A_Unit(""):InfoGUID(GUID) -- A_Unit("") because no unitID 
		return npc_id
	else
		local _, _, _, _, _, _, _, NPCID = strfind(GUID, "(%S+)-(%d+)-(%d+)-(%d+)-(%d+)-(%d+)-(%S+)")
		return NPCID and tonumber(NPCID)
	end 
end 

local function AddWildImpToTracker(PetID, PetGUID, PetName)
	
	if not Pointer.PetIDs[PetID] then 
		Pointer.PetIDs[PetID] = { count = 0, GUIDs = {} }
	end 
	
	Pointer.PetIDs[PetID].name 				= "Wild Imp"
	Pointer.PetIDs[PetID].duration 			= 20
	Pointer.PetIDs[PetID].count				= Pointer.PetIDs[PetID].count + 1
	Pointer.PetIDs[PetID].GUIDs[PetGUID]	= { 
		updated			= TMW.time, 
		start 			= TMW.time, 
		expiration		= TMW.time + Pointer.PetIDs[PetID].duration,
		impcasts        = 5,
		petenergy       = 100,
	}
	
	--Pointer.PetGUIDs[DestGUID]				= Pointer.PetIDs[PetID]
	--PetTrackerGUID[PetGUID]					= PetID
	Pet.Data.Trackers[266].PetGUIDs[PetGUID]					= PetID
	
	TMW:Fire("TMW_ACTION_PET_LIBRARY_ADDED", PetID, PetGUID, Pointer.PetIDs[PetID])
end 

TR.COMBAT_LOG_EVENT_UNFILTERED			= function(...)
	 	
	local _, Event, _, SourceGUID, _, SourceFlags, _, DestGUID, DestName, DestFlags,_, SpellID, SpellName = CombatLogGetCurrentEventInfo()
	--local PetID = 55659

	if SourceGUID and Pointer.PetIDs[55659] and Pointer.PetIDs[55659].GUIDs[SourceGUID] then 
		Pointer.PetIDs[55659].GUIDs[SourceGUID].updated = TMW.time 
	end 

    -- Decrement impcasts and petenergy
	if Pointer.PetIDs and Pointer.PetIDs[55659] and Pointer.PetGUIDs[SourceGUID] and SourceGUID and (Event == "SPELL_CAST_SUCCESS") and SpellID == 104318 then
        --Pointer.PetIDs[Pointer.PetGUIDs[SourceGUID]].GUIDs[SourceGUID].impcasts = Pointer.PetIDs[Pointer.PetGUIDs[SourceGUID]].GUIDs[SourceGUID].impcasts - 1
	    Pointer.PetIDs[55659].GUIDs[SourceGUID].impcasts = Pointer.PetIDs[55659].GUIDs[SourceGUID].impcasts - 1 
		--Pointer.PetIDs[Pointer.PetGUIDs[SourceGUID]].GUIDs[SourceGUID].petenergy = Pointer.PetIDs[Pointer.PetGUIDs[SourceGUID]].GUIDs[SourceGUID].petenergy - 20
		Pointer.PetIDs[55659].GUIDs[SourceGUID].petenergy = Pointer.PetIDs[55659].GUIDs[SourceGUID].petenergy - 20
	end

	-- Add Implosion and Demonic Consumption listener
	if  (Event == "SPELL_CAST_SUCCESS") and SourceGUID == GetGUID("player") and Pointer.PetIDs[55659] and  --and SourceGUID  and
	    (   -- Implosion
	        SpellID == 196277 or SpellName == A.Implosion:Info()
	       	or 
	   	    -- Summon Demonic Tyrant with Demonic Consumption
	   	    (SpellID == 265187 and A.DemonicConsumption:IsSpellLearned())
	    ) 
	then 
	    local PetID = 55659
	    for GUID in pairs(Pointer.PetIDs[PetID].GUIDs) do 
  	        Pointer.PetGUIDs[GUID] = nil 
	    end
	    wipe(Pointer.PetIDs[PetID].GUIDs)
	    if Pointer.PetIDs[PetID].count > 1 then 
  	        Pointer.PetIDs[PetID].count = 0  
	    else  
 	        Pointer.PetIDs[PetID].GUIDs = nil 
	    end 
	end		
end
Listener:Add("ACTION_TASTE_IMP_TRACKER", "COMBAT_LOG_EVENT_UNFILTERED", TR.COMBAT_LOG_EVENT_UNFILTERED)

local function GetImpsData(petID, petName)
	-- @return number 
	-- Note: Only if template has "duration" key otherwise it's huge 
	local TotalImpEnergy = 0
	local TotalImpCast = 0
	local TotalImpCount = 0
	
	-- Note: Number of active pets
--[[	if petName or petID then 
		for _, petData in pairs(Pointer.PetIDs) do 
			if petData.id == petID or petData.name == petName then 
				-- Imp count
			    if petData.count > 1 then
			        TotalImpCount = petData.count
			    end
			end 
		end 
	end 
	]]--
	-- Note: Imp energy value + remaining casts
	if petID and Pointer.PetIDs[petID] then 
        for _, petData in pairs(Pointer.PetIDs) do 
			if petData.id == petID or petData.name == petName then 
				for _, dataGUID in pairs(petData.GUIDs) do 
			        local petenergy = dataGUID.petenergy
			        local impcasts = dataGUID.impcasts
			        local impcounter = dataGUID.counter
					
			        -- Imp casts
			        if impcasts > 0 then 
                        TotalImpCast = TotalImpCast + impcasts
					else
					    impcounter = 0
			        end 
			
			        -- Imp Energy
			        if petenergy > 0 then 
                        TotalImpEnergy = TotalImpEnergy + petenergy
					else
					    impcounter = 0
			        end 
					TotalImpCount = TotalImpCount + impcounter
				end 
			end 
		end 
	end 
	
	return TotalImpCount, TotalImpEnergy, TotalImpCast  
end 
	
-- On Successful HoG cast add how many Imps will spawn
local ImpsSpawnedFromHoG = 0 
local _, event, _, sourceGUID, _, _, _, destGUID, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()	
if (event == "SPELL_CAST_SUCCESS") and sourceGUID == UnitGUID(player) and spellID == 105174 then
    ImpsSpawnedFromHoG = ImpsSpawnedFromHoG + (Player:SoulShardsP() >= 3 and 3 or Player:SoulShardsP())
    Env.LastPlayerCastID 	= spellID
	A.LastPlayerCastName	= spellName
	A.LastPlayerCastID		= spellID
    TMW:Fire("TMW_CNDT_LASTCAST_UPDATED")
end

-- Give imp count prediction with HoG cast
local function ImpsSpawnedDuring(miliseconds)
    local ImpSpawned = 0
    -- Used for Wild Imps spawn prediction
    local InnerDemonsNextCast = 0
    local ImpCastsRemaing = 0
    local SpellCastTime = ( miliseconds / 1000 ) * Player:SpellHaste()
    local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit(player):IsCasting()
	
    if TMW.time <= NextPassiveImpSpawn() and (TMW.time + SpellCastTime) >= NextPassiveImpSpawn() then
        ImpSpawned = ImpSpawned + 1
    end

    if castName == A.HandofGuldan:Info() then
        ImpSpawned = ImpSpawned + (Player:SoulShards() >= 3 and 3 or Player:SoulShards())
    end

    ImpSpawned = ImpSpawned + ImpsSpawnedFromHoG

    return ImpSpawned
end
ImpsSpawnedDuring = A.MakeFunctionCachedDynamic(ImpsSpawnedDuring)

-- SummonDemonicTyrant checker
local function MegaTyrant()
    local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit(player):IsCasting()
	local WildImpCount, WildImpTotalEnergy, WildImpTotalCastsRemains = GetImpsData(55659, "Wild Imp")
    return (WildImpCount + ImpsSpawnedDuring(2000) >= 6 and A.LastPlayerCastName == A.HandofGuldan:Info() and castName == A.HandofGuldan:Info() and true) or false
end

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end  
		
    -- UnendingResolve
    local UnendingResolve = A.GetToggle(2, "UnendingResolve")
    if     UnendingResolve >= 0 and A.UnendingResolve:IsReady(player) and 
    (
        (     -- Auto 
            UnendingResolve >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            UnendingResolve < 100 and 
            Unit(player):HealthPercent() <= UnendingResolve
        )
    ) 
    then 
        return A.UnendingResolve
    end     
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady(player, true) and not A.IsInPvP and A.AuraIsValid(player, "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
	
	    -- HealingPotion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady(player) and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AbyssalHealingPotion < 100 and 
            Unit(player):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end 
	
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- TO USE AFTER NEXT ACTION UPDATE
local function InterruptsNEW(unit)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, not A.PetKick:IsReady(unit)) -- A.Kick non GCD spell
    
	if castDoneTime > 0 then
        if useKick and A.PetKick:IsReady(unit) and A.PetKick:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):IsControlAble("stun", 0) then 
            return A.PetKick
        end 
    
        if useCC and A.Shadowfury:IsReady(unit) and MultiUnits:GetActiveEnemies() >= 2 and A.Shadowfury:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
            return A.Shadowfury              
        end          
	
	    if useCC and A.Fear:IsReady(unit) and A.Fear:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("disorient", 75) then 
            return A.Fear              
        end
		    
   	    if useRacial and A.QuakingPalm:AutoRacial(unit) then 
   	        return A.QuakingPalm
   	    end 
    
   	    if useRacial and A.Haymaker:AutoRacial(unit) then 
            return A.Haymaker
   	    end 
    
   	    if useRacial and A.WarStomp:AutoRacial(unit) then 
            return A.WarStomp
   	    end 
    
   	    if useRacial and A.BullRush:AutoRacial(unit) then 
            return A.BullRush
   	    end 
    end
end

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    if useKick and A.PetKick:IsReady(unit) and A.PetKick:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):IsControlAble("stun", 0) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
        return A.PetKick
    end 
    
    if useCC and A.Shadowfury:IsReady(unit) and MultiUnits:GetActiveEnemies() >= 2 and A.Shadowfury:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
        return A.Shadowfury              
    end          
	
	if useCC and A.Fear:IsReady(unit) and A.Fear:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("disorient", 75) then 
        return A.Fear              
    end
    
    if useRacial and A.QuakingPalm:AutoRacial(unit) then 
        return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unit) then 
        return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unit) then 
        return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unit) then 
        return A.BullRush
    end      
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

-- Multidot Handler UI w/ Doom --
local function HandleMultidots()
    local choice = Action.GetToggle(2, "AutoDotSelection")
       
    if choice == "In Raid" then
		if IsInRaid() then
    		return true
		else
		    return false
		end
    elseif choice == "In Dungeon" then 
		if Player:InDungeon() then
    		return true
		else
		    return false
		end
	elseif choice == "In PvP" then 	
		if Player:InPvP() then 
    		return true
		else
		    return false
		end		
    elseif choice == "Everywhere" then 
        return true
    else
		return false
    end
	--print(choice)
end