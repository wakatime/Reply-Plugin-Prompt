#!/usr/bin/env perl
use Env qw(GITHUB_REF_NAME);
use File::Copy 'cp';
use ExtUtils::MakeMaker;

cp 'MANIFEST.SKIP.bak', 'MANIFEST.SKIP';
unless ( $GITHUB_REF_NAME eq '' ) {
    $VERSION = $GITHUB_REF_NAME;
}
else {
    $VERSION = `git describe --abbrev=0`;
    chomp $VERSION;
    $VERSION = '0.0.0' if $VERSION eq '';
}

WriteMakefile(
    NAME          => 'Reply::Plugin::Prompt',
    LICENSE       => 'gpl_3',
    AUTHOR        => 'Wu Zhenyu <wuzhenyu@ustc.edu>',
    VERSION       => $VERSION,
    ABSTRACT_FROM => 'lib/Reply/Plugin/Prompt.pm',
    PREREQ_PM     => {
        'Reply' => '0',
    },
);
