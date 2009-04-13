#!perl -T

use strict;
use warnings;
use Package::Rename qw/rename_package/;
use Test::More tests => 8;

package Foo;

sub foo {
	return 42;
}

package main;

ok(keys %{*Foo::}, "Foo is defined");
ok(!keys %{*Bar::}, "Bar is not defined");

ok(Foo->can('foo'), "Foo has method foo");
ok(!Bar->can('foo'), "Bar does not have method foo");

rename_package('Foo', 'Bar');

ok(!keys %{*Foo::}, "Foo is not defined");
ok(keys %{*Bar::}, "Bar is defined");

ok(!Foo->can('foo'), "Foo does not have method foo");
ok(Bar->can('foo'), "Bar has method foo");
