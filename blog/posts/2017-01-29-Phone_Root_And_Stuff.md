---
title: Rooting Nexus S Phone with Replicant
tags: foss, technology
---

I've been meaning to cut down on my dependencies on Google products.
Considering how Google's management is appealing to 
[Dear Leader (Donald Trump)](https://www.nytimes.com/2017/01/27/technology/google-in-post-obama-era-aggressively-woos-republicans.html),
getting off of stock Android is becoming more urgent.
On top of that, I've been getting annoyed with not being able to uninstall Google native apps, 
which is just using up disk space and resources.

Since this was my first time rooting and installing a new phone OS, 
I didn't want to experiment with my everyday phone.
So I got a hold of my old Nexus S, and decided to play around on that.

*Note:* Most of the instructions to install Replicant can be found
[here](http://redmine.replicant.us/projects/replicant/wiki/NexusSI902xInstallation).

## Rooting the Nexus S

First thing that I have to do to root the phone is unlock it's bootloader.
To do that, I need to first get to the bootloader screen on the phone.
You can do that by holding both the power and volume up buttons 
when turning on your phone.
Then connect the device to the computer.

On the computer, there should be the `fastboot` command which comes with the android-sdk.
To unlock the bootloader, type in 

``fastboot oem unlock``

Then the phone screen should change and warn about unauthorized access and voiding warranty.
Since this is an old phone which is past any warranty (plus I got it second hand, without transfer of any warranty),
that is no problem and I selected "yes".
I have now successfully rooted the phone.

Although I have rooted the phone, I now need to install certain tools which lets me use 
the applications as root user. 
This can be dangerous as using these tools that lets you access root
usually involves installing an unauthorized app 
which may or may not be compromised.
For example, you can try to use the [_Superuser_ app](https://play.google.com/store/apps/details?id=com.noshufou.android.su), 
if you want to keep the base Android image.
However, that involves finding a trusted version of the _Superuser_ app,
which does not have a working website nor SHA1/MD5 sums to check against.
Since I wanted to get away from the bloat of Google apps anyways,
it made sense for me to look into alternatives to stock Android altogether.

## What is Replicant

The most popular Android alternative is CyanogenMod. 
However, the company is going through a rebrand and their images were not working.
Replicant, however is a completely FOSS-based alternative to CyanogenMod 
(and I think they are based on the CyanogenMod image).
Being 100% FOSS based comes with some downsides.
For example, the distribution comes with no proprietary driver code.
This meant that things like Broadcom network cards 
(which happens to be what the Nexus S has to connect to wifi)
will not work straight out of the box.
I managed to get the wifi on my phone working with some hacks, 
but I will talk about that later.

## Installing Replicant

So now that I've rooted my phone, I can now start the process of installing Replicant. 

First download the system image and recovery image associated with the device.
The download links can be found [here](http://redmine.replicant.us/projects/replicant/wiki/ReplicantImages).
Then validate that the SHA1 and MD5 hashes match.
If they don't match, don't install!

To do the installation, we want to be able to access some custom boot commands.
These custom commands are provided with the recovery image 
that comes with the image. 
To run them, I would need to flash the recovery image,
so that it will boot into those custom commands.

``fastboot flash recovery path/to/recovery.img``

Then on the phone, select the "recovery" mode on the bootmenu.
This will load up the recovery image where you can access the extra installation commands.

Since my device was connected to a computer that was already running adb,
I've decided to install it via sideloading.
This just basically mean that I am installing this outside of the official Android Market
(ie. installing it through USB connection on my machine).
First, select the option to install via sideload from the recovery menu,
then on your computer via adb, 

``adb sideload path/to/[REPLICANT_SYSTEM_IMAGE].zip``

This step will take a while because it is transferring the image 
and also doing the installation.
After this is complete, go back to the main menu and select to wipe and factory reset the device.
Then select to reboot the phone, and it should be running Replicant!


## Fixing the WIFIs

As mentioned, Replicant does not come with the Wireless card drivers 
because it is not in the spirit of FOSS. 
I've considered just letting the phone not connect to the wifi, ever.
However in the end, 
I've decided that I should just "fix" this situation.

The very proper way to do this is probably to recompile Replicant with the proper drivers.
However, since the drivers are already in CyanogenMod's images,
it might be easier to just grab the drivers from that 
and copy them onto the phone.

As mentioned before, CyanogenMod is going through "reorg",
so none of their image links were working, but their website was!
So I just did a search for the Nexus S image and downloaded it via a mirror.
Then I compared the SHA1 has with the one on the CyanogenMod's website. 

I then used that image and extracted the drivers with
[cm-firmwares](http://git.paulk.fr/gitweb/?p=cm-firmwares.git), 
which provides a script to get the drivers for the phone of a specified model.

One problem I ran into with the script was that I couldn't find the exact image specified.
Instead, I managed to get a newer image of CyanogenMod for the Nexus S,
and checked to make sure that the corresponding driver files existed.
I figured that phone drivers were unlikely to change often
and successfully extracted the driver files onto my device.
The wifi card worked immediately without restarting.

## Done!

So that is all with the installation.
I'm decently happy with running Replicant on my secondary phone.
I might also try installing an Android alternative on my Nexus 5 one day
(not Replicant at the moment, no supported image).

