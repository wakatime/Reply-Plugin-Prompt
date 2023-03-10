#!/usr/bin/env -S perl -pi
BEGIN {
    $status = 0;
}
if ( $status == 0 and /^my / ) {
    $status = 1;
}
elsif ( $status == 1 and /^$/ ) {
    $status = 2;
}

if ( $status == 1 ) {
    $code .= $_;
}
elsif ( $status == 2 and /=encoding utf-8/ ) {
    $code =~ s/my //g;
    $code =~ s/^/    /gm;
    $code   = "\n$code";
    $_ .= $code;
    $status = 3;
}
elsif ( $status == 3 ) {
    exit;
}
