package Data::Paginated;

our $VERSION = '1.00';

use strict;
use warnings;

use base 'Data::Pageset';

use Carp;

=head1 NAME

Data::Paginated - paginate a list of data

=head1 SYNOPSIS

	my $paginator = Data::Paginated->new({
		entries => \@my_list,
		entries_per_page => $entries_per_page, 
		current_page => $current_page,
	});

	my @to_print = $paginator->page_data;

=head1 DESCRIPTION

Data::Paginated is a thin wrapper around Data::Pageset which adds the
extra functionality of being able to get all the entries from a list
that are on a given page.

=head1 METHODS

=head2 new

	my $paginator = Data::Paginated->new({
		entries => \@my_list,
		entries_per_page => $entries_per_page,
		current_page => $current_page,
	});

This can take all the arguments that can be passed to Data::Pageset,
with the exception that instead of passing simply the total number of
items in question, you actually pass the items as a reference.

=head2 page_data

	my @to_print = $paginator->page_data;

This returns a list of the entries that will be on the current page.

So, if you have a list of [ 1 .. 10 ], 3 entries per page, and current
page is 2, this will return (4, 5, 6).

=cut

sub new {
	my ($class, $conf) = @_;
	my $entries = delete $conf->{entries} or croak "entries must be supplied";
	my $self = $class->SUPER::new({ %$conf, total_entries => scalar @$entries });
	$self->{__DATA_PAGINATED_ENTRIES} = $entries;
	return $self;
}

sub page_data {
	my $self = shift;
	return @{ $self->{__DATA_PAGINATED_ENTRIES} }
		[ $self->first - 1 .. $self->last - 1 ];
}

=head1 AUTHOR

Tony Bowden, E<lt>kasei@tmtm.comE<gt>.

=head1 SEE ALSO

L<Data::Pageset>, L<Data::Page>.

=head1 COPYRIGHT

Copyright (C) 2004 Kasei. All rights reserved.

This module is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

