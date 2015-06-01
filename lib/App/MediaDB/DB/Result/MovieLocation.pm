package App::MediaDB::DB::Result::MovieLocation;

use DBIx::Class::Candy -autotable => v1;

unique_column movie_id => {
  data_type => 'int',
};

belongs_to(
  "movie",
  "App::MediaDB::DB::Result::UserMovie",
  { "id" => 'movie_id' },
);

column location_id => {
  data_type => 'int',
};

belongs_to(
  "location",
  "App::MediaDB::DB::Result::Location",
  { "id" => 'location_id' },
);

1;
