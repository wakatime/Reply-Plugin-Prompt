#!/usr/bin/env perl
use ExtUtils::MakeMaker;

# https://github.com/actions/checkout/issues/1190
my $VERSION = `git tag`;
chomp $VERSION;
$VERSION =~ s/.*\n//g;

WriteMakefile(
    NAME          => 'Reply::Plugin::Prompt',
    LICENSE       => 'gpl_3',
    AUTHOR        => 'Wu Zhenyu <wuzhenyu@ustc.edu>',
    VERSION       => $VERSION,
    ABSTRACT_FROM => 'lib/Reply/Plugin/Prompt.pm',
    PREREQ_PM     => {
        'Reply'     => '0',
        'File::XDG' => '0',
    },
);
