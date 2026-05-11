
================================================================================
                    ADVANCED MUSIC SYSTEM - README
                         by Margo Studio
================================================================================

Thank you for purchasing the Advanced Music System!
This document will guide you through setup and customization.

================================================================================
                             TABLE OF CONTENTS
================================================================================

1. FEATURES
2. INSTALLATION & SETUP
3. CONFIGURATION
4. ADDING PLAYLISTS
5. CUSTOMIZATION
6. TROUBLESHOOTING
7. SUPPORT & CREDITS

================================================================================
                               1. FEATURES
================================================================================

✅ Advanced Queue System
   - Browse playlists with search functionality
   - Add songs to queue with cooldown protection
   - Drag & drop to reorder queue
   - Real-time queue updates for all players

✅ DJ Mode
   - Exclusive music control for whitelisted players
   - Toggle DJ Mode on/off via ConfigButton
   - When active: only DJs can add songs, skip, and reorder queue
   - Smooth UI animations with toggle switch

✅ Vote Skip System (Non-DJ Mode)
   - Players can vote to skip current song
   - Majority (50%+) wins the vote
   - Configurable vote duration and cooldowns
   - Visual vote progress with timer

✅ Rich Notifications
   - "Added to Queue" toast notifications
   - "Now Playing" banners with requester info
   - Player avatars and display names
   - Queued notification system (no overlaps)

✅ Requester Display
   - Shows who requested the current song
   - Player avatar with DisplayName (@Username) format
   - Auto-hides when queue is empty

✅ Modular Architecture
   - Separated Config, Constants, Utils, AnimationHelpers
   - Easy to customize and maintain
   - Debug and warning modes for development

================================================================================
                        2. INSTALLATION & SETUP
================================================================================

STEP 1: VERIFY STRUCTURE
--------
Ensure you have the following structure in your game:

ReplicatedStorage/
├── MusicConfig/
│   ├── Config (ModuleScript)
│   ├── Constants (ModuleScript)
│   ├── Utils (ModuleScript)
│   └── AnimationHelpers (ModuleScript)
├── MusicEvents/ (Folder with RemoteEvents & RemoteFunctions)
└── README_EN (Script - this file)

ServerStorage/
└── Playlists (ModuleScript)

ServerScriptService/
└── musichandler (Script)

StarterGui/
└── MusicGUI/ (ScreenGui)
    ├── Handler (LocalScript)
    ├── MainFrame (...)
    ├── NowPlayingNotif (...)
    ├── AddedToQueue (...)
    └── SkipVoteFrame (...)

Workspace/
└── Sound (Sound object - auto-created if missing)


STEP 2: CONFIGURE WHITELIST
--------
1. Open ReplicatedStorage > MusicConfig > Config
2. Add usernames (NOT DisplayNames) to the Whitelist table:

   Config.Whitelist = {
       "YourUsername",
       "FriendUsername",
       "AnotherDJ"
   }

3. Only whitelisted players can:
   - See and use the ConfigButton
   - Toggle DJ Mode on/off
   - Control music when DJ Mode is active


STEP 3: ADD YOUR PLAYLISTS
--------
1. Open ServerStorage > Playlists
2. Follow the format shown in section 4 below
3. Add your song IDs (Audio asset IDs from Roblox)


STEP 4: TEST IN-GAME
--------
1. Start a test server with at least 2 players (for vote testing)
2. Whitelisted players should see a ConfigButton (gear icon)
3. Test adding songs, skipping, and DJ Mode toggle

================================================================================
                          3. CONFIGURATION
================================================================================

CONFIG MODULE (ReplicatedStorage > MusicConfig > Config)
-------------
- DebugMode: Set to true for verbose logging (default: false)
- WarnMode: Set to false to silence warnings (default: false)
- Whitelist: Array of usernames for DJ Mode access


CONSTANTS MODULE (ReplicatedStorage > MusicConfig > Constants)
----------------
Cooldown Settings:
- REQUEST_COOLDOWN: Seconds between song requests per player (default: 1)
- SKIP_COOLDOWN: Seconds between skips per player (default: 6)
- MAX_QUEUE: Maximum songs in queue (default: 50)

Vote System:
- VOTE_DURATION: Vote timeout in seconds (default: 160)
- MIN_PLAYERS: Minimum players needed to vote (default: 1)
- VOTE_COOLDOWN: Seconds between votes per player (default: 30)

DJ Mode UI:
- KNOB_POS_OFF / KNOB_POS_ON: Toggle knob positions
- TOGGLE_COLOR_OFF / TOGGLE_COLOR_ON: Toggle colors

Animation Timing:
- POP_DURATION: ConfigFrame pop animation speed (default: 0.2s)
- TOAST_SLIDE_DURATION: Toast slide animation speed (default: 0.25s)
- TOAST_DISPLAY_DURATION: "Added to Queue" display time (default: 1.8s)
- NOWPLAYING_DISPLAY_DURATION: "Now Playing" display time (default: 3s)


UTILS MODULE (ReplicatedStorage > MusicConfig > Utils)
------------
Utility functions for:
- Cooldown management
- UI clearing
- Alphabetical sorting
- Authorization (canReorder, hasAccess - customize as needed)


ANIMATION HELPERS (ReplicatedStorage > MusicConfig > AnimationHelpers)
-----------------
Pre-built animation functions:
- Pop-out animations (ConfigFrame)
- Slide animations (Toast notifications)
- Toggle animations (DJ Mode switch)
- Fade animations (Drag & drop ghost)

================================================================================
                         4. ADDING PLAYLISTS
================================================================================

PLAYLISTS MODULE (ServerStorage > Playlists)
----------------
Structure:

local Playlists = {}

-- Your playlists
Playlists.Data = {
    ["Playlist Name"] = {
        { Name = "Song Title 1", Id = 1234567890 },
        { Name = "Song Title 2", Id = 9876543210 },
        { Name = "Song Title 3", Id = 5555555555 },
    },
    
    ["Another Playlist"] = {
        { Name = "Cool Song", Id = 1111111111 },
        { Name = "Epic Beat", Id = 2222222222 },
    },
}

-- Helper functions (DO NOT MODIFY)
function Playlists:GetAll()
    return self.Data
end

function Playlists:GetSong(playlistName, trackIndex)
    local playlist = self.Data[playlistName]
    if playlist and playlist[trackIndex] then
        return playlist[trackIndex]
    end
    return nil
end

return Playlists


HOW TO GET SONG IDs:
--------------------
1. Find an audio on Roblox (must be public/usable in your game)
2. Copy the asset ID from the URL
   Example: roblox.com/library/1234567890/Song-Name
   ID = 1234567890
3. Paste the ID in the playlist

IMPORTANT NOTES:
- Use actual Roblox Audio IDs (not YouTube links or other platforms)
- Ensure you have permission to use the audio (check Roblox TOS)
- Test each song ID to make sure it works
- Playlists are in ServerStorage for security (clients can't edit them)

================================================================================
                          5. CUSTOMIZATION
================================================================================

UI CUSTOMIZATION:
-----------------
All UI elements are in StarterGui > MusicGUI. You can customize:
- Colors, sizes, positions of frames
- Font, text colors, text sizes
- Button styles and layouts
- Toast notification positions

IMPORTANT: If you rename UI elements, update the Handler script references!


ADDING NEW FEATURES:
--------------------
The system is modular, so you can extend it:

1. Add new RemoteEvents in ReplicatedStorage > MusicEvents
2. Add handlers in musichandler (server) and Handler (client)
3. Use existing modules (Utils, Constants, AnimationHelpers)

Example: Add a "Pause" feature
- Create PauseSong RemoteEvent
- Add handler in musichandler to sound:Pause()
- Add button in UI that fires PauseSong event


CHANGING ANIMATIONS:
--------------------
Edit values in Constants module or AnimationHelpers:
- Animation durations
- Easing styles (Quad, Back, Bounce, etc.)
- Tween directions (In, Out, InOut)


DISABLING FEATURES:
-------------------
To disable DJ Mode entirely:
- Remove ConfigButton visibility logic in Handler
- Remove ToggleDJMode handlers
- Set isDJModeActive = false permanently

To disable Vote Skip:
- Remove skip button in UI
- Use direct skip (like DJ Mode instant skip)

================================================================================
                        6. TROUBLESHOOTING
================================================================================

PROBLEM: ConfigButton not showing for whitelisted player
SOLUTION: 
- Verify username (NOT DisplayName) is in Config.Whitelist
- Check spelling and capitalization (case-sensitive)
- Enable DebugMode in Config to see whitelist checks in Output


PROBLEM: Songs not playing
SOLUTION:
- Verify audio IDs are correct and public
- Check if you have audio permissions (Roblox audio privacy update)
- Enable DebugMode to see error messages
- Check if Workspace > Sound object exists


PROBLEM: Vote UI not showing
SOLUTION:
- Ensure MIN_PLAYERS requirement is met
- Check if DJ Mode is active (votes disabled in DJ Mode)
- Verify SkipVoteFrame exists in MusicGUI
- Enable DebugMode for detailed logs


PROBLEM: Drag & drop not working in queue
SOLUTION:
- Check if DJ Mode is active and player is not whitelisted
- Ensure queue has items to drag
- Verify ReorderQueue RemoteEvent exists


PROBLEM: Notifications overlapping
SOLUTION:
- The system uses a queue for notifications (should not overlap)
- Check TOAST_DISPLAY_DURATION and TOAST_SLIDE_DURATION in Constants
- Verify notification queue logic in Handler script


PROBLEM: Players can't add songs in DJ Mode
SOLUTION:
- This is intended behavior! DJ Mode restricts control to whitelisted only
- Toggle DJ Mode OFF to allow all players to add songs
- Or add the player to the whitelist


GENERAL DEBUGGING:
------------------
1. Set Config.DebugMode = true
2. Check Output window for detailed logs
3. Look for [SERVER] and [CLIENT] prefixed messages
4. Check for error messages (red text)

================================================================================
                        7. SUPPORT & CREDITS
================================================================================

SUPPORT:
--------
If you encounter issues or need help:
1. Re-read this documentation carefully
2. Enable DebugMode and check Output for errors
3. Contact Margo Studio for support

IMPORTANT: Before asking for help, please provide:
- Clear description of the issue
- Screenshots of the error (if any)
- Output logs with DebugMode enabled


CREDITS:
--------
Advanced Music System v1.0
Developed by: Margo Studio

Thank you for using our system!


TERMS OF USE:
-------------
- This system is licensed per-game
- Do not redistribute or resell this system
- You may modify for your own game
- Credit to Margo Studio is appreciated but not required


UPDATES:
--------
Check back with Margo Studio for future updates and new features!


================================================================================
                            END OF DOCUMENTATION
================================================================================

Need help? Contact Margo Studio
Happy music playing! 🎵

================================================================================
