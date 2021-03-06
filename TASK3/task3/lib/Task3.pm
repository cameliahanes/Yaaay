package Task3;
use Mojo::Base 'Mojolicious';
#use Mojo::Pg;

# This method will run once at server start
sub startup {
  my $self = shift;
  $self->plugin('PODRenderer');
  $self->secrets(['This secret is used for new sessionsLeYTmFPhw3q',
        'This secret is used _only_ for validation QrPTZhWJmqCjyGZmguK']);

  $self->app->sessions->cookie_name('task3');  
  $self->app->sessions->default_expiration('36000');

  # Router
  my $r = $self->routes;
	
  # Normal route to controller
  $r->get('/')->to(template => 'main/index');

  # login
  $r->get('/login')->name('login_form')->to(template => 'login/login_form' );
  $r->post('/login')->name('do_login')->to('Login#on_user_login');

  # restricted
  my $authorized = $r->under('/admin')->to('Login#is_logged_in');
  $authorized->get('/')->name('restricted_area')->to(template => 'admin/overview');
  $authorized->get('/update')->name('view_accounts')->to(template => 'admin/view_accounts');
  $authorized->post('/update')->name('do_update')->to( 'Admin#on_update');
  # post from tutorial
  $authorized->get('/create')->name('create_post')->to(template => 'admin/create_post');
  $authorized->post('/create')->name('publish_post')->to('Post#create');

  # logout
  $r->route('/logout')->name('do_logout')->to( cb => sub {
		my $self = shift;
		$self->session(expires => 1);
		# return to index
		$self->redirect_to('/');
});
}

1;
