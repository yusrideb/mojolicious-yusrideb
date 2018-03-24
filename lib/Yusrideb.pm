package Yusrideb;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/' => sub {
    my $c = shift;
    $c->render(template => 'index');
  });
}

1;
