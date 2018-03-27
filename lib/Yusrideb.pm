package Yusrideb;
use Mojo::Base 'Mojolicious';

use IO::Compress::Gzip 'gzip';

# ABSTRACT: Main Module Application
our $VERSION = '0.1000';

# This method will run once at server start
sub startup {
  my $self = shift;
  
  $self->plugin('Config' => {file => 'myapp.stuff'});
  my $config = $self->config;
  my $domain = $config->{mydomain};
  
#  $self->hook(before_dispatch => sub {
#    my $c = shift;
#    my $request_url = $c->req->url->to_abs;
#    my $host = $c->req->url->to_abs->host;
#    my $path = $c->req->url->path_query;
#    if ($c->req->url->protocol eq 'http') {
#      $request_url->scheme('https');
#      $self->app->log->info($domain);
#      $self->app->log->info('Request Schema : '.$request_url->scheme);
#      $self->app->log->info('Request URL : '.$request_url);
#      my $r_req = $request_url->scheme.'://'.$domain.$path;
##      $self->app->log->info($r_req);
#      $self->app->log->info('Request URI : '.$path);
#      $self->app->log->info('Result URL : '.$r_req);
#      $c->redirect_to($r_req);
#    }
#  });
  
  $self->hook(before_dispatch => sub {
    my $c = shift;
    my $request_url = $c->req->url->to_abs;
    if ($request_url->scheme eq 'http') {
      $request_url->scheme('https');
      my $u = $request_url->to_string;
      $c->redirect_to($u);
    }
  });
  
  $self->hook(after_render => sub {
    my ($c, $output, $format) = @_;
    
    # Check if "gzip => 1" has been set in the stash
    return unless $c->stash->{gzip};
    
    # Check if user agent accepts GZip compression
    return unless ($c->req->headers->accept_encoding // '') =~ /gzip/i;
    $c->res->headers->append(Vary => 'Accept-Encoding');
    
    # Compress content with GZip
    $c->res->headers->content_encoding('gzip');
    gzip $output, \my $compressed;
    $$output = $compressed;
  });
  
  # Router
  my $r = $self->routes;
  
  # Normal route to controller
  $r->get('/' => sub {
    my $c = shift;
    $c->render(template => 'index', gzip => 1);
  });
}

1;
