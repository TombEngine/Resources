-- Module:	HUD_CustomBar
-- Version: 1.0
-- Author:	Adngel
-- Date: 	03/2024

--------------------
-- Content
--------------------
-- Module declaration
-- Constants
-- Variables
-- General Functions
--		Initialize ()
--		Draw (time)
--		DebugDraw (time)
--		Save ()
--		Load ()
-- Control Functions
--		UpdateBarValue (float newPercentage)
--		GetVisibility ()
--		SetVisibility (bool visibility)
--		SetAvatarID (int newID)
--		SetBarContainerID (int newID)
--		SetBarID (int newID)
--		SetAvatarColor (Color newColor)
--		SetBarContainerColor (Color newColor)
--		SetBarColor (Color newColor)
--		SetBarsPosition (Vec2 newPos)
--		SetAvatarPosition (Vec2 newPos)
--		SetBarContainerPosition (Vec2 newPos)
--		SetBarPosition (Vec2 newPos)
--		SetAvatarSize (Vec2 newSize)
--		SetBarContainerSize (Vec2 newSize)
--		SetBarSize (Vec2 newSize)
-- Private functions
--		_ManageFading ()
--		_PingPongInterpolate (time, duration)
-- Module Closure


--------------------
-- Module declaration
--------------------
local HUD_CustomBar = {}

--------------------
-- Constants
--------------------

local FADE_STEP = 9

--------------------
-- Variables
--------------------

local isVisible = false
local alpha = 0
local percentage = 0
local bar_max_width = 1.75


local avatar_Sprite
local avatar_ID = 0
local avatar_Color = Color(255, 255, 255, 0)
local avatar_Pos = Vec2 (05, 20)
local avatar_Size = Vec2 (8,8)

local barContainer_Sprite
local barContainer_ID = 1
local barContainer_Color = Color(255, 255, 255, 0)
local barContainer_Pos = Vec2 (10, 20)
local barContainer_Size = Vec2 (2,2)

local bar_Sprite
local bar_ID = 2
local bar_Color = Color(255, 255, 255, 0)
local bar_Pos = Vec2 (10.1, 20)
local bar_Size = Vec2 (bar_max_width,1.75)


--------------------
-- General Functions
--------------------

-- Initialize the HUD elements (Call on level start and on level load)
function HUD_CustomBar.Initialize()

    avatar_Sprite 		= DisplaySprite(TEN.Objects.ObjID.CUSTOM_SPRITES, 0, avatar_Pos, 0, avatar_Size, Color(avatar_Color.r, avatar_Color.g, avatar_Color.b, alpha))
    barContainer_Sprite = DisplaySprite(TEN.Objects.ObjID.CUSTOM_SPRITES, 1, barContainer_Pos, 0, barContainer_Size, Color(barContainer_Color.r, barContainer_Color.g, barContainer_Color.b, alpha))
    bar_Sprite 			= DisplaySprite(TEN.Objects.ObjID.CUSTOM_SPRITES, 2, bar_Pos, 0, Vec2(percentage, bar_Size.y), Color(bar_Color.r, bar_Color.g, bar_Color.b, alpha))
    
end

-- Draw the HUD on the screen (Call on level loop)
function HUD_CustomBar.Draw(time)
    
    _ManageFading ()

    if (alpha > 0) then
    	avatar_Sprite:SetColor(Color(avatar_Color.r, avatar_Color.g, avatar_Color.b, alpha))
    	avatar_Sprite:Draw(0, View.AlignMode.CENTER, View.ScaleMode.FILL, Effects.BlendID.ALPHABLEND)
    	
    	barContainer_Sprite:SetColor(Color(barContainer_Color.r, barContainer_Color.g, barContainer_Color.b, alpha))
    	barContainer_Sprite:Draw(1, View.AlignMode.CENTER_LEFT, View.ScaleMode.FILL, Effects.BlendID.ALPHABLEND)
    	
    	bar_Sprite:SetColor(Color(bar_Color.r, bar_Color.g, bar_Color.b, alpha))
    	bar_Sprite:Draw(2, View.AlignMode.CENTER_LEFT, View.ScaleMode.FILL, Effects.BlendID.ALPHABLEND)
    end
    
end

-- Draw the HUD filling and unfilling it for Debug purposes (if needed, call on level loop instead of the Draw() one)
function HUD_CustomBar.DebugDraw(time)
	
    local interpolatedPercentage = _PingPongInterpolate(time, 5)
	HUD_CustomBar.UpdateBarValue(interpolatedPercentage / 100)
	
	HUD_CustomBar.Draw (time)
	
end

-- Save the variables into the savegame's level vars
function HUD_CustomBar.Save ()

	LevelVars.customBar = {}

	LevelVars.customBar.isVisible = isVisible
	LevelVars.customBar.alpha = alpha
	LevelVars.customBar.percentage = percentage
	LevelVars.customBar.bar_max_width = bar_max_width
	
	LevelVars.customBar.avatar_ID = avatar_ID
	LevelVars.customBar.avatar_Color = avatar_Color
	LevelVars.customBar.avatar_Pos = avatar_Pos
	LevelVars.customBar.avatar_Size = avatar_Size
	
	LevelVars.customBar.barContainer_ID = barContainer_ID
	LevelVars.customBar.barContainer_Color = barContainer_Color
	LevelVars.customBar.barContainer_Pos = barContainer_Pos
	LevelVars.customBar.barContainer_Size = barContainer_Size
	
	LevelVars.customBar.bar_ID = bar_ID
	LevelVars.customBar.bar_Color = bar_Color
	LevelVars.customBar.bar_Pos = bar_Pos
	LevelVars.customBar.bar_Size = bar_Size

end

-- Restore the properties variables from the savegame's level vars
function HUD_CustomBar.Load ()

	isVisible = LevelVars.customBar.isVisible
	alpha = LevelVars.customBar.alpha
	percentage = LevelVars.customBar.percentage
	bar_max_width = LevelVars.customBar.bar_max_width
	
	avatar_ID =LevelVars.customBar.avatar_ID
	avatar_Color = LevelVars.customBar.avatar_Color
	avatar_Pos = LevelVars.customBar.avatar_Pos
	avatar_Size = LevelVars.customBar.avatar_Size
	
	barContainer_ID = LevelVars.customBar.barContainer_ID
	barContainer_Color = LevelVars.customBar.barContainer_Color
	barContainer_Pos = LevelVars.customBar.barContainer_Pos
	barContainer_Size = LevelVars.customBar.barContainer_Size
	
	bar_ID = LevelVars.customBar.bar_ID
	bar_Color = LevelVars.customBar.bar_Color
	bar_Pos = LevelVars.customBar.bar_Pos
	bar_Size = LevelVars.customBar.bar_Size

	avatar_Sprite 		= DisplaySprite(TEN.Objects.ObjID.CUSTOM_SPRITES, avatar_ID, avatar_Pos, 0, avatar_Size, Color(avatar_Color.r, avatar_Color.g, avatar_Color.b, alpha))
    barContainer_Sprite = DisplaySprite(TEN.Objects.ObjID.CUSTOM_SPRITES, barContainer_ID, barContainer_Pos, 0, barContainer_Size, Color(barContainer_Color.r, barContainer_Color.g, barContainer_Color.b, alpha))
    bar_Sprite 			= DisplaySprite(TEN.Objects.ObjID.CUSTOM_SPRITES, bar_ID, bar_Pos, 0, Vec2(percentage, bar_Size.y), Color(bar_Color.r, bar_Color.g, bar_Color.b, alpha))
	
end

--------------------
-- Control Functions
--------------------

-- Update the bar with a new percentage value
function HUD_CustomBar.UpdateBarValue(newPercentage)

    percentage = newPercentage
    percentage = math.max(0, math.min(1, percentage))

    local newBarWidth = bar_max_width * percentage
    bar_Sprite:SetScale(Vec2(newBarWidth, bar_Size.y))

end

-- Get the bar visibility status
function HUD_CustomBar.GetVisibility()

    return isVisible
    
end

-- Set the bar visibility status (Use this to show or hide the bar)
function HUD_CustomBar.SetVisibility(visibility)

    isVisible = visibility
    
end

-- Set the sprite ID for the HUD elements
-- IDs are indicated in the WadTool's sprite editor.

function HUD_CustomBar.SetAvatarID(newID)

	avatar_ID = newID
    avatar_Sprite:SetSpriteID(avatar_ID)
    
end

function HUD_CustomBar.SetBarContainerID(newID)
	
	barContainer_ID = newID
    barContainer_Sprite:SetSpriteID(barContainer_ID)
    
end

function HUD_CustomBar.SetBarID(newID)

	bar_ID = newID
    bar_Sprite:SetSpriteID(bar_ID)
    
end

-- Set the color (Color (red, green, blue, alpha))
-- Alpha value will be overwritten internally for this module fading feature.

function HUD_CustomBar.SetAvatarColor (newColor)

	avatar_Color = newColor
	
end

function HUD_CustomBar.SetBarContainerColor (newColor)

	barContainer_Color = newColor
	
end

function HUD_CustomBar.SetBarColor (newColor)

	bar_Color = newColor
	
end

-- Set the position for the bar (interior and container)
function HUD_CustomBar.SetBarsPosition (newPos)

	barContainer_Pos = newPos
	bar_Pos.x = barContainer_Pos.x + 0.1
	bar_Pos.y = barContainer_Pos.y
	
	bar_Sprite:SetPosition (bar_Pos)
	barContainer_Sprite:SetPosition (barContainer_Pos)
	
end

-- Set the position of the elements individually.
function HUD_CustomBar.SetAvatarPosition (newPos)

	avatar_Pos = newPos
	avatar_Sprite:SetPosition (avatar_Pos)
	
end

function HUD_CustomBar.SetBarPosition (newPos)

	bar_Pos = newPos
	bar_Sprite:SetPosition (bar_Pos)
	
end

function HUD_CustomBar.SetBarContainerPosition (newPos)

	barContainer_Pos = newPos
	barContainer_Sprite:SetPosition (barContainer_Pos)
end

-- Set the size of the different elements
function HUD_CustomBar.SetAvatarSize (newSize)
	
	avatar_Size = newSize
	avatar_Sprite:SetScale (avatar_Size)
	
end

-- Set the size of the different elements
function HUD_CustomBar.SetBarSize (newSize)
	
	bar_Size = newSize
	bar_Sprite:SetScale (avatar_Size)
	
end

-- Set the size of the different elements
function HUD_CustomBar.SetBarContainerSize (newSize)
	
	barContainer_Size = newSize
	barContainer_Sprite:SetScale (avatar_Size)
	
end


--------------------
-- Private functions
--------------------

-- Manage the transparency fading effect
function _ManageFading ()

	if (isVisible == true and alpha < 255) then
    	
    	alpha = alpha + FADE_STEP
    	
    	if alpha > 255 then
    		alpha = 255
    	end
    	
    elseif (isVisible == false and alpha > 0) then
    	
    	alpha = alpha - FADE_STEP
    	
    	if alpha < 0 then
    		alpha = 0
    	end
    	
    end

end

-- Ping pong interpolation function (Used only for DebugDraw)
function _PingPongInterpolate(time, duration)

    local t = time % duration
    local halfDuration = duration / 2

    if t < halfDuration then
        return (t / halfDuration) * 100
    else
        return ((duration - t) / halfDuration) * 100
    end
    
end


--------------------
-- Module Closure
--------------------

return HUD_CustomBar
