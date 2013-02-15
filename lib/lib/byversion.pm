use strict;
use warnings;

package lib::byversion;
BEGIN {
  $lib::byversion::AUTHORITY = 'cpan:KENTNL';
}
{
  $lib::byversion::VERSION = '0.001000';
}

# ABSTRACT: add paths to @INC depending on which version of perl is running.

use lib ();
use version 0.77;




use String::Formatter stringf => {
  -as   => path_format =>,
  codes => {
    v => "$]",
    V => do {
      my $x = version->parse("$]")->normal;
      $x =~ s{^v}{};
      $x;
    },
  }
};

sub import {
  my ( $self, @args ) = @_;
  if ( @args != 1 ) {
    die "lib::byversion->import takes exactly one argument, instead, you specified " . scalar @args;
  }
  my $path = path_format(@args);
  lib->import($path);

}

sub unimport {
  my ( $self, @args ) = @_;
  if ( @args != 1 ) {
    die "lib::byversion->import takes exactly one argument, instead, you specified " . scalar @args;
  }
  my $path = path_format(@args);
  lib->unimport($path);

}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

lib::byversion - add paths to @INC depending on which version of perl is running.

=head1 VERSION

version 0.001000

=head1 SYNOPSIS

    PERL5OPT="-Mlib::byversion='$HOME/Foo/Bar/%V/lib/...'"

or alternatively

    use lib::byversion "/some/path/%V/lib/...";

=head1 DESCRIPTION

So you have >1 Perl Installs.  You have >1 Perl installs right?
And you switch between running them how?

Let me guess, somewhere you have code that sets a different value for PERL5LIB depending on what Perl you're using.
Oh you use L<perlbrew? I have bad news for you|http://grep.cpan.me/?q=PERL5LIB+dist=App-perlbrew>

This is a slightly different approach:

=over 4

=item 1. Set up your user-land PERL5LIB dirs in a regular pattern differing only by perl version

    $HOME/Foo/Bar/5.16.0/lib/...
    $HOME/Foo/Bar/5.16.1/lib/...
    $HOME/Foo/Bar/5.16.2/lib/...

=item 2. Set the following in your C<%ENV>

    PERL5OPT="-Mlib::byversion='$HOME/Foo/Bar/%V/lib/...'"

=item 3. Bam!

The right PERL5LIB gets loaded based on which perl you use.

=back.

Yes, yes, catch 22, C<lib::byversion> and its dependencies need to be in your lib to start with.

Ok. That is a problem, slightly. But assuming you can get that in each perl install somehow, you can load each perls user library dirs magically with this module once its loaded.

And "assuming you can get that in each perl install somehow" =~ with a bit of luck, this feature or something like it might just be added to Perl itself, as this is just a prototype idea to prove it works ( or as the case may be, not ).

And even if that never happens, and you like this module, you can still install this module into all your perls and keep a seperate user-PERL5LIB-per-perl without having to use lots of scripts to hold it together, and for System Perls, you may even be fortunate enough to get this module shipped by your C<OS> of choice. Wouldn't that be dandy.

=head1 IMPORT

    use lib::byversion $param
    lib::byversion->import($param)
    perl -Mlib::byversion=$param

etc.

C<lib::byversion> expects one parameter, a string path containing templated variables for versions.

Current defined parameters include:

=over 4

=item C<%V>

This is an analogue of C<$^V> except :

=over 4

=item it should work on even perls that didn't have C<$^V>, as it converts it from C<$]> with L<version>

=item it lacks the preceeding C<v>, because this is more usually what you want and its easier to template it in than take it out.

=back 4

Example:

    %V = 5.16.9

=item C<%v>

This is the same as C<$]> on your Perl.

Example:

    %v = 5.016009

=back 4

More may be slated at some future time, ie: to allow support for components based on git sha1's, but I figured to upload something that works before I bloat it out with features nobody will ever use.

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
