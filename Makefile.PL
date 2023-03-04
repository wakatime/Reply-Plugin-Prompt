#!/usr/bin/env perl
use Env qw(GITHUB_REF_NAME);
use ExtUtils::MakeMaker;

unless ( $GITHUB_REF_NAME eq '' ) {
    $version = $GITHUB_REF_NAME;
}
else {
    $version = `git describe --abbrev=0`;
    chomp $version;
    $version = '0.0.0' if $version eq '';
}

WriteMakefile(
    NAME          => 'Reply::Plugin::Prompt',
    LICENSE       => 'gpl_3',
    AUTHOR        => 'Wu Zhenyu <wuzhenyu@ustc.edu>',
    VERSION       => $version,
    ABSTRACT_FROM => 'lib/Reply/Plugin/Prompt.pm',
    PREREQ_PM     => {
        'Reply'     => '0',
        'File::XDG' => '0',
    },
);
