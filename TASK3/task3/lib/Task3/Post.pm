package Task3::Post;
use Mojo::Base 'Mojolicious::Controller';
use DateTime;

sub create {
	my $self = shift;
	
	# grab the request parameters
	my $title = $self->param('title');
	my $content = $self->param('content');
}
