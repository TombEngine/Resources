
--Version 1

local obj_ElectricCleaner = {}

-- FUNCTIONS IN THIS MODULE
-------------------------------------------------------------------------
-- Test_Text()
-- SetMovementSpeed(moveableObject, speed)
-- SetRotationSpeed(moveableObject, speed)
-- Flag_StopAfterKill(moveableObject, flagStopAfterKill)
-- Flag_ForwardPriority(moveableObject, flagForwardPriority)
-- Flag_RightPriority(moveableObject, flagRightPriority)


-------------------------------------------------------------------------

-- VARIABLES GUIDE
-------------------------------------------------------------------------

-- LocationAI: unused

-- ITEMFLAGS
-- [0]: Rotation speed. Default 1024
-- [1]: Flags: (0) DoDetection, (1) Rotate right, (2) Priority Forward, (3) Priority Right, (4) StopAfterKill
-- [2]: Movement speed. Default 64
-- [3]: Timer for lights and effects.
-- [4]: Timer for lights and effects. 
-- [5]: Timer for lights and effects.
-- [6]: Goal direction angle (in Radians)
-- [7]: unused

-------------------------------------------------------------------------

function obj_ElectricCleaner.Test_Text()
    local TextTimerEnd = "Text from ELECTRIC CLEANER module"
    local text = DisplayString(TextTimerEnd, 100, 200, Color.new(250,250,250))
    ShowString(text, 5)
end

function obj_ElectricCleaner.SetMovementSpeed(moveableObject, speed)
	moveableObject:SetItemFlags( speed, 2 )
end

function obj_ElectricCleaner.SetRotationSpeed(moveableObject, speed)
	moveableObject:SetItemFlags( speed, 0 )
end

-- When the cleaner kills Lara, this flag control if it shall stop
-- or continue its path.
function obj_ElectricCleaner.Flag_StopAfterKill(moveableObject, flagStopAfterKill)
    local flagResult = 0
    if (flagStopAfterKill == true) then
        flagResult = moveableObject:GetItemFlags(1) | (1 << 4) -- turn on bit 4 for flag_StopAfterKill
    else
        flagResult = moveableObject:GetItemFlags(1) & ~(1 << 4) -- turn off bit 4 for flag_StopAfterKill
    end
    moveableObject:SetItemFlags( flagResult, 1 )
end

-- When the cleaner reaches a sector, it will try to go forward ahead until it find an obstacle.
-- (Then it will turn left or right depending of the flag_RightPriority).
function obj_ElectricCleaner.Flag_ForwardPriority(moveableObject, flagForwardPriority)
    local flagResult = 0
    if (flagForwardPriority == true) then
        flagResult = moveableObject:GetItemFlags(1) | (1 << 2) -- turn on bit 2 for flag_ForwardPriority
    else
        flagResult = moveableObject:GetItemFlags(1) & ~(1 << 2) -- turn off bit 2 for flag_ForwardPriority
    end
    moveableObject:SetItemFlags( flagResult, 1 )
end

-- When the cleaner reaches a sector, if flag is activate, it will 
-- give preference the right path over the left one.
function obj_ElectricCleaner.Flag_RightPriority(moveableObject, flagRightPriority)
    local flagResult = 0
    if (flagRightPriority == true) then
        flagResult = moveableObject:GetItemFlags(1) | (1 << 3) -- turn on bit 3 for flag_ForwardPriority
    else
        flagResult = moveableObject:GetItemFlags(1) & ~(1 << 3) -- turn off bit 3 for flag_ForwardPriority
    end
    moveableObject:SetItemFlags( flagResult, 1 )
end

return obj_ElectricCleaner
