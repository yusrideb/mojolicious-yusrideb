#!/usr/bin/env perl6

use v6;
use lib:from<Perl5> 'lib';
use Mojolicious::Commands:from<Perl5>;

# Start command line interface for application
Mojolicious::Commands.start_app('Yusrideb');