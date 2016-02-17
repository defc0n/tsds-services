package GRNOC::TSDS::DataType;

use Moo;
use Types::Standard qw( Str Object );

### required attributes ###

has name => ( is => 'ro',
              isa => Str,
              required => 1 );

has database => ( is => 'ro',
                  isa => Object,
                  required => 1 );

### lazy attributes ###

has metadata_fields => ( is => 'lazy' );

has value_types => ( is => 'lazy' );

has storage => ( is => 'lazy' );

### attribute builders ###

sub _build_value_types {

    my ( $self ) = @_;

    my $name = $self->name;
    my $collection = $self->database->get_collection( 'metadata' );
    my $value_types = $collection->find_one( {}, {'values' => 1} );

    # ISSUE=12111 handle case where this is no metadata collection and/or no document
    die( "No value types found for $name" ) if ( !$value_types || !$value_types->{'values'} );

    return $value_types->{'values'};
}

sub _build_metadata_fields {

    my ( $self ) = @_;

    my $name = $self->name;
    my $collection = $self->database->get_collection( 'metadata' );
    my $fields = $collection->find_one( {}, {'meta_fields' => 1} );

    # ISSUE=12111 handle case where this is no metadata collection and/or no document
    die( "No metadata fields found for $name" ) if ( !$fields || !$fields->{'meta_fields'} );

    return $fields->{'meta_fields'};
}

sub _build_storage {

    my ( $self ) = @_;

    my $name = $self->name;
    my $storage = $collection->find_one( {}, {'storage' => 1} );

    # ISSUE=12111 handle case where this is no metadata collection and/or no document
    die( "No metadata doc found for $name" ) if ( !$storage );

    # assume default storage if one not set otherwise
    return $storage->{'storage'} || "default";
}

1;
