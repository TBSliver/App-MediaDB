#! /usr/bin/env perl

use strict;
use warnings;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

use DBIx::Class::DeploymentHandler;
use App::MediaDB::DB;
use Getopt::Long;

my $prepare = '';
my $install = 0;
my $force_overwrite = 0;
my $drop_tables = 0;
my $db_version = 0;
my $dsn = '';
my $username;
my $password;
my $upgrade = 0;
my $from_ver;
my $to_ver;
GetOptions(
  'prepare=s'       => \$prepare,
  'install'         => \$install,
  'force_overwrite' => \$force_overwrite,
  'drop_tables'     => \$drop_tables,
  'version=i'       => \$db_version,
  'dsn=s'           => \$dsn,
  'user=s'          => \$username,
  'pass=s'          => \$password,
  'upgrade'         => \$upgrade,
  'from=i'          => \$from_ver,
  'to=i'            => \$to_ver,
);

my @db_conn_info = ( $dsn );

if ( $username ) {
  die "Must define password and username together" unless defined $password;
  push @db_conn_info, $username, $password;
}

my $schema = App::MediaDB::DB->connect( @db_conn_info );

my $dh = DBIx::Class::DeploymentHandler->new({
  schema           => $schema,
  script_directory => "$Bin/../dbicdh",
  databases        => $schema->storage->sqlt_type,
  force_overwrite  => $force_overwrite,
});

if( $prepare ) {
  if ( $prepare eq "install" ) {
    $dh->prepare_install;
  } elsif ( $prepare eq "upgrade" ) {
    die "Must provide from and to for upgrade"
      unless $from_ver && $to_ver;
    $dh->prepare_upgrade({
      from_version => $from_ver,
      to_version   => $to_ver,
    });
  } else {
    die "Unrecognised prepare option";
  }
}

if( $install ) {
  if ( $db_version ) {
    $dh->install({ version => $db_version });
  } else {
    $dh->install;
  }
}

if ( $upgrade ) {
  $dh->upgrade;
}
