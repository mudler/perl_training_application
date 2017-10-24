package PasteBin::Controller::Paste;
use Mojo::Base 'Mojolicious::Controller';
use PasteBin::DB::Storable;

has 'DB' => sub { PasteBin::DB::Storable->new()->bucket('paste') };
# This action will render a template
sub create {
  my $self = shift;
  my $paste = $self->param('id');
  my $content = $self->param('content');
  $self->DB->set($paste,$content);
  $self->render(text => $self->DB->get($paste) );
}

sub show {
  my $self = shift;
  my $paste = $self->param('id');
  $self->render(text => $self->DB->get($paste) );
}

!!42;
