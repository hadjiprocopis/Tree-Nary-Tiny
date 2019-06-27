#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Tree::Nary::Tiny' ) || print "Bail out!\n";
}

diag( "Testing Tree::Nary::Tiny $Tree::Nary::Tiny::VERSION, Perl $], $^X" );
