package Text::TabularDisplay::UTF8;
# ABSTRACT: Text::TabularDisplay でUTF8が崩れることがあるのを直します。

use Text::TabularDisplay;
use Text::VisualWidth::PP;
use Unicode::Normalize qw(NFC);

{
    my $source = do { open(my $fh, '<', $INC{'Text/TabularDisplay.pm'}) or die $!; local $/; <$fh> };

    my @pairs = (
        [
            q|$len = length|,
            q|$len = Text::VisualWidth::PP::width(NFC($_))|,
        ],
        [
            q|if $len < length;|,
            q|if $len < Text::VisualWidth::PP::width(NFC($_));|,
        ],
        [
            q|push @line, sprintf " %-" . $lengths->[$i] . "s ", $val;|,
            q|push @line, " " . $val . " "x($lengths->[$i] - Text::VisualWidth::PP::width(NFC($val))) . " ";|,
        ],
    );

    $source =~ s/^package.*//m or die;
    $source =~ s/\Q$_->[0]\E/$_->[1]/mg or die $_->[0] for @pairs;

    eval $source or die $@;
}

1;

=encoding utf8

=head1 NAME

Text::TabularDisplay::UTF8 - Text::TabularDisplay ののUTF8対応版です。

=head1 SYNOPSIS

    my $t = Text::TabularDisplay::UTF8->new(qw(Parameter Value));
    $t->add( [ hello        => "goodbye"      ] );
    $t->add( [ こんにちは   => "さようなら"   ] );
    $t->add( [ ごきげんよう => "ごきげんよう" ] );
    $t->render;

    +--------------+--------------+
    | Parameter    | Value        |
    +--------------+--------------+
    | hello        | goodbye      |
    | こんにちは   | さようなら   |
    | ごきげんよう | ごきげんよう |
    +--------------+--------------+

=cut
