
use strict;
use warnings;

use Test::More;

# ABSTRACT: Test Import

use lib::byversion q[test/%v/lib];

cmp_ok( $INC[0], 'eq', qq{test/$]/lib}, 'Library path injected' );

done_testing;

