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
  my $appdir = $config->{appdir};
  my $homedir = $self->app->home;

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

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');
  
  # Mouting other mojolicious apps :
  $self->plugin(Mount => {'/app1' => $homedir . '/app/App1' });
  $self->plugin(Mount => {'/app2' => $homedir . '/app/App2' });
  
  $self->plugin(AssetPack =>
    { pipes => [qw(Less Css CoffeeScript Riotjs JavaScript Combine)] });
  $self->content( Mojo::Asset::Memory->new );
  
  # -> read assets/assetpack.def
  $self->asset->process;
  
  $self->secrets([
    'PHzxQj5WzmULjhVd4TojMNlzYg7YtjWOfxVt6WsmCNrnWd8Elf7',
    'CAjlGt1LxaEVlcJf6BbrTHurGs5CbuGEeoOb2DpnBTmoAs5Vbs9'
  ]);
  
  # Router
  my $r = $self->routes;
  
  # Normal route to controller
  $r->get('/' => sub {
    my $c = shift;
    
    $c->res->code(200);
    $c->res->headers->content_type('text/html');
    $c->render(template => 'index', gzip => 1);
  })->name('index');
  
  # Normal route to controller
  $r->get('/home' => sub {
    my $c = shift;
    
    $c->render(template => 'index', gzip => 1);
  })->name('page_home');
  
  # Normal route to controller
  $r->get('/homepage' => sub {
    my $c = shift;
    
    $c->render(template => 'index', gzip => 1);
  })->name('page_home_alias1');
  
  # Normal route to controller
  $r->get('/dashboard' => sub {
    my $c = shift;
    
    $c->render(template => 'index', gzip => 1);
  })->name('page_home_alias2');
  
  # Normal route to controller
  $r->get('/index.html.var' => sub {
    my $c = shift;
    
    $c->res->code(200);
    $c->res->headers->content_type('text/html');
    $c->render(template => 'index', gzip => 1);
  })->name('page_home_redirect1');
  
  # Normal route to controller
  $r->get('/406.shtml' => sub {
    my $c = shift;

    $c->render(template => '406');
  })->name('page_home_redirect1');
}

1;
