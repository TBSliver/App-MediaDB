package App::MediaDB::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

# root controller has no namespace
__PACKAGE__->config( namespace => '' );

=head1 NAME

App::MediaDB::Controller::Root - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  my $user = 'not-logged-in';

  if ( $c->user_exists ) {
    $user = $c->user->id;
  }

  $c->response->body("Matched App::MediaDB::Controller::Root in Root.\n\nUser Id: $user");

}

=encoding utf8

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
