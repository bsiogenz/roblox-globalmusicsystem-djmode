-- Playlists Module
-- Berisi semua data playlist lagu untuk Music System

local Playlists = {}

-- Data playlists
Playlists.Data = {
	["Playlist 1"] = {
		{Name = "Disco-Electronica", Id = 108362942037367},
	},	
	["Playlist 2"] = {
		{Name = "Electronic Time", Id = 104663110460575},
	},
	["Playlist 3"] = {
		{Name = "Pump", Id = 129304569756576},
	}
}

-- Helper function untuk get playlist by name
function Playlists:GetPlaylist(playlistName: string)
	return self.Data[playlistName]
end

-- Helper function untuk get semua playlists
function Playlists:GetAll()
	return self.Data
end

-- Helper function untuk get song dari playlist
function Playlists:GetSong(playlistName: string, trackIndex: number)
	local playlist = self.Data[playlistName]
	if playlist then
		return playlist[trackIndex]
	end
	return nil
end

return Playlists
