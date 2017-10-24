package PasteBin::DB::Storable;
use Mojo::Base -base;
use Mojo::File 'path';
use Storable qw(lock_store lock_nstore lock_retrieve);
use constant DB_FILE => '/tmp/data';
has dbfile => DB_FILE;
has '_data';
has _root => sub {'1'};

sub bucket {
  my $self  = shift;
  my $bucket = shift;
  __PACKAGE__->new(_root=>$bucket, dbfile=>$self->dbfile );
}

*buckets = \&keys;
*list = \&keys;

sub get {
  my $self  = shift;
  $self->retrieve;
  $self->_data->{$self->_root}->{$_[0]};
}

sub keys {
  my $self  = shift;
  $self->retrieve;
  keys %{  $self->_data->{$self->_root} };
}

sub set {
  my $self = shift;
  $self->retrieve;
  $self->_data->{$self->_root}->{$_[0]} = $_[1];
  $self->save;
  $self;
}

sub _init {
  return shift if -e $_[0]->dbfile;
  $_[0]->_data({});
  shift->save
}

sub save {
  local $@;
  eval { lock_store $_[0]->_data, path( $_[0]->dbfile )};
  warn $@ if $@;
  shift
}

sub retrieve {
  $_[0]->_init;
  local $@;
  eval { $_[0]->_data(lock_retrieve( path( $_[0]->dbfile  ))) };
  warn $@ if $@;
  shift
}

!!42;
