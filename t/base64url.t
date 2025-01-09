use strict;
use warnings;
use Test::More;

use MIME::Base64 qw(encode_base64url decode_base64url);

if (ord("A") != 65) {
    plan skip_all => "ASCII-centric test";
}

my @tests;

while (<DATA>) {
    next if /^#/;
    chomp;
    push(@tests, [split]);
}

for (@tests) {
    my($name, $input, $output) = @$_;
    ok(decode_base64url($input), $output);
    ok(encode_base64url($output), $input);
}

done_testing;

__END__
# https://github.com/ptarjan/base64url/blob/master/tests.txt
# Name <space> Input <space> Ouput <newline>
len1 YQ a
len2 YWE aa
len3 YWFh aaa
no_padding YWJj abc
padding YQ a
hyphen fn5- ~~~
underscore Pz8_ ???
