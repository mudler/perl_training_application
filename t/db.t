use Test::More;
use lib 'lib';
use PasteBin::DB::Storable;
use Mojo::File 'tempfile';
my $obj = PasteBin::DB::Storable->new( dbfile => tempfile() );
my $foo_bucket = $obj->bucket('foo');
$foo_bucket->set('test','foo');
$foo_bucket->set('foo','bar');

is $foo_bucket->get('test'), 'foo';
ok grep { /foo/ } $foo_bucket->keys;
ok grep { /test/ } $foo_bucket->keys;

$foo_bucket->remove('test');
ok(!(grep { /test/ } $foo_bucket->keys)) or diag explain $foo_bucket;

$foo_bucket->retrieve;
diag explain $foo_bucket;
done_testing();;
