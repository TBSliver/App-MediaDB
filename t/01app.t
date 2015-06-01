#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use Catalyst::Test 'App::MediaDB';

ok( request('/adm')->is_success, 'Request should succeed' );

done_testing();
