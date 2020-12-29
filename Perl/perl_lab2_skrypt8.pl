#!/usr/bin/perl

# Pavel Hryshunin, grupa 1
  
$spl = @ARGV[0];
$begin = @ARGV[1]-1;
$end = @ARGV[2]-1;


if ($begin =~ /^[+]?\d+$/) {} else {
  print "err - $begin is not number\n";
}
if ($end =~ /^[+]?\d+$/) {} else {
  print "err - $end is not number\n";
}

shift;
shift;
shift;

while(<>) {
	@words = split($spl);
	
	$isErr = 0;
	if ($#words < $begin) {
		print "err - line $. has not enought words\n";
		$isErr = 1;
	}
	
	if ($#words < $end && $isErr == 0) {
		print "err - line $. has not enought words\n";
		$isErr = 1;
	}
	
	if ($isErr == 0) {
        @words[$begin] =~ s/^\s+//;
        @words[$end] =~ s/^\s+//;
		print "@words[$begin] @words[$end]";
		print "\n";
	}
	