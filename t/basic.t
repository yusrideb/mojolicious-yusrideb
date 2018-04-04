use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('Yusrideb');
$t->get_ok('/home')->status_is(200)->text_like('title' => qr/Yusri/);

done_testing();
