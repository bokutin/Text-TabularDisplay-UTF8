use utf8;
use strict;
use Test::More;
use Data::Section::Simple qw(get_data_section);
use Unicode::Normalize qw(NFC NFD);

use_ok("Text::TabularDisplay::UTF8");

{
    my $t = Text::TabularDisplay::UTF8->new(qw(Parameter Value));
    $t->add( [ hello      => "goodbye" ] );
    $t->add( [ こんにちは => "さようなら" ] );
    is( "\n".$t->render."\n", "\n".get_data_section('good01') );
}

{
    my $t = Text::TabularDisplay::UTF8->new(qw(Parameter Value));
    $t->add( [ hello               => "goodbye" ] );
    $t->add( [ こんにちは          => "さようなら" ] );
    $t->add( [ NFD("ごきげんよう") => NFD("ごきげんよう") ] );
    is( "\n".$t->render."\n", "\n".NFD(get_data_section('good02')) );
}

done_testing();

__DATA__

@@ good01
+------------+------------+
| Parameter  | Value      |
+------------+------------+
| hello      | goodbye    |
| こんにちは | さようなら |
+------------+------------+
@@ good02
+--------------+--------------+
| Parameter    | Value        |
+--------------+--------------+
| hello        | goodbye      |
| こんにちは   | さようなら   |
| ごきげんよう | ごきげんよう |
+--------------+--------------+
