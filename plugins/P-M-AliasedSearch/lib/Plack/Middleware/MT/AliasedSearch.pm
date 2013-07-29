package Plack::Middleware::MT::AliasedSearch;

use strict;
use warnings;
use utf8;
use parent 'Plack::Middleware';
use Plack::Util::Accessor qw(recipes);

sub call {
    my ( $self, $env ) = @_;

    for my $recipe ( @{ $self->recipes } ) {
        if ( $env->{PATH_INFO} =~ m!\A/$recipe->{from}\z! ) {
            $env->{QUERY_STRING} = $recipe->{to};
        }
    }

    $self->app->($env);
}

1;
