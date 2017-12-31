use v5.22;
use strict;
use warnings;
use List::Util qw(pairs);

my %users;

sub load_logins {
        my $filename = 'logins.txt';
        open (my $fh, '<:encoding(UTF-8)', $filename)
                or die "Could not open logins file!\n";

        while (my $row = <$fh>){
                chomp($row);
                $row =~ s/\]\[/#/g;
                $row =~ s/^\[//g;
                $row =~ s/\]$//g;
                (my $username, my $passwd) = split("#", $row);
                $users{$username} = $passwd;
	}
	close $fh;
}

sub update_logins_file{
	my $filename = 'logins.txt';
	open (my $fh, '>:encoding(UTF-8)', $filename)
		or die "Could not open file for saving current state...\n";
	for my $user_key (keys %users){
		print $fh "[$user_key][$users{$user_key}]\n";
	}
	close $fh;
}

sub username_login {
	print "Enter username: ";
	my $username = <stdin>;
	chomp ($username);
	return $username;
}

sub password_login {
	print "Enter password: ";
	my $passwd = <stdin>;
	chomp ($passwd);
	return $passwd;
}

sub login {
	my $logged_in = 0;
	my $username = username_login;
	my $passwd = password_login;
	if (exists $users{$username}){
		if ($users{$username} eq $passwd){
			$logged_in = 1;		
		}
	}
	return $logged_in;
}

sub read_add_username {
	say "Type -1 to discard creating new user / enter username\n";
	my $my_username = <stdin>;
	chomp($my_username);
	return $my_username;
}

sub read_add_password {
	say "Type -1 to discard creating new user / enter password \n";
	my $my_passwd = <stdin>;
	chomp($my_passwd);
	return $my_passwd;
}

sub valid_username {
	if (exists $users{$_[0]}){
		return 0;
	}
	if (not $_[0] =~ m/^[a-zA-Z]/){ 
		return 0;
	}
	if ($_[0] =~ m/\W/){
		return 0;
	}
	return 1;
}

sub valid_password{
	if (length $_[0] lt 6) {
		return 0;
	}
	if (not $_[0] =~ m/[a-b]/){
		return 0;
	}
	if (not $_[0] =~ m/[A-B]/){
		return 0;
	}
	if (not $_[0] =~ m/[0-9]/){
		return 0;
	}
	return 1;
}

sub add_user {
	my $username = read_add_username;
	my $passwd = read_add_password;
	if (valid_username($username) and valid_username($passwd)){
		$users{$username} = $passwd;
		update_logins_file;
		return 1;
	} else {
		return 0;
	}
}

sub run{
	load_logins;
	while (1){
	say "Do you want to login? [y/n] ";
	my $answer = <>;
	if ($answer =~ m/^n/i){
		exit;
	}

	my $logged_in = login;
	if ($logged_in eq 0){
		say "Incorrect username or password...\n";
	} else {
		while (1){
			say "Do you want to add a new user? [y/n] ";
			my $ans = <>;
			if ($ans =~ m/^y/i){
				my $added_user = add_user;
				if ($added_user eq 0){
					say "Something must have gone wrong...\n";
					say "The username must start with a character and it can contain lowercase and uppercase letters, digits and underscore\n";
					say "The password must contain an uppercase character, a lowercase character and a digit and must have a length of at least 6 characters...\n";
				}
			} else {
			say "Do you want to log out? [y/n] ";
			my $ans = <>;
			if ($ans =~ m/^y/i){
				last;
			}}
		}
	}
	}
}


run;
