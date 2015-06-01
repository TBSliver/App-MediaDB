package App::MediaDB;
use Moose;
use namespace::autoclean;

use RapidApp 1.040112;

use Catalyst qw/
    -Debug
    Static::Simple
    ConfigLoader
    RapidApp::RapidDbic
    RapidApp::AuthCore
    RapidApp::CoreSchemaAdmin
    RapidApp::NavCore
/;

extends 'Catalyst';

our $VERSION = '0.01';

__PACKAGE__->config();

# Start the application
__PACKAGE__->setup();

1;

__END__

=head1 NAME

App::MediaDB - Catalyst/RapidApp based application

=head1 SYNOPSIS

    script/app_mediadb_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<RapidApp>, L<Catalyst>

=head1 AUTHOR

Catalyst developer

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
