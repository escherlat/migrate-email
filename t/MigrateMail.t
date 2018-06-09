#!/usr/local/cpanel/3rdparty/bin/perl
# cpanel - t/Cpanel-API-DNSSEC.t
#                                                    Copyright 2016 cPanel, Inc.
#                                                           All rights Reserved.
# copyright@cpanel.net                                         http://cpanel.net
# This code is subject to the cPanel license. Unauthorized copying is prohibited

use strict;
use warnings;

use Test::More 'tests' => 6 + 1;
use Test::Deep;
use Test::NoWarnings;
use Test::MockModule;

use FindBin ();
use lib ( "$FindBin::Bin/..", "$FindBin::Bin/../src" );

use Cpanel::API::MigrateMail ();

use Data::Dumper;
{
    # $remoteuser, $remotepass, $localuser, $localpass, $mailservice
    my $mock_args = Test::MockModule->new('Cpanel::Args');
    $mock_args->mock( 'get', sub { return '', 'remotepass', 'localuser', 'localpass', 'mailservice'; } );

    my $mock_result = Test::MockModule->new('Cpanel::Result');
    $mock_result->mock( 'error', sub { my ( $self, $message ) = @_; } );

    my $args   = Cpanel::Args->new();
    my $result = Cpanel::Result->new();

    # The arguments are mandatory

    # remoteuser is blank
    my $call_result = Cpanel::API::MigrateMail::domigrateuser( $args, $result );
    is( $call_result, undef, 'RemoteUser was blank' );

    # remotepass is blank
    $mock_args->mock( 'get', sub { return 'remoteuser', '', 'localuser', 'localpass', 'mailservice'; } );
    $call_result = Cpanel::API::MigrateMail::domigrateuser( $args, $result );
    is( $call_result, undef, 'RemotePass was blank' );

    # localuser is blank
    $mock_args->mock( 'get', sub { return 'remoteuser', 'remotepass', '', 'localpass', 'mailservice'; } );
    $call_result = Cpanel::API::MigrateMail::domigrateuser( $args, $result );
    is( $call_result, undef, 'LocalUser was blank' );

    # localpass is blank
    $mock_args->mock( 'get', sub { return 'remoteuser', 'remotepass', 'localuser', '', 'mailservice'; } );
    $call_result = Cpanel::API::MigrateMail::domigrateuser( $args, $result );
    is( $call_result, undef, 'LocalPass was blank' );

    # mailservice is blank
    $mock_args->mock( 'get', sub { return 'remoteuser', 'remotepass', 'localuser', 'localpass', ''; } );
    $call_result = Cpanel::API::MigrateMail::domigrateuser( $args, $result );
    is( $call_result, undef, 'MailService was blank' );

    # remoteuser contains an '@'
    $mock_args->mock( 'get', sub { return 'remoteuser', 'remotepass', 'localuser', 'localpass', 'mailservice'; } );
    $call_result = Cpanel::API::MigrateMail::domigrateuser( $args, $result );
    is( $call_result, undef, 'RemoteUser did not contain an @ symbol' );
}

1;
