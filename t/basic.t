use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('PasteBin');
$t->get_ok('/')->status_is(200)->content_like(qr/Mojolicious/i);
$t->post_ok(
'/create' => {Accept => '*/*'} => form => {content => 'foobar', id => 42}
)->status_is(200)->content_like(qr/foobar/i);
$t->get_ok('/show/42')->status_is(200)->content_like(qr/foobar/i);

$t->post_ok(
'/edit' => {Accept => '*/*'} => form => {content => 'baz', id => 42}
)->status_is(200)->content_like(qr/baz/i);
done_testing();
