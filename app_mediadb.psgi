use strict;
use warnings;

use App::MediaDB;

my $app = App::MediaDB->apply_default_middlewares(App::MediaDB->psgi_app);
$app;

