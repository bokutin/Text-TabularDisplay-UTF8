# NAME

Text::TabularDisplay::UTF8 - Text::TabularDisplay ののUTF8対応版です。

# SYNOPSIS

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
