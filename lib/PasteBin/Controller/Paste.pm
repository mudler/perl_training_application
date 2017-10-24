package PasteBin::Controller::Paste;
use Mojo::Base 'Mojolicious::Controller';
use PasteBin::DB::Storable;
use Mojo::Template;

has 'DB' => sub { PasteBin::DB::Storable->new()->bucket('paste') };
# This action will render a template
sub create {
  my $self = shift;
  my @chars = ("A".."Z", "a".."z", 1..9);
  my $id = $self->param('id');
  my $content = $self->param('content');

  $id = 0 + $id <= 0 ? (join '' => map $chars[rand @chars], 1 .. 8) : $id;

  $self->DB->set($id,$content);
  $self->redirect_to("show/$id");
}

sub show {
  my $self = shift;
  my $paste = $self->param('id');
  my $data = $self->DB->get($paste);
  $self->render('show.pm', text => $data ? $data : "<b>Sorry… Paste called $paste not found!</b>");
}

!!42;
