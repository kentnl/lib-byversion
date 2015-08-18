
use strict;
use warnings;

use Test::More;

# ABSTRACT: Test Import

use lib::byversion q[test/%v/lib];
no lib::byversion q[test/%v/lib];

cmp_ok( $INC[0], 'ne', qq{test/$]/lib}, 'Library path removed' );

done_testing;
