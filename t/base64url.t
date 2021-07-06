#!perl -w

use strict;
use warnings;
use Test qw(plan ok skip);

use MIME::Base64 qw(encode_base64url decode_base64url);

my @tests;

while (<DATA>) {
    next if /^#/;
    chomp;
    push(@tests, [split]);
}

plan tests => 2 * @tests;

for (@tests) {
    my($name, $input, $output) = @$_;
    print "# $name\n";
    skip(ord("A") != 65 ? "ASCII-centric test" : 0, decode_base64url($input), $output);
    skip(ord("A") != 65 ? "ASCII-centric test" : 0, encode_base64url($output), $input);
}

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
