#!perl -w

use strict;
use warnings;
use Test::More tests => 129;

use MIME::Base64 qw(encode_base64 encoded_base64_length decoded_base64_length);
*elen = *encoded_base64_length;
*dlen = *decoded_base64_length;

is(elen(""), 0);
is(elen("a"), 5);
is(elen("aa"), 5);
is(elen("aaa"), 5);
is(elen("aaaa"), 9);
is(elen("aaaaa"), 9);

is(elen("", ""), 0);
is(elen("a", ""), 4);
is(elen("aa", ""), 4);
is(elen("aaa", ""), 4);
is(elen("aaaa", ""), 8);
is(elen("aaaaa", ""), 8);

is(dlen(""), 0);
is(dlen("a"), 0);
is(dlen("aa"), 1);
is(dlen("aaa"), 2);
is(dlen("aaaa"), 3);
is(dlen("aaaaa"), 3);
is(dlen("aaaaaa"), 4);
is(dlen("aaaaaaa"), 5);
is(dlen("aaaaaaaa"), 6);

is(dlen("=aaaa"), 0);
is(dlen("a=aaa"), 0);
is(dlen("aa=aa"), 1);
is(dlen("aaa=a"), 2);
is(dlen("aaaa="), 3);

is(dlen("a\na\na a"), 3);

for my $i (50..100) {
    my $a = "a" x $i;
    my $a_enc = encode_base64($a);
    is(elen($a), length($a_enc));
    is(dlen($a_enc), $i);
}
