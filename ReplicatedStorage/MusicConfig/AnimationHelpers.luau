-- AnimationHelpers Module
-- Berisi helper functions untuk animasi UI

local TweenService = game:GetService("TweenService")
local Constants = require(script.Parent:WaitForChild("Constants"))

local AnimationHelpers = {}

-- ===== POP-OUT ANIMATION SETUP =====
-- Setup animasi pop-out untuk frame (menggunakan UIScale)
-- Returns: openTween, closeTween
function AnimationHelpers.setupPopAnimation(frame: Frame)
	local uiScale = frame:FindFirstChild("ConfigPopScale")
	if not uiScale then
		uiScale = Instance.new("UIScale")
		uiScale.Name = "ConfigPopScale"
		uiScale.Parent = frame
		uiScale.Scale = 0
	else
		uiScale.Scale = 0
	end

	local closeEasingDirection = Enum.EasingDirection.In

	local openTweenInfo = TweenInfo.new(
		Constants.POP_DURATION, 
		Constants.POP_EASING_STYLE, 
		Constants.POP_EASING_DIRECTION
	)
	local closeTweenInfo = TweenInfo.new(
		Constants.POP_DURATION, 
		Constants.POP_EASING_STYLE, 
		closeEasingDirection
	)

	local openTween = TweenService:Create(uiScale, openTweenInfo, {Scale = 1})
	local closeTween = TweenService:Create(uiScale, closeTweenInfo, {Scale = 0})

	closeTween.Completed:Connect(function(playbackState)
		if playbackState == Enum.PlaybackState.Completed then
			frame.Visible = false
		end
	end)

	return openTween, closeTween
end

-- ===== TOAST SLIDE ANIMATION =====
-- Setup posisi untuk toast notification (slide dari kanan)
-- Returns: basePos, offRightPos
function AnimationHelpers.setupToastPositions(toastFrame: Frame)
	local basePos = toastFrame.Position
	
	local offRightPos = UDim2.new(
		basePos.X.Scale + 1,
		basePos.X.Offset,
		basePos.Y.Scale,
		basePos.Y.Offset
	)
	
	return basePos, offRightPos
end

-- Create tween untuk slide in (dari kanan ke tengah)
function AnimationHelpers.createSlideInTween(frame: Frame, targetPos: UDim2)
	return TweenService:Create(
		frame,
		TweenInfo.new(Constants.TOAST_SLIDE_DURATION, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ Position = targetPos }
	)
end

-- Create tween untuk slide out (dari tengah ke kanan)
function AnimationHelpers.createSlideOutTween(frame: Frame, targetPos: UDim2)
	return TweenService:Create(
		frame,
		TweenInfo.new(Constants.TOAST_SLIDE_DURATION, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{ Position = targetPos }
	)
end

-- ===== TOGGLE ANIMATION =====
-- Create tween untuk toggle knob
function AnimationHelpers.createToggleTween(knob: Frame, targetPos: UDim2, duration: number?)
	duration = duration or 0.2
	return TweenService:Create(
		knob,
		TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ Position = targetPos }
	)
end

-- Create tween untuk toggle color
function AnimationHelpers.createColorTween(element: GuiObject, targetColor: Color3, duration: number?)
	duration = duration or 0.2
	return TweenService:Create(
		element,
		TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ BackgroundColor3 = targetColor }
	)
end

-- ===== FADE ANIMATION =====
-- Create fade out tween
function AnimationHelpers.createFadeOutTween(element: GuiObject, duration: number?)
	duration = duration or 0.15
	return TweenService:Create(
		element,
		TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{
			BackgroundTransparency = 1, 
			TextTransparency = 1
		}
	)
end

return AnimationHelpers
