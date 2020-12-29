#!/usr/bin/perl
    
$begin = @ARGV[0];
$end = @ARGV[1];
    
if ($begin =~ /^[0-9]+$/) {}
else 
        {
    print "ERROR! - $begin is not positive/numeric\n";
    exit;
    }
    if ($end =~ /^[0-9]+$/) {} 
else
    {
    print "ERROR! - $end is not positive/numeric\n";
    exit;
    }
if ($begin > $end) {
    $a = $end;
    $end = $begin;
    $begin = $a;
    }
    
    shift;
    shift;
    
while(<>) {
    my @words = split(' ');
        
    foreach my $i ($begin..$end)
        {
        print @words[$i-1];
        print " ";
        }
        print "\n";
    }
