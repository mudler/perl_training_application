package PasteBin;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by "my_app.conf"
  my $config = $self->plugin('Config');

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer') if $config->{perldoc};

  # Router
  my $r = $self->routes;

  # Normal route to controller
<<<<<<< HEAD
  $r->get('/')->to('paste#new');

  $r->post('/create')->to('paste#create');
  $r->post('/edit')->to('paste#create');
  $r->get('/show/:id')->to('paste#show');
=======
  $r->post('/pastebin/:id')->to('paste#save');
  $r->get('/pastebin/:id')->to('paste#show');
  $r->get('/')->to('paste#create');
>>>>>>> Paste bin using same url with get and post
}

1;
