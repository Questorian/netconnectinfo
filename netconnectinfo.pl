#!/usr/bin/env perl

use strict;
use warnings;

use 5.012;    # turns on strictures with Perl 5.12
use LWP::Simple;

# my $url = 'http://www.questorsystems.com/cgi-bin/showip.pl';
my $url = 'http://www.netconnectinfo.com/raw';

my $ip = get($url);

say $ip;

