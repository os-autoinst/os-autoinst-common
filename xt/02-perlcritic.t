#!/usr/bin/env perl
# Copyright SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

use Test::Most;
use v5.10;
use experimental 'signatures';
# See xt/01-comple-check-all.t for ":no_end_test" here
use Test::Warnings qw(:no_end_test :report_warnings);
use FindBin '$Bin';
use lib "$FindBin::Bin/lib";
use OpenQA::Test::TimeLimit '90';

sub extra_include_paths (@extra_paths) {
    my @paths = map { ("$Bin/../$_", "$Bin/../external/os-autoinst-common/$_") } @extra_paths;
    return grep { -e $_ } map { File::Spec->rel2abs($_) } @paths;
}

BEGIN {
    unshift @INC, extra_include_paths('lib/perlcritic');
}

use Test::Perl::Critic (-profile => '.perlcriticrc');
Test::Perl::Critic::all_critic_ok('lib', 't', 'xt');
