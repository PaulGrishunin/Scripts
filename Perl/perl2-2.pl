#!/usr/bin/perl
    
$begin = @ARGV[0];
$end = @ARGV[1];
    
if ($begin =~ /^[0-9]+$/) {}
else 
        {
    print STDERR "ERROR! - $begin is not positive/numeric\n";
    exit;
    }
    if ($end =~ /^[0-9]+$/) {} 
else
    {
    print STDERR "ERROR! - $end is not positive/numeric\n";
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
        
    if ($#words < $begin) {
        print STDERR "ERROR! - in line $. quantity of words < $begin\n";
            }
    if ($#words < $end) {
        print STDERR "ERROR! - in line $. quantity of words < $end\n";
            }
    else{
        print "@words[$begin-1] @words[$end-1]";
        print "\n"; }       
}
