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
<head>
<script type="text/javascript">

  var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-33853128-1']);
      _gaq.push(['_trackPageview']);

        (function() {
            var ga = document.createElement('script'); ga.type =
            'text/javascript'; ga.async = true;
                ga.src = ('https:' == document.location.protocol ?
                'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                    var s = document.getElementsByTagName('script')[0];
                    s.parentNode.insertBefore(ga, s);
                      })();

                      </script>
</head>

<body>
<p style="color: red; text-align: center; font-size: 65px"> <%= $ip %>
</p>
<p>Welcome to <a href="http://<%= $domain %>"><%= $domain %></a> and your external IP address!
</body>
</html>
