---
title: New Year's Reinstallation
---

I have recently become more interested in better security practices. Since my harddrive was unencrypted, this was definitely the motivation to reformatting my computer. Also since I travel a lot, I would be more prone to losing my laptop, which means that anyone who gets access to my laptop would be able to get [important] files that I have stored on it.

Even aside from security, my ubuntu install was already getting bloated with all the development packages that I had to install and I was ready for a fresh clean start.

This blog entry is to make notes of the tweaks that I had to do get install a "standard" debian image with xmonad tiling windows manager. I am installing this on a Lenovo Thinkpad T420s laptop.

<!--more-->

## Xmonad and TWM (Tiling Windows Managers)
I have been interested to switching to a tiling windows manager for about a year. TWMs are alternatives to desktop environments (like gnome, kde, xfce... etc) and stacking windows manager (like fluxbox, lwm... etc). I had been using gnome from 2009 to 2014 then switched to fluxbox in 2014 to present. The main reason for switching to fluxbox was because gnome at startup was using up about 1Gb of memory, I needed to run a server that was going to use up 3Gb and had only 4Gb of RAM. This resulted in lots of out of memory crashes and I couldn't get my job done. Although I was decently happy with fluxbox, I felt like productivity could be improved if I wasn't constantly resizing my windows (and fluxbox's way to manually set these was somewhat buggy for me). Additionally, I also knew a few people who are already using TWM, and I was intrigued by learning a new paradigm. This is what inevitably led me to switching to a TWM.

The reasons to switch to a tiling windows manager all comes down to personal preferences. For me they were:

- I wanted to become less dependent on using a mouse because it is inconvenient on a laptop. 
- Tend to use less resources than desktop environments.
- Using keyboard shortcuts for everything improves productivity and speed.
- And I wanted something minimal (I *hate* fancy graphical effects on my desktop).

Other tiling windows manager I've considered where i3 and dwm. I decided to go with xmonad because the configurations are in haskell (and I am learning haskell!). [Here](https://wiki.archlinux.org/index.php/Comparison_of_tiling_window_managers) is an exhaustive comparison of the different types of tiling windows managers out there.

Because I was installing this from a clean debian image, there are some things I have to add to make using my computer somewhat pleasant. The barebone xmonad configurations will give an empty screen without any clutter (ie. no icons). However this also meant that there was no convenient graphical interface to do things like adjust sound volume or network manager to connect to wifi hotspots. In fact, neither sound nor wireless network control was installed at all by the standard debian installation. So here are some notes about what extras I had to add to have a decently functional machine.

### Login and Authentication
Since I installed debian with an encrypted harddive, my unencrypt key can technically be part of startup authentication since it is a password that I have to enter before I get access to my machine. However I still installed slim to deal with signing in at startup anyways. The usecase was that I could switch to a different user or windows manager if I decided to add either. I installed [SliM](https://wiki.archlinux.org/index.php/SLiM) to deal with login management.

Since there is no handy lockscreen mechanism in my minimal setup, I set up xscreensaver to enable this. Xscreensaver runs as a daemon on startup (by adding it to my .xsession file). To add lock screen, I had to add keybinding to xmonad to call "xscreensaver-command -lock".

### WIFI
Unfortunately debian does [not support](https://www.debian.org/doc/debian-policy/ch-archive.html) my Intel chip wireless card straight out of the box. I had to manually install [iwlwifi](https://wiki.debian.org/iwlwifi) to add support for the card. Since I did not want to configure my wifi via my /etc/network/interfaces file (I know some hardcore people who do that), I installed [wicd](https://wiki.archlinux.org/index.php/Wicd) which is a lightweight graphical network management interface.

### Sound
Fortunately my sound card did not require any configuration. To interface with it, I installed amixer and alsamixer. The volume buttons on my Thinkpad was not configured, so I added some keybindings to xmonad. The commands to toggle to volume were:

    amixer sset Master 1-
    amixer sset Master 1+

In addition to configuring the soundcard, I also had to install a music player. The one that I had installed was Clementine. It is a decent music client, but I wanted the challenge of using one with a command line interface. So I decided to install and [mpd](http://www.musicpd.org/) server with [ncmpcpp](https://wiki.archlinux.org/index.php/Ncmpcpp) user interface.

Mpd was a pain to set up because of very strict permissions. It is a daemon that sets up a server on your music directory that lets you connect your client (ncmpcpp in this case) to play music. The daemon runs as mpd user and audio group, which means that your files must at least haveglobal read permissions. So if your files don't show up in the server, then it is likely a permissions problem!

### Battery Indicator
The last thing that I needed was a battery indicator. Without this, I would have to depend in my thinkpad's annoying beeping to indicate when I have to plug in my laptop (not ideal...). I chose [xbattbar](http://iplab.aist-nara.ac.jp/member/suguru/xbattbar.html) because of how lightweight it was (admittedly I had already used it for fluxbox). It is fairly simple to set up; I added it in my .xsession file to run in the background.

## Final Thoughts
I overestimated the time I would have needed to get comfortable using a TWM and configuring all the necessary things stated. This reinstallation was more of an exercise to learn more about the linux environment and to create a more efficient workflow for programming. I managed to finish configuring most things in one day (internet, sound, configuring xmonad, battery, custom shell and text editor). Mpd took me about half a day to configure. All in all, it took me about 2 days to configure and I am decently used to working with it.
