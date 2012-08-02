#!/usr/bin/env perl
use Mojolicious::Lite;
use Mojo::Message::Request;

use Data::Dumper;

my $domain = 'NetConnectInfo.com';


get '/json' => sub {

    my $self = shift;

    my $ip = get_ip($self);

    $self->render(text => "{\"ip\":\"$ip\",\"info\":\"/info\"}" );

};

get '/raw' => sub {

    my $self = shift;

    my $ip = get_ip($self);

    $self->render(text => "$ip" ); 
   

    };

get '/ip' => sub {

    my $self = shift;

    my $ip = get_ip($self);

    $self->render(text => "<h1>Your IP: $ip</h1> " ); 
    $self->app->log->debug( $self->dumper );
   

    };


get '/dump' => sub {

    my $self = shift;

    my $ip = $self->tx;

    $self->render(text => Dumper( $ip )); 
    # $self->app->log->debug( $self->dumper );
   

    };
get '/' => sub {

    my $self = shift;

    my $ip = get_ip($self);

    $self->stash(domain => $domain);
    $self->render('template1', ip => $ip);
   

    };

get '/info' => sub {

    my $self = shift;
    $self->stash(domain => $domain);
    my $info = "$domain - developed by QuestorSystems.com (c) 2012";

    $self->render('template1', ip => $info );

    };

# internal rountines
sub get_ip
{
my $self = shift;

    $self->req->headers->header('X-Forwarded-For') ||
      $self->tx->remote_address; 
}

app->start;

__DATA__

@@ template1.html.ep
<!DOCTYPE html>
<html>
<p style="color: red; text-align: center; font-size: 65px"> <%= $ip %>
</p>
<p>Welcome to <a href="http://<%= $domain %>"><%= $domain %></a> and your external IP address!
</html>


