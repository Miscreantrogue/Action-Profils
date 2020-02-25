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
local TR                                     = Action.TasteRotation
local pairs                                  = pairs
--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_DEATHKNIGHT_BLOOD] = {
    -- Racial
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Action.Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594    }), 
    BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics
    DeathStrike                            = Action.Create({ Type = "Spell", ID = 49998 }),
    BloodDrinker                           = Action.Create({ Type = "Spell", ID = 206931 }),
    DancingRuneWeaponBuff                  = Action.Create({ Type = "Spell", ID = 81256 }),
    Marrowrend                             = Action.Create({ Type = "Spell", ID = 195182 }),
    BoneShieldBuff                         = Action.Create({ Type = "Spell", ID = 195181 }),
    HeartEssence                           = Action.Create({ Type = "Spell", ID = 298554 }),
    BloodBoil                              = Action.Create({ Type = "Spell", ID = 50842 }),
    HemostasisBuff                         = Action.Create({ Type = "Spell", ID = 273947 }),
    Ossuary                                = Action.Create({ Type = "Spell", ID = 219786 }),
    Bonestorm                              = Action.Create({ Type = "Spell", ID = 194844 }),
    Heartbreaker                           = Action.Create({ Type = "Spell", ID = 221536 }),
    DeathandDecay                          = Action.Create({ Type = "Spell", ID = 43265 }),
    RuneStrike                             = Action.Create({ Type = "Spell", ID = 210764 }),
    HeartStrike                            = Action.Create({ Type = "Spell", ID = 206930 }),
    CrimsonScourgeBuff                     = Action.Create({ Type = "Spell", ID = 81141 }),
    RapidDecomposition                     = Action.Create({ Type = "Spell", ID = 194662 }),
    Consumption                            = Action.Create({ Type = "Spell", ID = 205223 }),
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    Tombstone                              = Action.Create({ Type = "Spell", ID = 219809 }),
    -- Trinkets  
    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    DribblingInkpod                        = Action.Create({ Type = "Trinket", ID = 169319, QueueForbidden = true }),
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    RazdunksBigRedButton                   = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }),
    MerekthasFang                          = Action.Create({ Type = "Trinket", ID = 158367, QueueForbidden = true }),
    KnotofAncientFuryAlliance              = Action.Create({ Type = "Trinket", ID = 161413, QueueForbidden = true }),
    KnotofAncientFuryHorde                 = Action.Create({ Type = "Trinket", ID = 166795, QueueForbidden = true }),
    FirstMatesSpyglass                     = Action.Create({ Type = "Trinket", ID = 158163, QueueForbidden = true }),
    GrongsPrimalRage                       = Action.Create({ Type = "Trinket", ID = 165574, QueueForbidden = true }),
    LurkersInsidiousGift                   = Action.Create({ Type = "Trinket", ID = 167866, QueueForbidden = true }),
    NotoriousGladiatorsBadge               = Action.Create({ Type = "Trinket", ID = 167380, QueueForbidden = true }),
    NotoriousGladiatorsMedallion           = Action.Create({ Type = "Trinket", ID = 167377, QueueForbidden = true }),
    SinisterGladiatorsBadge                = Action.Create({ Type = "Trinket", ID = 165058, QueueForbidden = true }),
    SinisterGladiatorsMedallion            = Action.Create({ Type = "Trinket", ID = 165055, QueueForbidden = true }),
    VialofAnimatedBlood                    = Action.Create({ Type = "Trinket", ID = 159625, QueueForbidden = true }),
    JesHowler                              = Action.Create({ Type = "Trinket", ID = 159627, QueueForbidden = true }),
	-- Defensives
    IceboundFortitude                      = Action.Create({ Type = "Spell", ID = 48792 }),
    AntiMagicShell                         = Action.Create({ Type = "Spell", ID = 48707 }),
    DancingRuneWeapon                      = Action.Create({ Type = "Spell", ID = 49028 }),
    VampiricBlood                          = Action.Create({ Type = "Spell", ID = 55233 }),
    DeathPact                              = Action.Create({ Type = "Spell", ID = 48743 }),	-- Talent
	-- Utilities
	DarkCommand                            = Action.Create({ Type = "Spell", ID = 56222     }), 
	WraithWalk                             = Action.Create({ Type = "Spell", ID = 212552     }), 
	MindFreeze                             = Action.Create({ Type = "Spell", ID = 47528     }),
	Asphyxiate                             = Action.Create({ Type = "Spell", ID = 108194     }),
	DeathsAdvance                          = Action.Create({ Type = "Spell", ID = 48265     }), -- 30% Speed & immune to 100% normal speed
	DeathGrip                              = Action.Create({ Type = "Spell", ID = 49576     }),
    ChainsofIce                            = Action.Create({ Type = "Spell", ID = 45524     }), -- 70% snare, 8sec
    RaiseAlly                              = Action.Create({ Type = "Spell", ID = 61999     }),	 -- Battle rez
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
	SuperiorSteelskinPotion                = Action.Create({ Type = "Potion", ID = 168501, QueueForbidden = true }), 
	AbyssalHealingPotion                   = Action.Create({ Type = "Potion", ID = 169451, QueueForbidden = true }), 
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
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
	BonesoftheDamned                       = Action.Create({ Type = "Spell", ID = 279503, Hidden = true     }),
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2               = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3               = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                  = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    BloodoftheEnemy                        = Action.Create({ Type = "HeartOfAzeroth", ID = 297108, Hidden = true}),
    BloodoftheEnemy2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298273, Hidden = true}),
    BloodoftheEnemy3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298277, Hidden = true}),
    ConcentratedFlame                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295373, Hidden = true}),
    ConcentratedFlame2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299349, Hidden = true}),
    ConcentratedFlame3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299353, Hidden = true}),
    GuardianofAzeroth                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295840, Hidden = true}),
    GuardianofAzeroth2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299355, Hidden = true}),
    GuardianofAzeroth3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299358, Hidden = true}),
    FocusedAzeriteBeam                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295258, Hidden = true}),
    FocusedAzeriteBeam2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299336, Hidden = true}),
    FocusedAzeriteBeam3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299338, Hidden = true}),
    PurifyingBlast                         = Action.Create({ Type = "HeartOfAzeroth", ID = 295337, Hidden = true}),
    PurifyingBlast2                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299345, Hidden = true}),
    PurifyingBlast3                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299347, Hidden = true}),
    TheUnboundForce                        = Action.Create({ Type = "HeartOfAzeroth", ID = 298452, Hidden = true}),
    TheUnboundForce2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299376, Hidden = true}),
    TheUnboundForce3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299378, Hidden = true}),
    RippleInSpace                          = Action.Create({ Type = "HeartOfAzeroth", ID = 302731, Hidden = true}),
    RippleInSpace2                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302982, Hidden = true}),
    RippleInSpace3                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302983, Hidden = true}),
    WorldveinResonance                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295186, Hidden = true}),
    WorldveinResonance2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298628, Hidden = true}),
    WorldveinResonance3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299334, Hidden = true}),
    MemoryofLucidDreams                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    MemoryofLucidDreams2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),
    MemoryofLucidDreams3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}), 
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_DEATHKNIGHT_BLOOD)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_BLOOD], { __index = Action })


local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
-------------- COMMON PREAPL -------------
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

-- SelfDefensives
local function SelfDefensives(unit)
    local HPLoosePerSecond = Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax()
		
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
	
    -- Vampiric Blood
    local VampiricBlood = Action.GetToggle(2, "VampiricBloodHP")
    if     VampiricBlood >= 0 and A.VampiricBlood:IsReady("player") and 
    (
        (   -- Auto 
            VampiricBlood >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(15) < 5 or
				-- Custom logic with current HPS and DMG
				Unit("player"):HealthPercent() <= 45 or			
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
            VampiricBlood < 100 and 
            Unit("player"):HealthPercent() <= VampiricBlood
        )
    ) 
    then 
        return A.VampiricBlood
    end
	
    -- Dancing Rune Weapon
    local DancingRuneWeapon = Action.GetToggle(2, "DancingRuneWeaponHP")
    if     DancingRuneWeapon >= 0 and A.DancingRuneWeapon:IsReady("player") and 
    (
        (   -- Auto 
            DancingRuneWeapon >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 15 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.15 or 
                -- TTD 
                Unit("player"):TimeToDieX(55) < 5 or					
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
            DancingRuneWeapon < 100 and 
            Unit("player"):HealthPercent() <= DancingRuneWeapon
        )
    ) 
    then 
        return A.DancingRuneWeapon
    end  

    -- Icebound Fortitude
    local IceboundFortitude = Action.GetToggle(2, "IceboundFortitudeHP")
    if     IceboundFortitude >= 0 and A.IceboundFortitude:IsReady("player") and 
    (
        (   -- Auto 
            IceboundFortitude >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(15) < 5 or
				-- HP value
				Unit("player"):HealthPercent() < 35 or
				-- Player stunned
                A.IsInPvP and LoC:Get("STUN") > 0	or			
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
            IceboundFortitude < 100 and 
            Unit("player"):HealthPercent() <= IceboundFortitude
        )
    ) 
    then 
        return A.IceboundFortitude
    end  
	
	    -- HealingPotion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady("player") and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 10 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.10 or 
                -- TTD 
                Unit("player"):TimeToDieX(30) < 5 or 
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
            AbyssalHealingPotion < 100 and 
            Unit("player"):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end 
		
    -- Emergency AntiMagicShell
        local AntiMagicShell = Action.GetToggle(2, "AntiMagicShellHP")
        if     AntiMagicShell >= 0 and A.AntiMagicShell:IsReady("player") and 
        (
            (   -- Auto 
                AntiMagicShell >= 100 and 
                (
                    -- HP lose per sec >= 10
                    Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 10 or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.10 or 
                    -- TTD Magic
                    Unit("player"):TimeToDieMagicX(40) < 5 or 
					
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
                AntiMagicShell < 100 and 
                Unit("player"):HealthPercent() <= AntiMagicShell
            )
        ) 
        then 
            return A.AntiMagicShell
        end  		

        -- Emergency Death Pact
        local DeathPact = Action.GetToggle(2, "DeathPactHP")
        if     DeathPact >= 0 and A.DeathPact:IsReady("player") and A.DeathPact:IsSpellLearned() and 
        (
            (   -- Auto 
                DeathPact >= 100 and 
                (
                    -- HP lose per sec >= 30
                    Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 30 or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.30 or 
                    -- TTD 
                    Unit("player"):TimeToDieX(10) < 5 or 
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
                DeathPact < 100 and 
                Unit("player"):HealthPercent() <= DeathPact
            )
        ) 
        then 
            return A.DeathPact
        end  		

end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    local EnemiesCasting = MultiUnits:GetByRangeCasting(10, 5, true, "TargetMouseover")
		
    -- MindFreeze
    if useKick and A.MindFreeze:IsReady(unit) then 
     	if Unit(unit):CanInterrupt(true, nil, 25, 70) then
       	    return A.MindFreeze
       	end 
   	end 
	
    -- DeathGrip
    if useCC and not A.MindFreeze:IsReady(unit) and A.DeathGrip:IsReady(unit) and A.GetToggle(2, "DeathGripInterrupt") then 
     	if Unit(unit):CanInterrupt(true, nil, 25, 70) then
       	    return A.DeathGrip
       	end 
   	end 
	
   	-- Asphyxiate
   	if useCC and A.Asphyxiate:IsSpellLearned() and A.Asphyxiate:IsReady(unit) then 
 		if Unit(unit):CanInterrupt(true, nil, 25, 70) then
   	        return A.Asphyxiate
   	    end 
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

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
	local isMovingFor = A.Player:IsMovingTime()
    local inCombat = Unit("player"):CombatTime() > 0
    local combatTime = Unit("player"):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
    local unit = "player"
    local ActiveMitigationNeeded = Player:ActiveMitigationNeeded()
	local IsTanking = Unit("player"):IsTanking("target", 8) or Unit("player"):IsTankingAoE(8)
	local HPLoosePerSecond = Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax()
	local targetThreatSituation, targetThreatPercent = Unit("player"):ThreatSituation()
	local threatDamagerLimit = (A.Role == "DAMAGER" and A.GetToggle(2, "ThreatDamagerLimit")) or -1
    local isSafestThreatRotation = not A.IsInPvP and A.Zone ~= "none" and A.TeamCache.Friendly.Size > 1 and threatDamagerLimit ~= -1 and targetThreatPercent >= threatDamagerLimit

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        local Precombat, Standard
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- potion
            if A.SuperiorSteelskinPotion:IsReady(unit) and Action.GetToggle(1, "Potion") then
                return A.SuperiorSteelskinPotion:Show(icon)
            end
        end
        
        --Standard
        local function Standard(unit)	
					
            -- blooddrinker,if=!buff.dancing_rune_weapon.up
            if A.BloodDrinker:IsReady(unit) and (Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true) == 0 or Unit("player"):HasBuffs(A.VampiricBlood.ID, true) > 0) then
                return A.BloodDrinker:Show(icon)
            end
			
            -- marrowrend,if=(buff.bone_shield.remains<=rune.time_to_3|buff.bone_shield.remains<=(gcd+cooldown.blooddrinker.ready*talent.blooddrinker.enabled*2)|buff.bone_shield.stack<3)&runic_power.deficit>=20
            if A.Marrowrend:IsReady(unit) and 
			    (
				    (
					    Unit("player"):HasBuffs(A.BoneShieldBuff.ID, true) <= Player:RuneTimeToX(3) 
						or 
						Unit("player"):HasBuffs(A.BoneShieldBuff.ID, true) <= (A.GetGCD() + num(A.BloodDrinker:GetCooldown() == 0) * num(A.BloodDrinker:IsSpellLearned()) * 2) 
						or 
						Unit("player"):HasBuffsStacks(A.BoneShieldBuff.ID, true) < 3
					) 
					and Player:RunicPowerDeficit() >= 20
				) 
			then
                return A.Marrowrend:Show(icon)
            end
			
            -- bonestorm,if=runic_power>=100&!buff.dancing_rune_weapon.up
            if A.Bonestorm:IsReady("player") and A.Bonestorm:IsSpellLearned() and 
			(
			    Unit("player"):HealthPercent() <= 60 and Player:RunicPower() >= 50 
			    or 
			    (Player:RunicPower() >= 40 and Unit("player"):HasBuffs(A.VampiricBlood.ID, true) > 0)			
			) 
			then
                return A.Bonestorm:Show(icon)
            end
			
            -- death_strike
			local DeathStrike = Action.GetToggle(2, "DeathStrikeHP")
            if DeathStrike >= 0 and A.DeathStrike:IsReady(unit) and 
			(
			    
				-- Auto 
                DeathStrike >= 100 and
                (
				    -- HP lose per sec >= 8
                    Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 8 or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.08 or 
                    -- TTD 
                    Unit("player"):TimeToDieX(25) < 5 or
				    -- Custom logic with current HPS and DMG
				    Unit("player"):HealthPercent() <= 85 
				)                
				or
                (    -- Custom
                    DeathStrike < 100 and 
                    Unit("player"):HealthPercent() <= DeathStrike
                )				
            )				
			then
                return A.DeathStrike:Show(icon)
            end	
			
            -- blood_boil,if=charges_fractional>=1.8&(buff.hemostasis.stack<=(5-spell_targets.blood_boil)|spell_targets.blood_boil>2)
            if A.BloodBoil:IsReady(unit) and 
			    (
				    A.BloodBoil:GetSpellChargesFrac() >= 1.8 
					and 
					(Unit("player"):HasBuffsStacks(A.HemostasisBuff.ID, true) <= (5 - MultiUnits:GetByRange(15, 5, 10)) or MultiUnits:GetByRange(15, 5, 10) > 2)
				) 
			then
                return A.BloodBoil:Show(icon)
            end
			
            -- marrowrend,if=buff.bone_shield.stack<5&talent.ossuary.enabled&runic_power.deficit>=15
            if A.Marrowrend:IsReady(unit) and 
			    (
			        Unit("player"):HasBuffsStacks(A.BoneShieldBuff.ID, true) < 7 - num(A.BonesoftheDamned:GetAzeriteRank() > 0)
			    ) 
			then
                return A.Marrowrend:Show(icon)
            end
			
            -- death_strike,if=runic_power.deficit<=(15+buff.dancing_rune_weapon.up*5+spell_targets.heart_strike*talent.heartbreaker.enabled*2)|Unit(unit):TimeToDie()<10
            if A.DeathStrike:IsReady(unit) and (Player:RunicPowerDeficit() <= (15 + num(Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true) > 0) * 5 + MultiUnits:GetByRange(15, 5, 10) * num(A.Heartbreaker:IsSpellLearned()) * 2) or Unit(unit):TimeToDie() < 10) then
                return A.DeathStrike:Show(icon)
            end
			
            -- death_and_decay,if=spell_targets.death_and_decay>=3
            if A.DeathandDecay:IsReady("player") then
                return A.DeathandDecay:Show(icon)
            end
			
            -- rune_strike,if=(charges_fractional>=1.8|buff.dancing_rune_weapon.up)&rune.time_to_3>=gcd
            if A.RuneStrike:IsReady(unit) and ((A.RuneStrike:GetSpellChargesFrac() >= 1.8 or Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true) > 0) and Player:RuneTimeToX(3) >= A.GetGCD()) then
                return A.RuneStrike:Show(icon)
            end
			
            -- heart_strike,if=buff.dancing_rune_weapon.up|rune.time_to_4<gcd
            if A.HeartStrike:IsReady(unit) and Player:Rune() > 2 then
                return A.HeartStrike:Show(icon)
            end
			
            -- blood_boil,if=buff.dancing_rune_weapon.up
            if A.BloodBoil:IsReady(unit) and (Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true) > 0) then
                return A.BloodBoil:Show(icon)
            end
			
            -- death_and_decay,if=buff.crimson_scourge.up|talent.rapid_decomposition.enabled|spell_targets.death_and_decay>=2
            if A.DeathandDecay:IsReady("player") and (Unit("player"):HasBuffs(A.CrimsonScourgeBuff.ID, true) > 0 or A.RapidDecomposition:IsSpellLearned() or MultiUnits:GetByRange(15, 5, 10) >= 2) then
                return A.DeathandDecay:Show(icon)
            end
			
            -- consumption
            if A.Consumption:IsReady(unit) then
                return A.Consumption:Show(icon)
            end
			
            -- blood_boil
            if A.BloodBoil:IsReady(unit) then
                return A.BloodBoil:Show(icon)
            end
			
            -- heart_strike,if=rune.time_to_3<gcd|buff.bone_shield.stack>6
            if A.HeartStrike:IsReady(unit) and (Player:RuneTimeToX(3) < A.GetGCD() or Unit("player"):HasBuffsStacks(A.BoneShieldBuff.ID, true) > 6) then
                return A.HeartStrike:Show(icon)
            end
			
            -- use_item,name=grongs_primal_rage
            if A.GrongsPrimalRage:IsReady(unit) then
                return A.GrongsPrimalRage:Show(icon)
            end
			
            -- rune_strike
            if A.RuneStrike:IsReady(unit) then
                return A.RuneStrike:Show(icon)
            end
			
            -- arcane_torrent,if=runic_power.deficit>20
            if A.ArcaneTorrent:IsRacialReady(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Player:RunicPowerDeficit() > 20) then
                return A.ArcaneTorrent:Show(icon)
            end
			
        end
        
        
        -- call precombat
        if not inCombat and Precombat(unit) and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then
			
			-- Interrupt
            local Interrupt = Interrupts(unit)
            if Interrupt then 
                return Interrupt:Show(icon)
            end	
			
			-- VigilantProtector
            if A.VigilantProtector:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.VigilantProtector:Show(icon)
            end
						
		    -- Taunt 
            if A.GetToggle(2, "AutoTaunt") 
			and combatTime > 0     
			then 
			    -- if not fully aggroed or we are not current target then use taunt
			    if A.DarkCommand:IsReady(unit, true, nil, nil, nil) and not Unit(unit):IsDummy() and not Unit(unit):IsBoss() and Unit(unit):GetRange() <= 30 and ( Unit("targettarget"):InfoGUID() ~= Unit("player"):InfoGUID() ) then 
                    return A.DarkCommand:Show(icon)
				-- else if all good on current target, switch to another one we know we dont currently tank
                else
                    local DarkCommand_Nameplates = MultiUnits:GetActiveUnitPlates()
                    if DarkCommand_Nameplates then  
                        for DarkCommand_UnitID in pairs(DarkCommand_Nameplates) do             
                            if not Unit(DarkCommand_UnitID):IsPlayer() and not UnitIsUnit("target", DarkCommand_UnitID) and not Unit(DarkCommand_UnitID):IsDummy() and not Unit(DarkCommand_UnitID):IsBoss() and Unit(DarkCommand_UnitID):GetRange() <= 30 and not Unit(DarkCommand_UnitID):InLOS() and Unit("player"):ThreatSituation(DarkCommand_UnitID) ~= 3 then 
                                if A.DarkCommand:IsReady(DarkCommand_UnitID, true, nil, nil, nil) then
							        return A:Show(icon, ACTION_CONST_AUTOTARGET)
								elseif A.DeathGrip:IsReady(DarkCommand_UnitID, true, nil, nil, nil) and not A.DarkCommand:IsReady(DarkCommand_UnitID, true, nil, nil, nil) then
								    return A:Show(icon, ACTION_CONST_AUTOTARGET)
								else
								    return
								end
                            end         
                        end 
                    end
				end
            end
			
            -- blood_fury,if=cooldown.dancing_rune_weapon.ready&(!cooldown.blooddrinker.ready|!talent.blooddrinker.enabled)
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (A.DancingRuneWeapon:GetCooldown() == 0 and (not A.BloodDrinker:GetCooldown() == 0 or not A.BloodDrinker:IsSpellLearned())) then
                return A.BloodFury:Show(icon)
            end
			
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
			
            -- use_items,if=cooldown.dancing_rune_weapon.remains>90
            -- use_item,name=razdunks_big_red_button
            if A.RazdunksBigRedButton:IsReady(unit) then
                return A.RazdunksBigRedButton:Show(icon)
            end
			
            -- use_item,name=merekthas_fang
            if A.MerekthasFang:IsReady(unit) then
                return A.MerekthasFang:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down
            if A.AshvanesRazorCoral:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true))) then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=buff.dancing_rune_weapon.up&debuff.razor_coral_debuff.up
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true) > 0 and Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) > 0) then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- potion,if=buff.dancing_rune_weapon.up
            if A.SuperiorSteelskinPotion:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true) > 0) then
                return A.SuperiorSteelskinPotion:Show(icon)
            end
			
            -- tombstone,if=buff.bone_shield.stack>=7
            if A.Tombstone:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.BoneShieldBuff.ID, true) >= 7) then
                return A.Tombstone:Show(icon)
            end
			
            -- call_action_list,name=standard
            if Standard(unit) then
                return true
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
--[[local function FreezingTrapUsedByEnemy()
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
            if A.NetherWard:IsReady() and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(unit) and EnemyTeam():IsCastingBreakAble(0.25) then 
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
end]]--

