package GRNOC::TSDS::SparseDurationDataPoint;

use Moo;

use Types::Standard qw( Str Int StrictNum Object Maybe );
use Types::Common::Numeric qw( PositiveInt PositiveOrZeroInt );

use Data::Dumper;

### required attributes ###

has 'data_type' => ( is => 'ro',
                     isa => Object,
                     required => 1 );

has 'value_type' => ( is => 'ro',
                      isa => Str,
                      required => 1 );

has 'start' => ( is => 'ro',
                isa => PositiveOrZeroInt,
                required => 1,
                coerce => sub { defined $_[0] ? $_[0] + 0 : undef } );

has 'end' => ( is => 'ro',
                isa => PositiveOrZeroInt,
                required => 1,
                coerce => sub { defined $_[0] ? $_[0] + 0 : undef } );

has 'value' => ( is => 'ro',
                 isa => Maybe[StrictNum],
                 required => 1,
                 coerce => sub { defined $_[0] ? $_[0] + 0 : undef } );

### optional attributes ###

has 'interval' => ( is => 'rw',
                    isa => PositiveInt,
                    required => 0,
                    coerce => sub { defined $_[0] ? $_[0] + 0 : undef } );

1;
