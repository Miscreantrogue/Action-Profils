--- ====================== ACTION HEADER ============================ ---
local Action                                 = Action
local TeamCache                              = Action.TeamCache
local EnemyTeam                              = Action.EnemyTeam
local FriendlyTeam                           = Action.FriendlyTeam
--local HealingEngine                        = Action.HealingEngine
local LoC                                    = Action.LossOfControl
local Player                                 = Action.Player
local MultiUnits                             = Action.MultiUnits
local UnitCooldown                           = Action.UnitCooldown
local Unit                                   = Action.Unit
local Pet                                    = LibStub("PetLibrary")
local Azerite                                = LibStub("AzeriteTraits")
local setmetatable                           = setmetatable

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_DEMONHUNTER_HAVOC] = {
    MetamorphosisBuff                      = Action.Create({Type = "Spell", ID = 162264 }),
    Metamorphosis                          = Action.Create({Type = "Spell", ID = 191427 }),
    ChaoticTransformation                  = Action.Create({Type = "Spell", ID = 288754 }),
    Demonic                                = Action.Create({Type = "Spell", ID = 213410 }),
    BladeDance                             = Action.Create({Type = "Spell", ID = 188499 }),
    Nemesis                                = Action.Create({Type = "Spell", ID = 206491 }),
    NemesisDebuff                          = Action.Create({Type = "Spell", ID = 206491 }),
    DarkSlash                              = Action.Create({Type = "Spell", ID = 258860 }),
    Annihilation                           = Action.Create({Type = "Spell", ID = 201427 }),
    DarkSlashDebuff                        = Action.Create({Type = "Spell", ID = 258860 }),
    ChaosStrike                            = Action.Create({Type = "Spell", ID = 162794 }),
    FelBarrage                             = Action.Create({Type = "Spell", ID = 211053 }),
    DeathSweep                             = Action.Create({Type = "Spell", ID = 210152 }),
    EyeBeam                                = Action.Create({Type = "Spell", ID = 198013 }),
    RevolvingBlades                        = Action.Create({Type = "Spell", ID = 279581 }),
    ImmolationAura                         = Action.Create({Type = "Spell", ID = 258920 }),
    Felblade                               = Action.Create({Type = "Spell", ID = 232893 }),
    BlindFury                              = Action.Create({Type = "Spell", ID = 203550 }),
    FelRush                                = Action.Create({Type = "Spell", ID = 195072 }),
    DemonBlades                            = Action.Create({Type = "Spell", ID = 203555 }),
    DemonsBite                             = Action.Create({Type = "Spell", ID = 162243 }),
    ThrowGlaive                            = Action.Create({Type = "Spell", ID = 185123 }),
    OutofRangeBuff                         = Action.Create({Type = "Spell", ID =  }),
    VengefulRetreat                        = Action.Create({Type = "Spell", ID = 198793 }),
    Momentum                               = Action.Create({Type = "Spell", ID = 206476 }),
    PreparedBuff                           = Action.Create({Type = "Spell", ID = 203650 }),
    FelMastery                             = Action.Create({Type = "Spell", ID = 192939 }),
    FirstBlood                             = Action.Create({Type = "Spell", ID = 206416 }),
    TrailofRuin                            = Action.Create({Type = "Spell", ID = 258881 }),
    MomentumBuff                           = Action.Create({Type = "Spell", ID = 208628 }),
    Disrupt                                = Action.Create({Type = "Spell", ID = 183752 }),
    PickUpFragment                         = Action.Create({Type = "Spell", ID =  })
    -- Trinkets
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }), 
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }), 
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }), 
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }), 
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }), 
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }), 
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }), 
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }), 
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    PotionTest                             = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), 
    -- Trinkets
    GenericTrinket1                        = Action.Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
    GenericTrinket2                        = Action.Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
    InvocationOfYulon                      = Action.Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),
    LustrousGoldenPlumage                  = Action.Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),
    ComputationDevice                      = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    VigorTrinket                           = Action.Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),
    FontOfPower                            = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    RazorCoral                             = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Misc
    Channeling                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                          = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast 				             = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_DEMONHUNTER_HAVOC)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEMONHUNTER_HAVOC], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarPoolingForMeta = 0;
local VarWaitingForNemesis = 0;
local VarBladeDance = 0;
local VarPoolingForBladeDance = 0;
local VarWaitingForMomentum = 0;
local VarWaitingForDarkSlash = 0;

A.Listener:Add("ACTION_EVENT_COMBAT_TRACKER", "PLAYER_REGEN_ENABLED", 				function()
  VarPoolingForMeta = 0
  VarWaitingForNemesis = 0
  VarBladeDance = 0
  VarPoolingForBladeDance = 0
  VarWaitingForMomentum = 0
  VarWaitingForDarkSlash = 0
	end 
end)

local EnemyRanges = {40, 30, 20, 8}
local function UpdateRanges()
  for _, i in ipairs(EnemyRanges) do
    HL.GetEnemies(i);
  end
end


local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
-------------- PRE APL SETUP -------------
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

------------------------------------------
--------------- DEFENSIVES ---------------
------------------------------------------
local function SelfDefensives()
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end  
		
    -- UnendingResolve
 --[[   local UnendingResolve = A.GetToggle(2, "UnendingResolve")
    if     UnendingResolve >= 0 and A.UnendingResolve:IsReady("player") and 
    (
        (     -- Auto 
            UnendingResolve >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            UnendingResolve < 100 and 
            Unit("player"):HealthPercent() <= UnendingResolve
        )
    ) 
    then 
        return A.UnendingResolve
    end ]]--
    
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

------------------------------------------
--------------- INTERRUPTS ---------------
------------------------------------------
local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
  --  if useKick and A.PetKick:IsReady(unit) and A.PetKick:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
  --      return A.PetKick
  --  end 
    
  --  if useCC and A.Shadowfury:IsReady(unit) and MultiUnits:GetActiveEnemies() >= 2 and A.Shadowfury:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
  --      return A.Shadowfury              
  --  end          
	
	--if useCC and A.Fear:IsReady(unit) and A.Fear:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("disorient", 0) then 
    --    return A.Fear              
    --end
    
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

------------------------------------------
---------------- AntiFake ----------------
------------------------------------------

-- [1] CC AntiFake Rotation
--[[local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0) and 
    Unit(unit):IsControlAble("stun", 0) and 
    A.LegSweepGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if     A.LegSweepGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target") and                     
            (
                (A.IsInPvP and EnemyTeam():PlayersInRange(1, 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0))) or 
                (not A.IsInPvP and MultiUnits:GetByRange(5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0), 1) >= 1)
            )
        )
    )
    then 
        return A.LegSweepGreen:Show(icon)         
    end                                                                     
end]]--

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end 
    
    if unit then         
        local castLeft, _, _, _, notKickAble = Unit(unit):IsCastingRemains()
        if castLeft > 0 then             
        --    if not notKickAble and A.PetKick:IsReady(unit, nil, nil, true) and A.PetKick:AbsentImun(unit, Temp.TotalAndMag, true) then
        --        return A.PetKick:Show(icon)                                                  
        --    end 
            
            -- Racials 
            if A.QuakingPalm:IsRacialReadyP(unit, nil, nil, true) then 
                return A.QuakingPalm:Show(icon)
            end 
            
            if A.Haymaker:IsRacialReadyP(unit, nil, nil, true) then 
                return A.Haymaker:Show(icon)
            end 
            
            if A.WarStomp:IsRacialReadyP(unit, nil, nil, true) then 
                return A.WarStomp:Show(icon)
            end 
            
            if A.BullRush:IsRacialReadyP(unit, nil, nil, true) then 
                return A.BullRush:Show(icon)
            end                         
        end 
    end                                                                                 
end

local function IsInMeleeRange()
  if A.Felblade:GetSpellTimeSinceLastCast() <= A.GetGCD() then
    return true
  elseif A.VengefulRetreat:GetSpellTimeSinceLastCast() < 1.0 then  
    return false
  end
  return A.ChaosStrike:IsInRange(unit)
end

local function IsMetaExtendedByDemonic()
  if not Player:BuffP(S.MetamorphosisBuff) then
    return false;
  elseif(S.EyeBeam:TimeSinceLastCast() < S.MetamorphosisImpact:TimeSinceLastCast()) then
    return true;
  end

  return false;
end

local function MetamorphosisCooldownAdjusted()
  -- TODO: Make this better by sampling the Fury expenses over time instead of approximating
  if I.ConvergenceofFates:IsEquipped() and I.DelusionsOfGrandeur:IsEquipped() then
    return S.Metamorphosis:CooldownRemainsP() * 0.56;
  elseif I.ConvergenceofFates:IsEquipped() then
    return S.Metamorphosis:CooldownRemainsP() * 0.78;
  elseif I.DelusionsOfGrandeur:IsEquipped() then
    return S.Metamorphosis:CooldownRemainsP() * 0.67;
  end
  return S.Metamorphosis:CooldownRemainsP()
end


local function EvaluateTargetIfFilterNemesis35(unit)
  return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfNemesis50(unit)
  return (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) and bool(Unit(unit):HasDeBuffsDown(A.NemesisDebuff.ID, true)) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 or 10000000000 > 60)
end


--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit("player"):CombatTime() > 0
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
    local unit = "player"

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        local Precombat, Cooldown, DarkSlash, Demonic, Normal
        --Precombat
        local function Precombat(unit)
            -- flask
            -- augmentation
            -- food
            -- snapshot_stats
            -- potion
            if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofAgility:Show(icon)
            end
            -- metamorphosis,if=!azerite.chaotic_transformation.enabled
            if A.Metamorphosis:IsReady(unit) and Unit("player"):HasBuffsDown(A.MetamorphosisBuff.ID, true) and (not bool(A.ChaoticTransformation:GetAzeriteRank())) then
                return A.Metamorphosis:Show(icon)
            end
        end
        
        --Cooldown
        local function Cooldown(unit)
            -- metamorphosis,if=!(talent.demonic.enabled|variable.pooling_for_meta|variable.waiting_for_nemesis)|target.time_to_die<25
            if A.Metamorphosis:IsReady(unit) and (not (A.Demonic:IsSpellLearned() or bool(VarPoolingForMeta) or bool(VarWaitingForNemesis)) or Unit(unit):TimeToDie() < 25) then
                return A.Metamorphosis:Show(icon)
            end
            -- metamorphosis,if=talent.demonic.enabled&buff.metamorphosis.up&(!azerite.chaotic_transformation.enabled|!variable.blade_dance|!cooldown.blade_dance.ready)
            if A.Metamorphosis:IsReady(unit) and (A.Demonic:IsSpellLearned() and Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) and (not bool(A.ChaoticTransformation:GetAzeriteRank()) or not bool(VarBladeDance) or not A.BladeDance:GetCooldown() == 0)) then
                return A.Metamorphosis:Show(icon)
            end
            -- nemesis,target_if=min:target.time_to_die,if=raid_event.adds.exists&debuff.nemesis.down&(active_enemies>desired_targets|raid_event.adds.in>60)
            if A.Nemesis:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Nemesis, 40, "min", EvaluateTargetIfFilterNemesis35, EvaluateTargetIfNemesis50) then 
                    return A.Nemesis:Show(icon) 
                end
            end
            -- nemesis,if=!raid_event.adds.exists
            if A.Nemesis:IsReady(unit) and (not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1)) then
                return A.Nemesis:Show(icon)
            end
            -- potion,if=buff.metamorphosis.remains>25|target.time_to_die<60
            if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) > 25 or Unit(unit):TimeToDie() < 60) then
                A.BattlePotionofAgility:Show(icon)
            end
        end
        
        --DarkSlash
        local function DarkSlash(unit)
            -- dark_slash,if=fury>=80&(!variable.blade_dance|!cooldown.blade_dance.ready)
            if A.DarkSlash:IsReady(unit) and (Unit("player"):Fury() >= 80 and (not bool(VarBladeDance) or not A.BladeDance:GetCooldown() == 0)) then
                return A.DarkSlash:Show(icon)
            end
            -- annihilation,if=debuff.dark_slash.up
            if A.Annihilation:IsReady(unit) and IsInMeleeRange() and (Unit(unit):HasDeBuffs(A.DarkSlashDebuff.ID, true)) then
                return A.Annihilation:Show(icon)
            end
            -- chaos_strike,if=debuff.dark_slash.up
            if A.ChaosStrike:IsReady(unit) and IsInMeleeRange() and (Unit(unit):HasDeBuffs(A.DarkSlashDebuff.ID, true)) then
                return A.ChaosStrike:Show(icon)
            end
        end
        
        --Demonic
        local function Demonic(unit)
            -- fel_barrage,if=active_enemies>desired_targets|raid_event.adds.in>30
            if A.FelBarrage:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 or 10000000000 > 30) then
                return A.FelBarrage:Show(icon)
            end
            -- death_sweep,if=variable.blade_dance
            if A.DeathSweep:IsReady(unit) and (bool(VarBladeDance)) then
                return A.DeathSweep:Show(icon)
            end
            -- eye_beam,if=!buff.metamorphosis.extended_by_demonic&(raid_event.adds.up|raid_event.adds.in>25)
            if A.EyeBeam:IsReady(unit) and (not IsMetaExtendedByDemonic and ((MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or 10000000000 > 25)) then
                return A.EyeBeam:Show(icon)
            end
            -- blade_dance,if=variable.blade_dance&!cooldown.metamorphosis.ready&(cooldown.eye_beam.remains>(5-azerite.revolving_blades.rank*3)|(raid_event.adds.in>cooldown&raid_event.adds.in<25))
            if A.BladeDance:IsReady(unit) and (bool(VarBladeDance) and not A.Metamorphosis:GetCooldown() == 0 and (A.EyeBeam:GetCooldown() > (5 - A.RevolvingBlades:GetAzeriteRank() * 3) or (10000000000 > cooldown and 10000000000 < 25))) then
                return A.BladeDance:Show(icon)
            end
            -- immolation_aura
            if A.ImmolationAura:IsReady(unit) then
                return A.ImmolationAura:Show(icon)
            end
            -- felblade,if=fury<40|(buff.metamorphosis.down&fury.deficit>=40)
            if A.Felblade:IsReady(unit) and (Unit("player"):Fury() < 40 or (bool(Unit("player"):HasBuffsDown(A.MetamorphosisBuff.ID, true)) and Unit("player"):FuryDeficit() >= 40)) then
                return A.Felblade:Show(icon)
            end
            -- annihilation,if=(talent.blind_fury.enabled|fury.deficit<30|buff.metamorphosis.remains<5)&!variable.pooling_for_blade_dance
            if A.Annihilation:IsReady(unit) and IsInMeleeRange() and ((A.BlindFury:IsSpellLearned() or Unit("player"):FuryDeficit() < 30 or Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) < 5) and not bool(VarPoolingForBladeDance)) then
                return A.Annihilation:Show(icon)
            end
            -- chaos_strike,if=(talent.blind_fury.enabled|fury.deficit<30)&!variable.pooling_for_meta&!variable.pooling_for_blade_dance
            if A.ChaosStrike:IsReady(unit) and IsInMeleeRange() and ((A.BlindFury:IsSpellLearned() or Unit("player"):FuryDeficit() < 30) and not bool(VarPoolingForMeta) and not bool(VarPoolingForBladeDance)) then
                return A.ChaosStrike:Show(icon)
            end
            -- fel_rush,if=talent.demon_blades.enabled&!cooldown.eye_beam.ready&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))
            if A.FelRush:IsReady(unit) and (A.DemonBlades:IsSpellLearned() and not A.EyeBeam:GetCooldown() == 0 and (A.FelRush:ChargesP() == 2 or (10000000000 > 10 and 10000000000 > 10))) then
                return A.FelRush:Show(icon)
            end
            -- demons_bite
            if A.DemonsBite:IsReady(unit) and IsInMeleeRange() then
                return A.DemonsBite:Show(icon)
            end
            -- throw_glaive,if=buff.out_of_range.up
            if A.ThrowGlaive:IsReady(unit) and (Unit("player"):HasBuffs(A.OutofRangeBuff.ID, true)) then
                return A.ThrowGlaive:Show(icon)
            end
            -- fel_rush,if=movement.distance>15|buff.out_of_range.up
            if A.FelRush:IsReady(unit) and (movement.distance > 15 or Unit("player"):HasBuffs(A.OutofRangeBuff.ID, true)) then
                return A.FelRush:Show(icon)
            end
            -- vengeful_retreat,if=movement.distance>15
            if A.VengefulRetreat:IsReady(unit) and (movement.distance > 15) then
                return A.VengefulRetreat:Show(icon)
            end
            -- throw_glaive,if=talent.demon_blades.enabled
            if A.ThrowGlaive:IsReady(unit) and (A.DemonBlades:IsSpellLearned()) then
                return A.ThrowGlaive:Show(icon)
            end
        end
        
        --Normal
        local function Normal(unit)
            -- vengeful_retreat,if=talent.momentum.enabled&buff.prepared.down&time>1
            if A.VengefulRetreat:IsReady(unit) and (A.Momentum:IsSpellLearned() and bool(Unit("player"):HasBuffsDown(A.PreparedBuff.ID, true)) and Unit("player"):CombatTime > 1) then
                return A.VengefulRetreat:Show(icon)
            end
            -- fel_rush,if=(variable.waiting_for_momentum|talent.fel_mastery.enabled)&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))
            if A.FelRush:IsReady(unit) and ((bool(VarWaitingForMomentum) or A.FelMastery:IsSpellLearned()) and (A.FelRush:ChargesP() == 2 or (10000000000 > 10 and 10000000000 > 10))) then
                return A.FelRush:Show(icon)
            end
            -- fel_barrage,if=!variable.waiting_for_momentum&(active_enemies>desired_targets|raid_event.adds.in>30)
            if A.FelBarrage:IsReady(unit) and (not bool(VarWaitingForMomentum) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 or 10000000000 > 30)) then
                return A.FelBarrage:Show(icon)
            end
            -- death_sweep,if=variable.blade_dance
            if A.DeathSweep:IsReady(unit) and (bool(VarBladeDance)) then
                return A.DeathSweep:Show(icon)
            end
            -- immolation_aura
            if A.ImmolationAura:IsReady(unit) then
                return A.ImmolationAura:Show(icon)
            end
            -- eye_beam,if=active_enemies>1&(!raid_event.adds.exists|raid_event.adds.up)&!variable.waiting_for_momentum
            if A.EyeBeam:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and (not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1)) and not bool(VarWaitingForMomentum)) then
                return A.EyeBeam:Show(icon)
            end
            -- blade_dance,if=variable.blade_dance
            if A.BladeDance:IsReady(unit) and (bool(VarBladeDance)) then
                return A.BladeDance:Show(icon)
            end
            -- felblade,if=fury.deficit>=40
            if A.Felblade:IsReady(unit) and (Unit("player"):FuryDeficit() >= 40) then
                return A.Felblade:Show(icon)
            end
            -- eye_beam,if=!talent.blind_fury.enabled&!variable.waiting_for_dark_slash&raid_event.adds.in>cooldown
            if A.EyeBeam:IsReady(unit) and (not A.BlindFury:IsSpellLearned() and not bool(VarWaitingForDarkSlash) and 10000000000 > cooldown) then
                return A.EyeBeam:Show(icon)
            end
            -- annihilation,if=(talent.demon_blades.enabled|!variable.waiting_for_momentum|fury.deficit<30|buff.metamorphosis.remains<5)&!variable.pooling_for_blade_dance&!variable.waiting_for_dark_slash
            if A.Annihilation:IsReady(unit) and IsInMeleeRange() and ((A.DemonBlades:IsSpellLearned() or not bool(VarWaitingForMomentum) or Unit("player"):FuryDeficit() < 30 or Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) < 5) and not bool(VarPoolingForBladeDance) and not bool(VarWaitingForDarkSlash)) then
                return A.Annihilation:Show(icon)
            end
            -- chaos_strike,if=(talent.demon_blades.enabled|!variable.waiting_for_momentum|fury.deficit<30)&!variable.pooling_for_meta&!variable.pooling_for_blade_dance&!variable.waiting_for_dark_slash
            if A.ChaosStrike:IsReady(unit) and IsInMeleeRange() and ((A.DemonBlades:IsSpellLearned() or not bool(VarWaitingForMomentum) or Unit("player"):FuryDeficit() < 30) and not bool(VarPoolingForMeta) and not bool(VarPoolingForBladeDance) and not bool(VarWaitingForDarkSlash)) then
                return A.ChaosStrike:Show(icon)
            end
            -- eye_beam,if=talent.blind_fury.enabled&raid_event.adds.in>cooldown
            if A.EyeBeam:IsReady(unit) and (A.BlindFury:IsSpellLearned() and 10000000000 > cooldown) then
                return A.EyeBeam:Show(icon)
            end
            -- demons_bite
            if A.DemonsBite:IsReady(unit) and IsInMeleeRange() then
                return A.DemonsBite:Show(icon)
            end
            -- fel_rush,if=!talent.momentum.enabled&raid_event.movement.in>charges*10&talent.demon_blades.enabled
            if A.FelRush:IsReady(unit) and (not A.Momentum:IsSpellLearned() and 10000000000 > A.FelRush:ChargesP() * 10 and A.DemonBlades:IsSpellLearned()) then
                return A.FelRush:Show(icon)
            end
            -- felblade,if=movement.distance>15|buff.out_of_range.up
            if A.Felblade:IsReady(unit) and (movement.distance > 15 or Unit("player"):HasBuffs(A.OutofRangeBuff.ID, true)) then
                return A.Felblade:Show(icon)
            end
            -- fel_rush,if=movement.distance>15|(buff.out_of_range.up&!talent.momentum.enabled)
            if A.FelRush:IsReady(unit) and (movement.distance > 15 or (Unit("player"):HasBuffs(A.OutofRangeBuff.ID, true) and not A.Momentum:IsSpellLearned())) then
                return A.FelRush:Show(icon)
            end
            -- vengeful_retreat,if=movement.distance>15
            if A.VengefulRetreat:IsReady(unit) and (movement.distance > 15) then
                return A.VengefulRetreat:Show(icon)
            end
            -- throw_glaive,if=talent.demon_blades.enabled
            if A.ThrowGlaive:IsReady(unit) and (A.DemonBlades:IsSpellLearned()) then
                return A.ThrowGlaive:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- auto_attack
            -- variable,name=blade_dance,value=talent.first_blood.enabled|spell_targets.blade_dance1>=(3-talent.trail_of_ruin.enabled)
            if (true) then
                VarBladeDance = num(A.FirstBlood:IsSpellLearned() or MultiUnits:GetByRangeInCombat(40, 5, 10) >= (3 - num(A.TrailofRuin:IsSpellLearned())))
            end
            -- variable,name=waiting_for_nemesis,value=!(!talent.nemesis.enabled|cooldown.nemesis.ready|cooldown.nemesis.remains>target.time_to_die|cooldown.nemesis.remains>60)
            if (true) then
                VarWaitingForNemesis = num(not (not A.Nemesis:IsSpellLearned() or A.Nemesis:GetCooldown() == 0 or A.Nemesis:GetCooldown() > Unit(unit):TimeToDie() or A.Nemesis:GetCooldown() > 60))
            end
            -- variable,name=pooling_for_meta,value=!talent.demonic.enabled&cooldown.metamorphosis.remains<6&fury.deficit>30&(!variable.waiting_for_nemesis|cooldown.nemesis.remains<10)
            if (true) then
                VarPoolingForMeta = num(not A.Demonic:IsSpellLearned() and A.Metamorphosis:GetCooldown() < 6 and Unit("player"):FuryDeficit() > 30 and (not bool(VarWaitingForNemesis) or A.Nemesis:GetCooldown() < 10))
            end
            -- variable,name=pooling_for_blade_dance,value=variable.blade_dance&(fury<75-talent.first_blood.enabled*20)
            if (true) then
                VarPoolingForBladeDance = num(bool(VarBladeDance) and (Unit("player"):Fury() < 75 - num(A.FirstBlood:IsSpellLearned()) * 20))
            end
            -- variable,name=waiting_for_dark_slash,value=talent.dark_slash.enabled&!variable.pooling_for_blade_dance&!variable.pooling_for_meta&cooldown.dark_slash.up
            if (true) then
                VarWaitingForDarkSlash = num(A.DarkSlash:IsSpellLearned() and not bool(VarPoolingForBladeDance) and not bool(VarPoolingForMeta) and A.DarkSlash:GetCooldown() == 0)
            end
            -- variable,name=waiting_for_momentum,value=talent.momentum.enabled&!buff.momentum.up
            if (true) then
                VarWaitingForMomentum = num(A.Momentum:IsSpellLearned() and not Unit("player"):HasBuffs(A.MomentumBuff.ID, true))
            end
            -- disrupt
            if A.Disrupt:IsReady(unit) then
                return A.Disrupt:Show(icon)
            end
            -- call_action_list,name=cooldown,if=gcd.remains=0
            if (A.GetGCD() == 0) then
                local ShouldReturn = Cooldown(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- pick_up_fragment,if=fury.deficit>=35
            if A.PickUpFragment:IsReady(unit) and (Unit("player"):FuryDeficit() >= 35) then
                return A.PickUpFragment:Show(icon)
            end
            -- call_action_list,name=dark_slash,if=talent.dark_slash.enabled&(variable.waiting_for_dark_slash|debuff.dark_slash.up)
            if (A.DarkSlash:IsSpellLearned() and (bool(VarWaitingForDarkSlash) or Unit(unit):HasDeBuffs(A.DarkSlashDebuff.ID, true))) then
                local ShouldReturn = DarkSlash(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- run_action_list,name=demonic,if=talent.demonic.enabled
            if (A.Demonic:IsSpellLearned()) then
                return Demonic(unit);
            end
            -- run_action_list,name=normal
            if (true) then
                return Normal(unit);
            end
        end
    end

    -- End on EnemyRotation()

    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 

    -- Mouseover
    if A.IsUnitEnemy("mouseover") then
        unit = "mouseover"
        if EnemyRotation(unit) then 
            return true 
        end 
    end 

    -- Target  
    if A.IsUnitEnemy("target") then 
        unit = "target"
        if EnemyRotation(unit) then 
            return true
        end 

    end
end
-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 -- [5] Trinket Rotation
-- No specialization trinket actions 
-- Passive 
local function FreezingTrapUsedByEnemy()
    if     UnitCooldown:GetCooldown("arena", 3355) > UnitCooldown:GetMaxDuration("arena", 3355) - 2 and
    UnitCooldown:IsSpellInFly("arena", 3355) and 
    Unit("player"):GetDR("incapacitate") >= 50 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", 3355)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end 
local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit("player"):GetDMG() == 0 or not Unit("player"):IsFocused("DAMAGER")) then 
            -- Reflect Casting BreakAble CC
            if A.NetherWard:IsReady() and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(EnemyTeam()) and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.NetherWard:Show(icon)
            end 
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

  	-- SingeMagic
    if A.SingeMagic:IsCastable() and A.SingeMagic:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Action.AuraIsValid(unit, "UseDispel", "Magic") and not Unit(unit):InLOS() then
        return A.SingeMagic:Show(icon)
    end
end 

A[6] = function(icon)
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    return ArenaRotation(icon, "arena3")
end

