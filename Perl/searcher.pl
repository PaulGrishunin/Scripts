#!/usr/bin/perl

#Pavel Hryshunin, grupa 1


#./searcher.pl -d catalog1 -d catalog2    word1    -d catalog3    word2 


my $flag=0;
my @direct;

sub action{
open(fin,$_);      #open file, passed to function "action"
undef $/;
$_=<fin>;
$k= s/$word//g;       #counts the number of repetitions of a word in a file $word
return $k;   
close(fin);
    }

###

for (my $a= 0; $a <= $#ARGV; $a++)
 {
if ($flag == 1) {
     push @direct, $ARGV[$a];          #push argv to massive
     $flag=0;
#     print "run 1";
#     print "\n";
#      print @direct;
#     print "\n";        
     }
      
elsif (($flag == 0)  &&  ($ARGV[$a] eq "-d")) {
    $flag=1;
#    print "run 2";
#     print "\n";
         }
         
elsif (($flag == 0) && ($ARGV[$a] ne "-d")) {
    $word = $ARGV[$a];
#     print "run 3";
#     print "\n";         
#      print $word;
#      print "\n";
     
    for (my $i = 0; $i <= $#direct; $i++){
    
    print $direct[$i];
    print "\n";

###Run counting    
$n=0;

  chdir $direct[$i] || warn "can't open dir $direct[$i]\n";           # Change work catalog if it's exist
  foreach(<*>){
   if (-f "$direct[$i]/$_") { action("$direct[$i]/$_"); }             # if File - do action
 
   $n=$n+$k;
  }
  print "$word: $n";
  print "\n\n";
  
  }
   splice(@direct);
  }
  }
