use strict;
use warnings;
use Test::More;


use Catalyst::Test 'App::MediaDB';
use App::MediaDB::Controller::Root;

ok( request('/')->is_success, 'Request should succeed' );
done_testing();
