package Tree::Nary::Tiny;

use 5.006;
use strict;
use warnings;

our $VERSION = '0.01';

# sure sounds convenient but doing
# if( $node ){ ... }
# prints the node!!!!
use overload
	'""' => 'stringify'
;
sub	new {
	my $class = $_[0];
	my $parent = $_[1];
	my $id = $_[2];
	my $value = $_[3];
	my $print_value_sub = $_[4]; # optional
	$print_value_sub = sub { return $_[0] } unless defined $print_value_sub;
	my $self = {
		'_parent' => $parent,
		'id' => $id,
		'v' => $value,
		'pvs' => $print_value_sub,
		'c' => [],
		'_depth' => 0
	};
	bless $self => $class;

	if( defined $parent ){
		push @{$parent->{'c'}}, $self;
		$self->{'_depth'} = $parent->{'_depth'} + 1;
	}
	return $self
}
sub	leaf_nodes {
	my $self = $_[0];
	my @ret;
	for(@{$self->{'c'}}){
		my $aret = $_->leaf_nodes();
		push(@ret, @$aret) if defined $aret;
	}
	return scalar @ret ? \@ret : [$self]
}
sub	parent { return $_[0]->{'_parent'} }
sub	value { return $_[0]->{'v'} }
sub	id { return $_[0]->{'id'} }
sub	children { return $_[0]->{'c'} }
sub	value_stringify { return $_[0]->{'pvs'}->($_[0]->{'v'}) }
sub	add_child {
	return Tree::Nary::Tiny->new(
		$_[0], # parent is our self
		$_[1], # id
		$_[2], # optional value
		# optiona print value sub or parent's
		defined($_[3]) ? $_[3] : $_[0]->{'pvs'}
	);
}		
sub	stringify {
	my $self = $_[0];
	my $v = $self->{'v'};
	my $ret = $self->{'id'} . " (depth ".$self->{'_depth'}.") :";
	if( defined $v ){ $ret .= $self->{'pvs'}->($v) } else { $ret .= '<na>' }
	return $ret;
}
1;

# pod starts here
=head1 NAME

Tree::Nary::Tiny - The great new Tree::Nary::Tiny!

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Tree::Nary::Tiny;

    my $foo = Tree::Nary::Tiny->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS


=head1 AUTHOR

Andreas Hadjiprocopis, C<< <bliako at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-tree-nary-tiny at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=Tree-Nary-Tiny>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Tree::Nary::Tiny


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=Tree-Nary-Tiny>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Tree-Nary-Tiny>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/Tree-Nary-Tiny>

=item * Search CPAN

L<https://metacpan.org/release/Tree-Nary-Tiny>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2019 Andreas Hadjiprocopis.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Tree::Nary::Tiny
