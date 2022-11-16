#!/usr/bin/perl

use strict;
# use warnings;

my $help = "
curl wrapper utility for beerapear development stuff.
Wrapps the curl command with templated stuff to make 
development life easier.

usage: curl<d,p,s> <endpoint> <request_type> <data> 

url: endpoint to hit
request_type: (optional. defaults to GET) request type. Matches how curl does it
data: (optional) json format

NOTE: try ./beer-appear-curl.pl alias to generate list of aliases for use in shell env
";

# Pregenerate the Json web token
my $header = "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJjYWFyb25AYmVlcmFwcGVhci5jb20iLCJpc3MiOiJCZWVyIEFwcGVhciIsImlhdCI6MTY2MTYwOTYzNiwiZXhwIjoyNjYxNjQ1NjM2LCJ0b2tlbl90eXBlIjoiYWNjZXNzIn0.4H1Vq2vGtAwU8ba4rn2zgJ3weaHToTo4BvfJfpBZmrs";
my @options = ("-H", "$header");

my $function = shift(@ARGV);
my $endpoint = shift(@ARGV);
my $request_type = shift(@ARGV);
my $data = shift(@ARGV);

if($endpoint eq "-h"){
    $function = "help";
}
    
if($request_type) {
    push(@options, "-d", "$data", "-X", "$request_type");
}

if($function eq "curld"){
    system("curl", @options, "localhost:5000/api/v1/$endpoint");
}

elsif($function eq "curlp"){
    system("curl", @options, "https://prod.beerappear/api/v1/$endpoint");
}

elsif($ARGV[0] eq "curls"){
    system("curl", @options, "https://staging.beerappear/api/v1/$endpoint");
}

elsif($function eq "alias"){
    use Cwd qw();
    print "To make this script easier to use, add the following aliases to your base rc file:
    
    ";
    my $dir = Cwd::cwd() . "/beer-appear-curl.pl";
    
    my $alias = "
    alias curld=\"$dir curld\" 
    alias curls=\"$dir curls\" 
    alias curlp=\"$dir curlp\" 
    
    ";
    print $alias;
}

else{
        print $help;
}
