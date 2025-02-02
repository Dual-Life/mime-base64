use strict;
use warnings;

use Test::More tests => 11;

require MIME::Base64;
require MIME::QuotedPrint;

eval {
    my $tmp = MIME::Base64::encode(v300);
    print "# enc: $tmp\n";
};
print "# $@" if $@;
ok($@);

eval {
    my $tmp = MIME::QuotedPrint::encode(v300);
    print "# enc: $tmp\n";
};
print "# $@" if $@;
ok($@);

if (defined &utf8::is_utf8) {
    my $orig = chr(97) x 3;
    my $str = $orig . v300;
    ok(utf8::is_utf8($str));
    chop($str);
    ok(utf8::is_utf8($str));
    ok(MIME::Base64::encode($str, ""), "YWFh");
    ok(utf8::is_utf8($str));
    ok(MIME::QuotedPrint::encode($str), "$orig=\n");
    ok(utf8::is_utf8($str));

    utf8::downgrade($str);
    ok(!utf8::is_utf8($str));
    ok(MIME::Base64::encode($str, ""), "YWFh");
    ok(!utf8::is_utf8($str));
}
else {
    skip("Missing is_utf8") for 1..9;
}
