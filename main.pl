#!/usr/bin/env perl
use Mojolicious::Lite;

get '/' => sub {
  my $c = shift;
  $c->render(text => 'Mojolicious Perl running on App Engine Flexible!');
};

get '/about' => sub {
  my $c = shift;
  $c->render(text => 'This apps is example Mojolicious Apps');
};

get '/page1' => sub {
  my $c = shift;
  $c->render(text => 'Page1 ');
};

app->start;
