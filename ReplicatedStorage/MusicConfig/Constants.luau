-- Constants Module
-- Berisi semua konstanta yang digunakan di Music System

local Constants = {}

-- ===== COOLDOWN CONSTANTS =====
Constants.REQUEST_COOLDOWN = 1   -- detik per player untuk request lagu
Constants.SKIP_COOLDOWN = 6      -- detik per player untuk skip
Constants.MAX_QUEUE = 50         -- batas maksimal antrian

-- ===== VOTE SYSTEM CONSTANTS =====
Constants.VOTE_DURATION = 160    -- durasi vote dalam detik
Constants.MIN_PLAYERS = 1        -- minimum players untuk vote (untuk testing)
Constants.VOTE_COOLDOWN = 30     -- cooldown antara vote dalam detik

-- ===== DJ MODE UI CONSTANTS =====
-- Toggle knob positions
Constants.KNOB_POS_OFF = UDim2.new(0.125, 0, 0.129, 0)
Constants.KNOB_POS_ON = UDim2.new(0.508, 0, 0.129, 0)

-- Toggle colors
Constants.TOGGLE_COLOR_OFF = Color3.fromRGB(170, 0, 0)
Constants.TOGGLE_COLOR_ON = Color3.fromRGB(0, 85, 0)

-- ===== ANIMATION CONSTANTS =====
Constants.POP_DURATION = 0.2
Constants.POP_EASING_STYLE = Enum.EasingStyle.Back
Constants.POP_EASING_DIRECTION = Enum.EasingDirection.Out

-- Toast notification timing
Constants.TOAST_SLIDE_DURATION = 0.25
Constants.TOAST_DISPLAY_DURATION = 1.8
Constants.NOWPLAYING_DISPLAY_DURATION = 3

return Constants
