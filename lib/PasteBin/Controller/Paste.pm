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
  # Create id if not defined
  $id = $id ? $id : (join '' => map $chars[rand @chars], 1 .. 8);

  $self->DB->set($id,$content);
  $self->redirect_to("/pastebin/$id");
}

sub show {
  my $self = shift;
  my $id = $self->param('id');
  my $data = $self->DB->get($id);

  $self->render(template => 'pastebin', id => $id, content => $data  ? $data : "Sorry… Paste trash called $id not found!");
}

!!42;
