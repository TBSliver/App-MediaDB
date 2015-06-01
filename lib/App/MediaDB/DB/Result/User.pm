package App::MediaDB::DB::Result::User;

use DBIx::Class::Candy 
  -autotable => v1;

primary_column id => {
  data_type => 'int',
  is_auto_increment => 1,
};

unique_column ra_user => {
  data_type => 'int',
};

unique_column email => {
  data_type => 'varchar',
  size => 50,
};

has_many('movies' => 'App::MediaDB::DB::Result::UserMovie', 'user_id');
has_many('locations' => 'App::MediaDB::DB::Result::UserLocation', 'user_id');
has_many('owned_locations' => 'App::MediaDB::DB::Result::Location', 'admin_id');

sub add_movie {
  my ( $self, $title ) = @_;

  my $movie = $self->result_source->schema->resultset( 'Movie' )->find_or_create(
    {
      title => $title,
    }
  );

  $self->movies->create(
    {
      movie_id => $movie->id,
    }
  );
}

sub add_location {
  my ( $self, $name ) = @_;

  my $location = $self->result_source->schema->resultset( 'Location' )->create(
    {
      name => $name,
      admin_id => $self->id,
    }
  );

  $location->add_user( $self->username );

  return $location->id;
}

sub get_location {
  my ( $self, $location_id ) = @_;

  my $location = $self->owned_locations(
    {
      id => $location_id
    }
  )->first;

  return $location;
}

1;
