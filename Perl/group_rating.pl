#!/usr/bin/perl

#Pavel Hryshunin, grupa 1


sub Num {
    $rate = $_[0];
    if ($rate =~ /^[02345]$/) {return $rate;}     # целочисленная оценка без знаков
 	elsif ($rate =~ /^[2345]+(\.\d+)/) {return $rate;}     # оценка c запятой 
 	elsif ($rate =~ /^\-[2345]$/) {return -$rate - 0.25;}  # -оценкa
 	elsif ($rate =~ /^[2345]\-$/) {return $rate - 0.25;}  # оценкa-
	elsif ($rate =~ /^\+[234]$/) {return $rate + 0.25;}  # +оценкa
 	elsif ($rate =~ /^[234]\+$/) {return $rate + 0.25;}  # оценкa-
 	else {print STDERR "ERROR! - $rate is not legal rate\n";}
  }  
  
%group;
	
while(<>) {
    @words = split(' ');         
	
    $name = @words[0];
	#if ($name !=~ /([A-Z][a-z])/) {
	#print STDERR "ERROR! - $name is not legal name\n";}
	
    $surname = @words[1];
	#if ($surname !=~ /([A-Z][a-z])/) {
	#print STDERR "ERROR! - $surname is not legal surname\n";}
	 	 	
	$key = "$surname $name";
    push @{$group{$key}}, @words[2]; 
        
    #print "$key \t@{$group{$key}}\n";
  	if (eof) {
 #       end of file - return values and clear hash
         @group = keys %group;
         $gr = 0;
         foreach $s (sort keys %group) {
             $n = 0;
             foreach $i (@{$group{$s}}) {
                 $n = $n + Num($i);
             }
             $av = $n / ($#{$group{$s}}+1);
             $gr = $gr + $av;
             $av = (int($av * 100))/100;
             print "$s    \t @{$group{$s}} \t Average: $av\n";
         }
         $gr = $gr / ($#group+1);
         $gr = (int($gr * 100))/100;
         print "Average in group: $gr\n";
         for (keys %group) {
             delete $group{$_};};
	}
 }
