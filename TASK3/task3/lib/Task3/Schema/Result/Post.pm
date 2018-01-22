package Task3::Schema::Result::Post;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('users');

__PACKAGE__->add_columns(
	id => {
		data_type => 'integer',
		is_auto_increment => 1,
	},
		
	username => {
		data_type => 'text',
	},
	
	password => {
		data_type => 'text',
	},
	
	ia_username => {
		data_type => 'text',
	},
	
	cf_username => {
		data_type => 'text',
	},
	
	cs_username => {
		data_type => 'text',
	},
	
	ac_username => {
		data_type => 'text',
	},
);


__PACKAGE__->set_primary_key('id');
