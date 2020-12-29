#!/usr/bin/perl

# Pavel Hryshunin, grupa 1
  
$spl = @ARGV[0];
$begin = @ARGV[1];
$end = @ARGV[2];

if ($begin =~ /^[+]?\d+$/) {} else {
  print "err - $begin is not number\n";
}
if ($end =~ /^[+]?\d+$/) {} else {
  print "err - $end is not number\n";
}
if ($begin > $end) {
	$n = $end;
	$end = $begin;
	$begin = $n;
}

shift;
shift;
shift;

while(<>) {
	#$str =~ s/^\s+//;
	@words = split($spl);
	foreach my $i ($begin..$end) {
        @words[$i-1] =~ s/^\s+//;
        print @words[$i-1];
        print " ";
	}
	print "\n";
}
