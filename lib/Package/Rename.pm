package Package::Rename;

use strict;
no strict 'refs';
use warnings;
use Carp;

use base 'Exporter';
use vars qw/@EXPORT_OK/;
@EXPORT_OK = qw/copy_package remove_package rename_package/;

our $VERSION = '0.01';

*_method_changed = $] >= 5.009 ? \&mro::method_changed_in : sub { };

sub copy_package {
	my ($old_name, $new_name) = @_;
	%{"$new_name\::"} = %{"$old_name\::"};
	return;
}

sub remove_package {
	my ($old_name) = @_;
	_method_changed($old_name);
	undef %{"$old_name\::"};
	return;
}

sub rename_package {
	my ($old_name, $new_name) = @_;
	copy_package($old_name, $new_name);
	remove_package($old_name);
	_method_changed($new_name);
	return;
}

1;    # End of Package::Rename

__END__

=head1 NAME

Package::Rename - Rename or copy package

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

This module allows you to rename, copy or even remove packages from the perl namespace.

=head1 FUNCTIONS

This module defines the following functions. They are all optionally exported.

=head2 rename_package

Give a package a different name.

=head2 copy_package

Give a package a new name (alias)

=head2 remove_package

Remove a package from the namespace. You probably don't want to use this unless you really know what you're doing.

=head1 AUTHOR

Leon Timmermans, C<< <leont at cpan.org> >>

=head1 BUGS

This code can cause serious mayham. Use it with care.

Please report any bugs or feature requests to C<bug-package-rename at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Package-Rename>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 PITFALLS

Perl looks up functions during compile time but methods run time. This fact can be useful (see namespace::clean for an example of that), but also to confusing.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Package::Rename


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Package-Rename>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Package-Rename>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Package-Rename>

=item * Search CPAN

L<http://search.cpan.org/dist/Package-Rename>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Leon Timmermans, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

