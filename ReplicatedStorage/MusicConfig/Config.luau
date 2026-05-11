-- Music System Configuration
-- Edit whitelist di bawah ini untuk mengatur siapa saja yang bisa mengakses DJ Mode

local Config = {}

-- ===== DEBUG SETTINGS =====
-- Set to true to enable verbose logging across music scripts
Config.DebugMode = false
-- Set to false to silence warn() output across music scripts
Config.WarnMode = false

-- ===== WHITELIST SETTINGS =====
-- Tambahkan username player yang boleh akses DJ Mode & Config
-- Format: masukkan username (bukan DisplayName) dalam list di bawah
Config.Whitelist = {
	"bsiogen",     -- Contoh: ganti dengan username asli
	"l0ooV3ee4",     -- Contoh: ganti dengan username asli
	"YourUsername" -- Tambahkan username kamu di sini
}

-- Fungsi helper untuk check whitelist
function Config:IsWhitelisted(player: Player): boolean
	if not player then return false end
	
	local username = player.Name
	for _, whitelistedName in ipairs(self.Whitelist) do
		if username == whitelistedName then
			return true
		end
	end
	
	return false
end

return Config
