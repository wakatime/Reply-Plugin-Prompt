#!/usr/bin/env perl
use Expect;

chdir;
my $exp = Expect->spawn( 'reply', () ) or die "Cannot spawn $command: $!\n";
sleep 1;
print $exp "chdir('..')\n";
sleep 1;
print $exp "\$name = `whoami`\n";
sleep 1;
print $exp "chomp \$name\n";
sleep 1;
print $exp 'print "hello, my name is $name\n"' . "\n";

$exp->soft_close();
