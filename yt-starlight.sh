#!/usr/bin/env bash

. ./core/config.cfg

### Colors ##

ESC=$(printf '\033') RESET="${ESC}[0m" BLACK="${ESC}[30m" RED="${ESC}[31m"
GREEN="${ESC}[32m" YELLOW="${ESC}[33m" BLUE="${ESC}[34m" MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m" WHITE="${ESC}[37m" DEFAULT="${ESC}[39m"

### Color Functions ##

greenprint() { printf "${GREEN}%s${RESET}\n" "$1"; }
blueprint() { printf "${BLUE}%s${RESET}\n" "$1"; }
redprint() { printf "${RED}%s${RESET}\n" "$1"; }
yellowprint() { printf "${YELLOW}%s${RESET}\n" "$1"; }
magentaprint() { printf "${MAGENTA}%s${RESET}\n" "$1"; }
cyanprint() { printf "${CYAN}%s${RESET}\n" "$1"; }

### Command Functions ##

fn_pause() { read -s -n 1 -p "Press any key to continue . . ."; echo ""; }
fn_bye() { echo "Bye bye."; exit 0; }
fn_fail() { echo "Wrong option." exit 1; }

fn_ffmpeg_ver() { ffmpeg -version; }
fn_ffmpeg_vbr() {
echo "";
echo "*Can be a number between 1 and 8.";
echo "";
read -p 'Write bitrate: ' if_ffmpeg_vbr;
ffmpeg_vbr="$if_ffmpeg_vbr"; }
fn_ffmpeg_cbr() {
echo "";
echo "*Can be a number between 64 and 320.";
echo "";
read -p 'Write bitrate: ' if_ffmpeg_cbr;
ffmpeg_cbr="$if_ffmpeg_cbr"; }
fn_ffmpeg_mode() { if [[ "$ffmpeg_mode" == "VBR" ]]; then ffmpeg_mode="CBR"; else ffmpeg_mode="VBR"; fi }

fn_ytdl_updt() { $super_user $fork -U; }
fn_ytdl_ver() { yt-dlp --version; }
fn_ytdl_agent() { yt-dlp --dump-user-agent; }
fn_ytdl_che_file() { read -p 'Enter URL: ' link; echo "Checking $link for available formats.."; yt-dlp -F $link; }
fn_ytdl_dtype() { if [[ "$dtype" == "file" ]]; then dtype="playlist"; else dtype="file"; fi }
fn_ytdl_vtype() {
echo "";
echo "Some of the currently used formats, however this";
echo "can change in future, so check for available";
echo "files from time to time. Not all videos";
echo "has support up to 4K!";
echo "";
echo "134 - 360P AVC1 / 396 - 360P AV01 / 135 - 480P AVC1";
echo "397 - 480P AV01 / 136 - 720P AVC1 / 398 - 720P AV01";
echo "137 - 1080P AVC1 / 399 - 1080P AV01 / 400 - 2K AV01";
echo "401 - 4K AV01";
echo "";
read -p 'Write filetype: ' ifvtype;
vtype="$ifvtype"; }
fn_ytdl_atype() { read -p 'Write filetype: ' ifatype; atype="$ifatype"; }

fn_ffmpeg_mp3() { if [[ "$ffmpeg_mp3" == "yes" ]]; then ffmpeg_mp3="no"; else ffmpeg_mp3="yes"; fi }
fn_vid_audio() { if [[ "$vid_audio" == "yes" ]]; then vid_audio="no"; else vid_audio="yes"; fi }

fn_downld_video_na() { read -p 'Enter URL: ' link; echo "[youtube] Downloading $link please wait."; $fork -f $vtype $link --output $mp4_dir"%(title)s.%(ext)s"; }
fn_downld_video_na_plst() { read -p 'Enter URL: ' link; echo "[youtube] Downloading $link please wait."; $fork -f $vtype --yes-playlist $link --output $mp4_dir"%(title)s.%(ext)s"; }
fn_downld_video_a() { read -p 'Enter URL: ' link; echo "[youtube] Downloading $link please wait."; $fork -f $vtype+$atype $link --output $mp4_dir"%(title)s.%(ext)s"; }
fn_downld_video_a_plst() { read -p 'Enter URL: ' link; echo "[youtube] Downloading $link please wait."; $fork -f $vtype+$atype --yes-playlist $link --output $mp4_dir"%(title)s.%(ext)s"; }
fn_downld_video() { if [[ "$vid_audio" == "no" ]]; then if [[ "$dtype" == "file" ]]; then fn_downld_video_na; else fn_downld_video_na_plst; fi; else if [[ "$dtype" == "file" ]]; then fn_downld_video_a; else fn_downld_video_a_plst; fi; fi }

fn_downld_audio_m4a() { read -p 'Enter URL: ' link; echo "[youtube] Downloading $link please wait."; $fork -f $atype $link --output $m4a_dir"%(title)s.%(ext)s"; }
fn_downld_audio_m4a_plst() { read -p 'Enter URL: ' link; echo "[youtube] Downloading $link please wait."; $fork -f $atype --yes-playlist $link --output $m4a_dir"%(title)s.%(ext)s"; }
fn_downld_audio_mp3() { if [[ "$ffmpeg_mode" == "VBR" ]]; then downld_ffmpeg_mode="-q $ffmpeg_vbr"; else downld_ffmpeg_mode="-b:a $ffmpeg_cbr"; fi; read -p 'Enter URL: ' link; echo "[youtube] Downloading $link please wait."; $fork -f $atype $link --output $mp3_dir"%(title)s.%(ext)s"; for i in $mp3_dir*.m4a; do ffmpeg -i "$i" -c:a libmp3lame $downld_ffmpeg_mode "${i%.*}.mp3"; done; rm $mp3_dir*.m4a; }
fn_downld_audio_mp3_plst() { if [[ "$ffmpeg_mode" == "VBR" ]]; then downld_ffmpeg_mode="-q $ffmpeg_vbr"; else downld_ffmpeg_mode="-b:a $ffmpeg_cbr"; fi; read -p 'Enter URL: ' link; echo "[youtube] Downloading $link please wait."; $fork -f $atype --yes-playlist $link --output $mp3_dir"%(title)s.%(ext)s"; for i in $mp3_dir*.m4a; do ffmpeg -i "$i" -c:a libmp3lame $downld_ffmpeg_mode "${i%.*}.mp3"; done; rm $mp3_dir*.m4a; }
fn_downld_audio() { if [[ "$ffmpeg_mp3" == "no" ]]; then if [[ "$dtype" == "file" ]]; then fn_downld_audio_m4a; else fn_downld_audio_m4a_plst; fi; else if [[ "$dtype" == "file" ]]; then fn_downld_audio_mp3; else fn_downld_audio_mp3_plst; fi; fi }

fn_ch_fork() { read -p 'Write fork name: ' iffork; fork="$iffork"; }
fn_ch_mp3_path() { read -p 'Type *.mp3 library path: ' ifmp3_dir; mp3_dir="$ifmp3_dir"; }
fn_ch_m4a_path() { read -p 'Type *.m4a library path: ' ifm4a_dir; m4a_dir="$ifm4a_dir"; }
fn_ch_mp4_path() { read -p 'Type *.mp4 library path: ' ifmp4_dir; mp4_dir="$ifmp4_dir"; }
fn_ch_super_user() { read -p 'Write super user action: ' ifsuper_user; super_user="$ifsuper_user"; }

fn_factory() {
rm ./core/config.cfg
tee ./core/config.cfg > /dev/null << EOF
atype="m4a";
vtype="136";
dtype="file";
fork="yt-dlp";
ffmpeg_mode="VBR";
ffmpeg_mp3="yes";
ffmpeg_vbr="4";
ffmpeg_cbr="128k";
vid_audio="yes";
mp4_dir="./mp4/"
m4a_dir="./m4a/"
mp3_dir="./mp3/"
super_user="sudo"
EOF
echo "Factory settings restored!";
}

fn_save() {
rm ./core/config.cfg
tee ./core/config.cfg > /dev/null << EOF
atype="$atype";
vtype="$vtype";
dtype="$dtype";
fork="$fork";
ffmpeg_mode="$ffmpeg_mode";
ffmpeg_mp3="$ffmpeg_mp3";
ffmpeg_vbr="$ffmpeg_vbr";
ffmpeg_cbr="$ffmpeg_cbr";
vid_audio="$vid_audio";
mp4_dir="$mp4_dir"
m4a_dir="$m4a_dir"
mp3_dir="$mp3_dir"
super_user="$super_user"
EOF
}

fn_about() {
echo "";
echo "===============================================";
echo "     YT-Starlight (linux edition)";
echo "===============================================";
echo "";
echo "     It's made for testing purposes only!";
echo "     Please, respect the artists, if you like";
echo "     their work and talent, support them by";
echo "     purchasing it from official e-store.";
echo "";
echo "     github.com/IvoNexus/youtube-starlight";
echo "";
echo "     Licensed under GNU GPLv3";
echo "     Version 0.3 - 25-01-2023";
echo "     Written by #IvoNexus aka Specter";
echo "";
echo "===============================================";
echo ""; }

### Project Start ##

settingsmenu() {
    clear
    echo -ne "
===============================================
$(magentaprint '      Settings')
===============================================

$(greenprint '1)') + Change fork name
$(greenprint '')   - current $fork

$(greenprint '2)') + Change *.mp3 folder
$(greenprint '')   - current $mp3_dir

$(greenprint '3)') + Change *.m4a folder
$(greenprint '')   - current $m4a_dir

$(greenprint '4)') + Change *.mp4 folder
$(greenprint '')   - current $mp4_dir

$(greenprint '5)') + Change super user action
$(greenprint '')   - current $super_user

$(greenprint '6)') + Restore default settings

$(yellowprint '9)') BACK
$(redprint '0)') EXIT

===============================================

Type 1, 2, 3 .. 9 or 0 then press ENTER:  "
    read -r ans
    case $ans in
    1)
        fn_ch_fork
        fn_save
        settingsmenu
        ;;
    2)
        fn_ch_mp3_path
        fn_save
        settingsmenu
        ;;
    3)
        fn_ch_m4a_path
        fn_save
        settingsmenu
        ;;
    4)
        fn_ch_mp4_path
        fn_save
        settingsmenu
        ;;
    5)
        fn_ch_super_user
        fn_save
        settingsmenu
        ;;
    6)
        fn_factory
        fn_pause
        settingsmenu
        ;;
    9)
        mainmenu
        ;;
    0)
        fn_bye
        ;;
    *)
        fn_fail
        ;;
    esac
}

ffmpegmenu() {
    clear
    echo -ne "
===============================================
$(magentaprint '      FFmpeg advanced settings')
===============================================

$(greenprint '1)') + Switch encoding mode
$(greenprint '')   - current $ffmpeg_mode

$(greenprint '2)') + CBR bitrate
$(greenprint '')   - current $ffmpeg_cbr

$(greenprint '3)') + VBR bitrate
$(greenprint '')   - current $ffmpeg_vbr

$(greenprint '4)') + Version

$(yellowprint '9)') BACK
$(redprint '0)') EXIT

===============================================

Type 1, 2, 3 .. 9 or 0 then press ENTER:  "
    read -r ans
    case $ans in
    1)
        fn_ffmpeg_mode
        fn_save
        ffmpegmenu
        ;;
    2)
        fn_ffmpeg_cbr
        fn_save
        ffmpegmenu
        ;;
    3)
        fn_ffmpeg_vbr
        fn_save
        ffmpegmenu
        ;;
    4)
        fn_ffmpeg_ver
        fn_pause
        ffmpegmenu
        ;;
    9)
        mainmenu
        ;;
    0)
        fn_bye
        ;;
    *)
        fn_fail
        ;;
    esac
}

ytdlmenu() {
    clear
    echo -ne "
===============================================
$(magentaprint "      $fork"' advanced settings')
===============================================

$(greenprint '1)') + Select custom audio code
$(greenprint '')   - current $atype

$(greenprint '2)') + Select custom video code
$(greenprint '')   - current $vtype

$(greenprint '3)') + Download as playlist or file
$(greenprint '')   - current $dtype

$(greenprint '4)') + Check for available files
$(greenprint '5)') + Browser ID
$(greenprint '6)') + Version
$(greenprint '7)') + Update (sudo)

$(yellowprint '9)') BACK
$(redprint '0)') EXIT

===============================================

Type 1, 2, 3 .. 9 or 0 then press ENTER:  "
    read -r ans
    case $ans in
    1)
        fn_ytdl_atype
        fn_save
        ytdlmenu
        ;;
    2)
        fn_ytdl_vtype
        fn_save
        ytdlmenu
        ;;
    3)
        fn_ytdl_dtype
        fn_save
        ytdlmenu
        ;;
    4)
        fn_ytdl_che_file
        fn_pause
        ytdlmenu
        ;;
    5)
        fn_ytdl_agent
        fn_pause
        ytdlmenu
        ;;
    6)
        fn_ytdl_ver
        fn_pause
        ytdlmenu
        ;;
    7)
        fn_ytdl_updt
        fn_pause
        ytdlmenu
        ;;
    9)
        mainmenu
        ;;
    0)
        fn_bye
        ;;
    *)
        fn_fail
        ;;
    esac
}

mainmenu() {
    clear
    echo -ne "
===============================================
$(magentaprint '       YT-Starlight (linux edition)')
===============================================

$(greenprint '1)') + Download audio only
$(greenprint '  2)') + Download audio as mp3
$(greenprint '')     - current $ffmpeg_mp3

$(greenprint '3)') + Download video only
$(greenprint '  4)') + Download video with audio
$(greenprint '')     - current $vid_audio

$(greenprint '5)') + $fork settings
$(greenprint '')   - audio code = $atype
$(greenprint '')   - video code = $vtype
$(greenprint '')   - downld type = $dtype

$(greenprint '6)') + FFmpeg settings
$(greenprint '')   - encoding = $ffmpeg_mode
$(greenprint '')   - CBR rate = $ffmpeg_cbr
$(greenprint '')   - VBR rate = $ffmpeg_vbr

$(greenprint '7)') + Settings
$(greenprint '8)') + About

$(redprint '0)') EXIT

===============================================

Type 1, 2 .. 8 or 0 then press ENTER:  "
    read -r ans
    case $ans in
    1)
        fn_downld_audio
        fn_pause
        mainmenu
        ;;
    2)
        fn_ffmpeg_mp3
        fn_save
        mainmenu
        ;;
    3)
        fn_downld_video
        fn_pause
        mainmenu
        ;;
    4)
        fn_vid_audio
        fn_save
        mainmenu
        ;;
    5)
        ytdlmenu
        ;;
    6)
        ffmpegmenu
        ;;
    7)
        settingsmenu
        ;;
    8)
        fn_about
        fn_pause
        mainmenu
        ;;
    0)
        fn_bye
        ;;
    *)
        fn_fail
        ;;
    esac
}

mainmenu
