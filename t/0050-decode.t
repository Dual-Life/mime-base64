use strict;
use Test::More;

require MIME::QuotedPrint;


subtest test_decode_qp_rfc2045 => sub {
    my %tests = (
        'Hello World=0A' => "Hello World\n",
        'Hello World=0D=0A' => "Hello World\r\n",
        );

    for my $t (sort keys %tests)
    {
        is MIME::QuotedPrint::decode_qp($t), $tests{$t}, "$t";
    }
};

subtest  test_decode_qp_mixed_eols => sub {
    my %tests = (
        "Hello=0AWorld\r\n" => "Hello\nWorld\r\n", # implicit_nl
        "Hello\r\nWorld=0A" => "Hello\r\nWorld\n", # implicit_explicit_nl
        "Hello=0D=0A\r\nWorld=0A\r\n" => "Hello\r\nWorld\n", # explicit_explicit_nl
        "Hello=0D=0A\nWorld=0A\n" => "Hello\r\nWorld\n", # explicit_explicit_nl_2
        );

    for my $t (sort keys %tests)
    {
        my $expected = $tests{$t};
        my $tname    = $t;
        my $got      = MIME::QuotedPrint::decode_qp($t);
        $tname =~ s/\r/\\r/mg;
        $tname =~ s/\n/\\n/mg;
        unless( is $got, $expected, $tname )
        {
            ( my $enc_got = $got ) =~ s/\n/\\n/g;
            $enc_got =~ s/\r/\\r/g;

            ( my $enc_expected = $expected ) =~ s/\n/\\n/g;
            $enc_expected =~ s/\r/\\r/g;
            note "     got: $enc_got";
            note "expected: $enc_expected";
        }
    }
};


done_testing();
