package Task3::Login;
use Mojo::Base 'Mojolicious::Controller';
use DBIx::Simple;
use Data::Dumper;
use lib 'lib';
use Task3::Schema::Schema;

# mocked function to check the correctness of username and password combinatiom

sub user_exists {
	my ($username, $password, $self) = @_;
	my $db = DBI->connect('DBI:Pg:dbname=users;host=localhost;port=5432', 'camihanes', 'password');
	my $table = 'SELECT * FROM logins WHERE username=?';
	my $sth = $db->prepare($table);
	$sth->execute($username);
	
	my $res = $sth->fetchrow_hashref();
	my $pass = $res->{password};
	if ( $pass eq $password ){ return 1;}
	return 0;
}

# called upon from submit

sub is_logged_in {
	my $self = shift;
	return 1 if $self->session('logged_in');
	$self->render(
        inline => "<h2>Forbidden</h2><p>You're not logged in. <%= link_to 'Go to login page.' => 'login_form' %>",
        status => 403
    );

}

sub on_user_login {
	my $self = shift;
	
	# grab the request parameters
	my $username = $self->param('username');
	my $password = $self->param('password');
		
	
	if (user_exists($username, $password, $self)){
		my $here = 'here';
		say $here;		
		$self->session(logged_in => 1);
		$self->session(username => $username);

		my $db = DBI->connect('DBI:Pg:dbname=users;host=localhost;port=5432', 'camihanes', 'password');
        	my $table = 'SELECT * FROM logins WHERE username=?';
        	my $sth = $db->prepare($table);
        	$sth->execute($username);
        	my $res = $sth->fetchrow_hashref();	
		$self->session(ia_username => $res->{ia_username});
		$self->session(cf_username => $res->{cf_username});
		$self->session(cs_username => $res->{cs_username});
		$self->session(ac_username => $res->{ac_username});

		$self->redirect_to('restricted_area');
	} else {
	$self->render(text => 'Wrong username or password!', status => 403);
	}
}


1;
