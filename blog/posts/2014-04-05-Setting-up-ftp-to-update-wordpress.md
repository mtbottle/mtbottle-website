---
title: Setting up ftp to update wordpress
---
So, I guess I've had this blog for a while, but only decided to do real maintainance now (partly because I'm bored from being funemployed, but also to ramp up on system admin skills that are getting rusty). This will be a journal entry to how I set up the FTP so that I could update the wordpress on this very blog.
<!--more-->
The tutorial could not have been accomplished without the help of <a href="https://help.ubuntu.com/10.04/serverguide/ftp-server.html">Ubuntu's FTP Server setup</a>.

To start out, my Ubuntu installation did not have ftp installed. While researching this, I found that I could also set up wordpress to update from ssh as well. However, since I have never used ftp over linux (because sftp is good enough for me), I decided to try installing ftp. You install the ftp service with :
<blockquote><code>sudo apt-get install vsftpd</code></blockquote>
I added a new ftp-user so that I didn't have to give wordpress its own restricted user account.
<blockquote><code>sudo passwd ftp-user</code></blockquote>
I also had to make sure that the ftp-user's root directory was the wordpress installation (so that it knew where to install the update).
<blockquote><code>sudo usermod -d /somewhere/somewhere/wordpress ftp-user</code></blockquote>
Then I opened /etc/vsftpd.conf and uncommented the following line (according to the ubuntu tutorial which I linked) :
<blockquote><code>local_enable=YES
write_enable=YES
</code></blockquote>
<b>TROUBLESHOOT :</b> Also, for some reason ftp doesn't work if the ftp user's chroot directory has user-level write permissions. So after an odious amount of time googling I solved that by running
<blockquote><code>sudo chmod a-w /somewhere/somewhere/wordpress/</code></blockquote>
(sorry, can't cite where I found this as I closed the tab, and in fact, I don't quite understand how this works either)

Then I restarted the server with this command for ubuntu:
<blockquote><code>sudo service vsftpd restart</code></blockquote>
PS. For those who are oldschool (and don't have <a href="http://linux.die.net/man/8/service">service</a> installed), can also restart the ftp server with :
<blockquote><code>sudo /etc/init.d/vsftpd restart</code></blockquote>


