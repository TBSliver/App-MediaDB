package App::MediaDB::DB::Result::UserLocation;

use DBIx::Class::Candy -autotable => v1;

primary_column id => {
  data_type => 'int',
  is_auto_increment => 1,
};

column user_id => {
  data_type => 'int',
};

belongs_to(
  "user",
  "App::MediaDB::DB::Result::User",
  { "id" => 'user_id' },
);

column location_id => {
  data_type => 'int',
};

belongs_to(
  "location",
  "App::MediaDB::DB::Result::Location",
  { "id" => 'location_id' },
);

unique_constraint(
  [
    qw/ user_id location_id /
  ]
);

1;
