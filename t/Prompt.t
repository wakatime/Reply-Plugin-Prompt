use Test::More;
use Reply::Plugin::Prompt;

ok( section_result eq '', 'section_result when $? == 0' );
$? = 1;
ok( section_result =~ $?, 'section_result when $? == 0' );
chdir 't';
ok( section_path =~ '' );
ok( section_version =~ '\d\.\d' );

done_testing();
