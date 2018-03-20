#!/usr/bin/env perl
use Mojolicious::Lite;

get '/' => sub {
  my $c = shift;
  $c->render(text => 'Perl running on App Engine Flexible!');
};

get '/about' => sub {
  my $c = shift;
  $c->render(text => 'This apps is example Mojolicious Apps');
};

app->start;
