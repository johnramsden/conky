#!/usr/bin/perl

# http://www.unix.com/shell-programming-and-scripting/115322-perl-conky-gmail-imap-unread-message-count.html

# gimap.pl by gxmsgx
# description: get the count of unread messages on imap

# Fill in email/password.

use strict;
use Mail::IMAPClient;
use IO::Socket::SSL;

my $username = '';
my $password = '';

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
