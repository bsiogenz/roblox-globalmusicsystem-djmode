
================================================================================
                   SISTEM MUSIK CANGGIH - README
                        oleh Margo Studio
================================================================================

Terima kasih telah membeli Advanced Music System!
Dokumen ini akan memandu Anda melalui setup dan kustomisasi.

================================================================================
                            DAFTAR ISI
================================================================================

1. FITUR-FITUR
2. INSTALASI & SETUP
3. KONFIGURASI
4. MENAMBAH PLAYLIST
5. KUSTOMISASI
6. TROUBLESHOOTING
7. DUKUNGAN & KREDIT

================================================================================
                              1. FITUR-FITUR
================================================================================

✅ Sistem Antrian Canggih
   - Browse playlist dengan fitur search
   - Tambah lagu ke antrian dengan cooldown protection
   - Drag & drop untuk mengatur ulang antrian
   - Update antrian real-time untuk semua player

✅ Mode DJ
   - Kontrol musik eksklusif untuk player yang di-whitelist
   - Toggle Mode DJ on/off via ConfigButton
   - Saat aktif: hanya DJ yang bisa menambah lagu, skip, dan mengatur antrian
   - Animasi UI yang smooth dengan toggle switch

✅ Sistem Vote Skip (Mode Non-DJ)
   - Player bisa vote untuk skip lagu saat ini
   - Mayoritas (50%+) memenangkan vote
   - Durasi vote dan cooldown bisa dikonfigurasi
   - Progress vote visual dengan timer

✅ Notifikasi Kaya
   - Toast notification "Added to Queue"
   - Banner "Now Playing" dengan info requester
   - Avatar player dan display names
   - Sistem antrian notifikasi (tidak overlap)

✅ Display Requester
   - Menampilkan siapa yang request lagu saat ini
   - Avatar player dengan format DisplayName (@Username)
   - Auto-hide ketika antrian kosong

✅ Arsitektur Modular
   - Terpisah: Config, Constants, Utils, AnimationHelpers
   - Mudah dikustomisasi dan di-maintain
   - Mode debug dan warning untuk development

================================================================================
                        2. INSTALASI & SETUP
================================================================================

LANGKAH 1: VERIFIKASI STRUKTUR
--------
Pastikan Anda memiliki struktur berikut di game Anda:

ReplicatedStorage/
├── MusicConfig/
│   ├── Config (ModuleScript)
│   ├── Constants (ModuleScript)
│   ├── Utils (ModuleScript)
│   └── AnimationHelpers (ModuleScript)
├── MusicEvents/ (Folder dengan RemoteEvents & RemoteFunctions)
└── README_ID (Script - file ini)

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
└── Sound (Sound object - auto-dibuat jika tidak ada)


LANGKAH 2: KONFIGURASI WHITELIST
--------
1. Buka ReplicatedStorage > MusicConfig > Config
2. Tambahkan username (BUKAN DisplayName) ke tabel Whitelist:

   Config.Whitelist = {
       "UsernameAnda",
       "UsernameTeman",
       "DJLainnya"
   }

3. Hanya player yang di-whitelist yang bisa:
   - Melihat dan menggunakan ConfigButton
   - Toggle Mode DJ on/off
   - Kontrol musik saat Mode DJ aktif


LANGKAH 3: TAMBAHKAN PLAYLIST ANDA
--------
1. Buka ServerStorage > Playlists
2. Ikuti format yang ditunjukkan di bagian 4 di bawah
3. Tambahkan ID lagu Anda (ID asset Audio dari Roblox)


LANGKAH 4: TES IN-GAME
--------
1. Mulai test server dengan minimal 2 player (untuk testing vote)
2. Player yang di-whitelist harus melihat ConfigButton (ikon gear)
3. Tes menambah lagu, skip, dan toggle Mode DJ

================================================================================
                           3. KONFIGURASI
================================================================================

MODUL CONFIG (ReplicatedStorage > MusicConfig > Config)
------------
- DebugMode: Set true untuk logging verbose (default: false)
- WarnMode: Set false untuk mematikan warning (default: false)
- Whitelist: Array username untuk akses Mode DJ


MODUL CONSTANTS (ReplicatedStorage > MusicConfig > Constants)
---------------
Pengaturan Cooldown:
- REQUEST_COOLDOWN: Detik antara request lagu per player (default: 1)
- SKIP_COOLDOWN: Detik antara skip per player (default: 6)
- MAX_QUEUE: Maksimum lagu di antrian (default: 50)

Sistem Vote:
- VOTE_DURATION: Timeout vote dalam detik (default: 160)
- MIN_PLAYERS: Minimum player untuk vote (default: 1)
- VOTE_COOLDOWN: Detik antara vote per player (default: 30)

UI Mode DJ:
- KNOB_POS_OFF / KNOB_POS_ON: Posisi knob toggle
- TOGGLE_COLOR_OFF / TOGGLE_COLOR_ON: Warna toggle

Timing Animasi:
- POP_DURATION: Kecepatan animasi pop ConfigFrame (default: 0.2s)
- TOAST_SLIDE_DURATION: Kecepatan animasi slide toast (default: 0.25s)
- TOAST_DISPLAY_DURATION: Waktu tampil "Added to Queue" (default: 1.8s)
- NOWPLAYING_DISPLAY_DURATION: Waktu tampil "Now Playing" (default: 3s)


MODUL UTILS (ReplicatedStorage > MusicConfig > Utils)
------------
Fungsi utility untuk:
- Manajemen cooldown
- Clearing UI
- Sorting alfabetis
- Otorisasi (canReorder, hasAccess - kustomisasi sesuai kebutuhan)


ANIMATION HELPERS (ReplicatedStorage > MusicConfig > AnimationHelpers)
-----------------
Fungsi animasi siap pakai:
- Animasi pop-out (ConfigFrame)
- Animasi slide (Toast notifications)
- Animasi toggle (Switch Mode DJ)
- Animasi fade (Ghost drag & drop)

================================================================================
                        4. MENAMBAH PLAYLIST
================================================================================

MODUL PLAYLISTS (ServerStorage > Playlists)
---------------
Struktur:

local Playlists = {}

-- Playlist Anda
Playlists.Data = {
    ["Nama Playlist"] = {
        { Name = "Judul Lagu 1", Id = 1234567890 },
        { Name = "Judul Lagu 2", Id = 9876543210 },
        { Name = "Judul Lagu 3", Id = 5555555555 },
    },
    
    ["Playlist Lain"] = {
        { Name = "Lagu Keren", Id = 1111111111 },
        { Name = "Beat Epic", Id = 2222222222 },
    },
}

-- Fungsi helper (JANGAN DIMODIFIKASI)
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


CARA MENDAPATKAN ID LAGU:
-------------------------
1. Cari audio di Roblox (harus publik/bisa digunakan di game Anda)
2. Copy ID asset dari URL
   Contoh: roblox.com/library/1234567890/Song-Name
   ID = 1234567890
3. Paste ID di playlist

CATATAN PENTING:
- Gunakan ID Audio Roblox asli (bukan link YouTube atau platform lain)
- Pastikan Anda punya izin untuk menggunakan audio (cek TOS Roblox)
- Test setiap ID lagu untuk memastikan berfungsi
- Playlist ada di ServerStorage untuk keamanan (client tidak bisa edit)

================================================================================
                          5. KUSTOMISASI
================================================================================

KUSTOMISASI UI:
---------------
Semua elemen UI ada di StarterGui > MusicGUI. Anda bisa kustomisasi:
- Warna, ukuran, posisi frame
- Font, warna text, ukuran text
- Style button dan layout
- Posisi toast notification

PENTING: Jika Anda rename elemen UI, update referensi di script Handler!


MENAMBAH FITUR BARU:
--------------------
Sistem ini modular, jadi Anda bisa extend:

1. Tambah RemoteEvent baru di ReplicatedStorage > MusicEvents
2. Tambah handler di musichandler (server) dan Handler (client)
3. Gunakan modul yang ada (Utils, Constants, AnimationHelpers)

Contoh: Tambah fitur "Pause"
- Buat RemoteEvent PauseSong
- Tambah handler di musichandler untuk sound:Pause()
- Tambah button di UI yang fires PauseSong event


MENGUBAH ANIMASI:
-----------------
Edit nilai di modul Constants atau AnimationHelpers:
- Durasi animasi
- Easing styles (Quad, Back, Bounce, dll.)
- Arah tween (In, Out, InOut)


MENONAKTIFKAN FITUR:
--------------------
Untuk menonaktifkan Mode DJ sepenuhnya:
- Hapus logic visibility ConfigButton di Handler
- Hapus handler ToggleDJMode
- Set isDJModeActive = false permanen

Untuk menonaktifkan Vote Skip:
- Hapus button skip di UI
- Gunakan skip langsung (seperti instant skip Mode DJ)

================================================================================
                        6. TROUBLESHOOTING
================================================================================

MASALAH: ConfigButton tidak muncul untuk player yang di-whitelist
SOLUSI: 
- Verifikasi username (BUKAN DisplayName) ada di Config.Whitelist
- Cek spelling dan kapitalisasi (case-sensitive)
- Aktifkan DebugMode di Config untuk melihat cek whitelist di Output


MASALAH: Lagu tidak diputar
SOLUSI:
- Verifikasi ID audio benar dan publik
- Cek apakah Anda punya izin audio (update privasi audio Roblox)
- Aktifkan DebugMode untuk melihat pesan error
- Cek apakah Workspace > Sound object ada


MASALAH: UI Vote tidak muncul
SOLUSI:
- Pastikan persyaratan MIN_PLAYERS terpenuhi
- Cek apakah Mode DJ aktif (vote dinonaktifkan di Mode DJ)
- Verifikasi SkipVoteFrame ada di MusicGUI
- Aktifkan DebugMode untuk log detail


MASALAH: Drag & drop tidak bekerja di antrian
SOLUSI:
- Cek apakah Mode DJ aktif dan player tidak di-whitelist
- Pastikan antrian punya item untuk di-drag
- Verifikasi RemoteEvent ReorderQueue ada


MASALAH: Notifikasi overlap
SOLUSI:
- Sistem menggunakan antrian untuk notifikasi (seharusnya tidak overlap)
- Cek TOAST_DISPLAY_DURATION dan TOAST_SLIDE_DURATION di Constants
- Verifikasi logic antrian notifikasi di script Handler


MASALAH: Player tidak bisa tambah lagu di Mode DJ
SOLUSI:
- Ini perilaku yang diinginkan! Mode DJ membatasi kontrol hanya untuk whitelist
- Toggle Mode DJ OFF untuk izinkan semua player tambah lagu
- Atau tambahkan player ke whitelist


DEBUGGING UMUM:
---------------
1. Set Config.DebugMode = true
2. Cek jendela Output untuk log detail
3. Cari pesan dengan prefix [SERVER] dan [CLIENT]
4. Cek pesan error (text merah)

================================================================================
                       7. DUKUNGAN & KREDIT
================================================================================

DUKUNGAN:
---------
Jika Anda mengalami masalah atau butuh bantuan:
1. Baca ulang dokumentasi ini dengan teliti
2. Aktifkan DebugMode dan cek Output untuk error
3. Hubungi Margo Studio untuk dukungan

PENTING: Sebelum meminta bantuan, mohon sediakan:
- Deskripsi jelas tentang masalah
- Screenshot error (jika ada)
- Log output dengan DebugMode aktif


KREDIT:
-------
Advanced Music System v1.0
Dikembangkan oleh: Margo Studio

Terima kasih telah menggunakan sistem kami!


SYARAT PENGGUNAAN:
------------------
- Sistem ini dilisensikan per-game
- Jangan redistribusi atau jual ulang sistem ini
- Anda boleh modifikasi untuk game Anda sendiri
- Kredit ke Margo Studio diapresiasi tapi tidak wajib


UPDATE:
-------
Cek kembali dengan Margo Studio untuk update dan fitur baru di masa depan!


================================================================================
                         AKHIR DOKUMENTASI
================================================================================

Butuh bantuan? Hubungi Margo Studio
Selamat memutar musik! 🎵

================================================================================
