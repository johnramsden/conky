The email-template.pl file constains the config for email. IMAPClient is required and is provided by [```perl-mail-imapclient (AUR)```](https://aur.archlinux.org/packages/perl-mail-imapclient/), "IO::Socket::SSL" module is required and provided by [```perl-io-socket-ssl```](https://www.archlinux.org/packages/extra/any/perl-io-socket-ssl/).

To use images, [```conky-lua (aur)```](https://aur.archlinux.org/packages/conky-lua/) is required.

```
#!/usr/bin/perl

# http://www.unix.com/shell-programming-and-scripting/115322-perl-conky-gmail-imap-unread-message-count.html

# gimap.pl by gxmsgx
# description: get the count of unread messages on imap

use strict;
use Mail::IMAPClient;
use IO::Socket::SSL;

my $username = 'email@tld.com';
my $password = '*********************';

my $socket = IO::Socket::SSL->new(
  PeerAddr => 'mail.messagingengine.com',
  PeerPort => 992
 )
 or die "socket(): $@";

my $client = Mail::IMAPClient->new(
  Socket   => $socket,
  User     => $username,
  Password => $password,
 )
 or die "new(): $@";

if ($client->IsAuthenticated()) {
   my $msgct;

   $client->select("INBOX");
   $msgct = $client->unseen_count||'0';
   print "$msgct\n";
}

$client->logout();
```

Copy or rename it to email.pl and fill in the email and password.

```
my $username = 'email@tld.com';
my $password = '*********************';
```
