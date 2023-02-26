#!/usr/bin/env perl
use ExtUtils::MakeMaker;

my $VERSION = `git describe`;
chomp $VERSION;

WriteMakefile(
    NAME      => 'Reply::Plugin::Prompt',
    LICENSE   => 'gpl_3',
    AUTHOR    => 'Wu Zhenyu <wuzhenyu@ustc.edu>',
    VERSION   => $VERSION,
    ABSTRACT  => 'reply plugin for powerlevel10k style prompt',
    PREREQ_PM => {
        'Reply' => '0',
    },
);
