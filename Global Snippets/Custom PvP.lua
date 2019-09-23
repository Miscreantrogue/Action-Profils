---------------------------------------------------
---------------- CUSTOM PVP FUNCTIONS -------------
---------------------------------------------------

local TMW = TMW
local CNDT = TMW.CNDT
local Env = CNDT.Env
local Action = Action
local MultiUnits = Action.MultiUnits
local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Pet = Unit.Pet;
local Target = Unit.Target;
local Arena = Unit.Arena;
local Spell = HL.Spell;
local Item = HL.Item;
local next, pairs, type, print  = next, pairs, type, print
local IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo = IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo
local UnitIsPlayer, UnitExists, UnitGUID = UnitIsPlayer, UnitExists, UnitGUID
local PetLib = LibStub("PetLibrary")
local ActionUnit = Action.Unit 

---------------------------------------------------
-------------------- CONSTANTS --------------------
---------------------------------------------------

--- Reflect Spells List
local pvpReflect = {
    161372, -- Poly
    190319, -- Combustion
    161372, -- Polymorph
    203286, -- Greater Pyroblast
    199786, --  Glacial Spike
    257537, -- Ebonbolt
    210714, -- Icefury
    191634, -- Stormkeeper
    116858, -- Chaos Bolt
	118, -- Poly
}

---------------------------------------------------
-------------------- FUNCTIONS --------------------
---------------------------------------------------

-- Local Randomizer
local randomChannel = math.random(5, 15)
local randomInterrupt = math.random(40, 90)
local randomReflect = math.random(90, 100)
local randomSeconds = math.random(0.3, 0.5)

local randomTimer = HL.GetTime()
local function Randomizer(option)
    if GetTime() - randomTimer >= 1 then
        randomInterrupt = math.random(40, 90)
        randomChannel = math.random(20, 30)
        randomReflect = math.random(90, 100)
        randomSeconds = math.random(0.25, 0.75)
        randomTimer = GetTime()
    end

    if option == "Interrupt" then
        return randomInterrupt
    end
    if option == "Channel" then
        return randomChannel
    end

    if option == "Seconds" then
        return randomSeconds
    end

    if option == "Reflect" then
        return randomReflect
    end
end

-- Should Reflect behavior
function Action.ShouldReflect(unit)	
	local GoodToReflect = false
	for p = 1, #pvpReflect do
	    -- Get the spell name of every id in our list	    
		if not unit or unit == nil then 
		    unit = "target"
		end
		local currentUnit = ActionUnit(unit)
		local currentCast = currentUnit:IsCasting()
		
        if currentCast == GetSpellInfo(pvpReflect[p]) then
		    if ActionUnit(unit):IsCastingRemains() >= Randomizer("Reflect") then
                GoodToReflect = true
            else
		        GoodToReflect = false
			end
        end
    end
    return GoodToReflect
end

