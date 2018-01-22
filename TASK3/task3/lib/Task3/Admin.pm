package Task3::Admin;
use Mojo::Base 'Mojolicious::Controller';
use DBIx::Simple;

sub on_update {
	my $self = shift;
	
	say $self->session->{username};
	my $ia_initial = $self->session->{ia_username};
	my $cf_initial = $self->session->{cf_username};
	my $cs_initial = $self->session->{cs_username};
	my $ac_initial = $self->session->{ac_username};

	my $username = $self->session->{username};

	my $ia_username = $self->param('infoarena');
	my $cf_username = $self->param('codeforces');
	my $cs_username = $self->param('csacademy');
	my $ac_username = $self->param('atcoder');

	if (not $ia_initial eq '' || $ia_username eq ''){ $ia_username = $ia_initial; }
	if (not $cf_initial eq '' || $cf_username eq ''){ $cf_username = $cf_initial; }
	if (not $cs_initial eq '' || $cs_username eq ''){ $cs_username = $cs_initial; }
	if (not $ac_initial eq '' || $ac_username eq ''){ $ac_username = $ac_initial; }
	say $cf_username;

	my $db = DBI->connect('DBI:Pg:dbname=users;host=localhost;port=5432', 'camihanes', 'password');
        $db->do('UPDATE logins SET ia_username=?, cf_username=?, cs_username=?, ac_username=? WHERE username=?', undef, $ia_username, $cf_username, $cs_username, $ac_username, $username);
        $self->session(ia_username => $ia_username);
	$self->session(cf_username => $cf_username);
	$self->session(cs_username => $cs_username);
	$self->session(ac_username => $ac_username);
	$self->redirect_to('view_accounts');

}


1;
