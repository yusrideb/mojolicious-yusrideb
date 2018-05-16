package Yusrideb;
use Mojo::Base 'Mojolicious';

use IO::Compress::Gzip 'gzip';

# ABSTRACT: Main Module Application
our $VERSION = '0.1000';

# This method will run once at server start
sub startup {
  my $self = shift;
  
  $ENV{MOJO_REVERSE_PROXY} = 1;
  
  $self->plugin('Config' => {file => 'app.conf'});
  my $config = $self->config;
  my $domain = $config->{mydomain};
  
#  $self->hook(before_dispatch => sub {
#    my $c = shift;
#    my $request_url = $c->req->url->to_abs;
#    my $host = $c->req->url->to_abs->host;
#    my $path = $c->req->url->path_query;
#    if ($request_url->scheme eq 'http') {
#      $request_url->scheme('https');
#      $self->app->log->info($domain);
#      $self->app->log->info('Request Schema : '.$request_url->scheme);
#      $self->app->log->info('Request URL : '.$request_url);
#      my $r_req = $request_url->scheme.'://'.$domain.$path;
#      $self->app->log->info('Request URI : '.$path);
#      $self->app->log->info('Result URL : '.$r_req);
#      $c->redirect_to($r_req);
#    }
#  });

#  $self->hook(after_dispatch => sub {
#    my $c = shift;
#    my $request_url = $c->req->url->to_abs;
#    if ($request_url->scheme eq 'http') {
#      $request_url->scheme('https');
#      $request_url->host($domain);
#      $self->app->log->info($domain);
#      my $u = $request_url->to_string;
#      $self->app->log->info($u);
#      $u =~ s/\:([\d]+)//g;
#      $self->app->log->info($u);
#      $c->redirect_to($u);
#    }
#  });

#  $self->hook(before_dispatch => sub {
#    my $c = shift;
#    $c->req->url->base->scheme('https')
#      if $c->req->headers->header('X-Forwarded-HTTPS');
#  });
  
#  $self->hook(after_render => sub {
#    my ($c, $output, $format) = @_;
#
#    # Check if "gzip => 1" has been set in the stash
#    return unless $c->stash->{gzip};
#
#    # Check if user agent accepts GZip compression
#    return unless ($c->req->headers->accept_encoding // '') =~ /gzip/i;
#    $c->res->headers->append(Vary => 'Accept-Encoding');
#
#    # Compress content with GZip
#    $c->res->headers->content_encoding('gzip');
#    gzip $output, \my $compressed;
#    $$output = $compressed;
#  });

  # Router
  my $r = $self->routes;
  
  # Normal route to controller
  $r->get('/' => sub {
    my $c = shift;
    
    # [EXPERIMENTAL] Server Name Header :
    # $c->res->headers->header('Server' => 'Mojolicious');
  
    # Security :
    # $c->res->headers->header('X-Content-Security-Policy' => "default-src 'self'");
    # $c->res->headers->header('X-Content-Type-Options' => 'nosniff');
    # $c->res->headers->header('X-XSS-Protection' => "1; 'mode=block'");
    # $c->res->headers->header('X-Frame-Options' => 'DENY');
  
    $c->res->code(301);
    $c->redirect_to('page_home');
  })->name('index');
  
  # Normal route to controller
  $r->get('/home' => sub {
    my $c = shift;
  
    # [EXPERIMENTAL] Server Name Header :
    # $c->res->headers->header('Server' => 'Mojolicious');
  
    # Security :
    $c->res->headers->header('X-Content-Security-Policy' => "default-src 'self'");
    $c->res->headers->header('X-Content-Type-Options' => 'nosniff');
    $c->res->headers->header('X-XSS-Protection' => "1; 'mode=block'");
    $c->res->headers->header('X-Frame-Options' => 'DENY');
    
    $c->render(template => 'index', gzip => 1);
  })->name('page_home');
  
  # Normal route to controller
  #  $r->get('/index.html' => sub {
  #    my $c = shift;
  #    $c->render(template => 'index', gzip => 1);
  #  })->name('page_home_alias1');
  
  # Normal route to controller
  #  $r->get('/406.shtml' => sub {
  #    my $c = shift;
  #    $c->render(template => 'index', gzip => 1);
  #  })->name('page_home_alias2');
}

1;
