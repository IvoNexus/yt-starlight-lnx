# :dizzy: YT-Starlight (linux edition)
This is the release repository for YT-Starlight, an easy to use youtube-dl and ffmpeg add-on for Linux.

## :page_facing_up: Description
This bash script, takes advantage of youtube-dl or any of it's forks and ffmpeg to provide you, with easy to use functionality to download digital assets in various formats, resolutions and bitrates.

## :pill: Version History
* 0.3
    * 25-01-2023 Public Release

## :toolbox: Requirements
* youtube-dl application is required - [GitHub](https://github.com/ytdl-org/youtube-dl) / [Website](https://youtube-dl.org/)
    * yt-dlp - [GitHub](https://github.com/yt-dlp/yt-dlp)
* ffmpeg application is required - [GitHub](https://github.com/FFmpeg/FFmpeg) / [Website](https://ffmpeg.org/)
* Linux OS. (fully tested on Ubuntu Jammy Jellyfish 22.04 LTS and Kinetic Kudu 22.10 )

## :wrench: Installation
* install youtube-dl
    * ``` sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl ```
    * ``` sudo chmod a+rx /usr/local/bin/youtube-dl ```
* install ffmpeg
    * ``` sudo apt-get install ffmpeg ```
* make sure you have ownership and "rwx" permissions on project folder
* make the script file executable ``` sudo chmod u+x ./yt-starlight.sh ```

## :pushpin: Legal Notice
This application was made for testing purposes only and not intended to infringe copyright assets, therefore is compliant with the applicable law. By downloading it end user agrees to take full responsibility of how and where is going to be used and developer cannot be held liable for any loss or damage whatsoever caused by third party actions.

## :pushpin: License 
    Copyright (C) 2021-2023 YT-Starlight

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program. If not, see https://www.gnu.org/licenses/.

## :shield: Security
This application is provided in plain source code, therefore can be easily modified, so some precautions have to be taken in mind:
* Always download from the official release repo/s.
* Always check the [MD5](https://en.wikipedia.org/wiki/MD5) and/or [SHA256](https://en.wikipedia.org/wiki/SHA-2) checksums of downloaded files.
* This application will never ask you for Admin/SU privileges.
    * However to update the fork, super user privileges are required.

Check MD5 and SHA256 checksums via shell:
```
md5sum Example.sh
```
```
sha256sum Example.sh
```

## :pushpin: Credits
I want to express my gratitude to both dev teams of [youtube-dl](https://github.com/ytdl-org/youtube-dl) and [ffmpeg](https://github.com/FFmpeg/FFmpeg) also the entire community, which work so hard to provide us with such amazing tools! Show them love by supporting their projects! Keep up the good work guys!

## :computer: Dev Notes
Let's start with the most obvious question - why starlight, because it's my light at the end of the road. I'm a music freak, I love music, I love to discover new artists and can't live without music. There are two main reasons why I created [Starlight](https://github.com/IvoNexus/yt-starlight-lnx), I travel to remote areas where internet it's not available at all time, I know most streaming platforms provide an option for offline use well, yes and no, because some of them need verification from time to time, so I decided to take control in my hands. The second reason, most of the artists I listen are not that popular and are all over the place, put the subscription plans aside, I don't want to use 5 different platforms/applications to do the same thing, so here we are - I unify it.

**Thank you for taking the time to read! Enjoy!** 
