#!/usr/bin/env perl
use Mojolicious::Lite;
use Data::Dumper;

my $domain = 'NetConnectInfo.com';

get '/' => sub {

    my $self = shift;

    my $ip = $self->tx->remote_address;

    $self->render(text => "<h1>Your IP: $ip</h1> " ); 
    $self->app->log->debug( $self->dumper );
   

    };

get '/ip' => sub {

    my $self = shift;

    my $ip = $self->tx->remote_address;

    # $self->render(text => "<p style=\"color: red;text-align: center;font-size:
    # 45px\"><b>$ip</b></p>" ); 
    $self->stash(domain => $domain);
    $self->render('template1', ip => $ip);
   

    };
app->start;

__DATA__

@@ template1.html.ep
<!DOCTYPE html>
<html>
<p style="color: red; text-align: center; font-size: 65px"> <%= $ip %>
</p>
<p>Welcome to <a href="http://<%= $domain %>"><%= $domain %></a> and your external IP address!
</html>


