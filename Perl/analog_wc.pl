#!/usr/bin/perl

#Pavel Hryshunin, grupa 1

$arg_c = 0;
$arg_l = 0;
$arg_w = 0;
$arg_m = 0;
$arg_e = 0;
$arg_i = 0;
$arg_d = 0;

$opts = 0;

foreach $a (@ARGV) {
    if ($a =~ /^-/)
    {
        if (index($a, "c") != -1)
        {$arg_c=1;}
        if (index($a, "l") != -1)
        {$arg_l=1;}
        if (index($a, "w") != -1)
        {$arg_w=1;}
        if (index($a, "m") != -1)
        {$arg_m=1;}
        if (index($a, "e") != -1)
        {$arg_e=1;}
        if (index($a, "i") != -1)
        {$arg_i=1;}
        if (index($a, "d") != -1)
        {$arg_d=1;}
        $opts=$opts+1;
    }
    else
    {
        break;
    }
}

if ($opts == 0) {
    $arg_c = 1;
    $arg_l = 1;
    $arg_w = 1;
}

foreach my $i (0..$opts-1)
{
    shift;
}


@name = @ARGV;
$actFile = 0;

$words = 0;
$Twords = 0;

$chars = 0;
$Tchars = 0;

$Tsize = 0;
$Tlines = 0;

$ints = 0;
$Tints = 0;

$numb = 0;
$Tnumb = 0;

while(<>) {
    
    if (/^#/ && $arg_e)
    {
        if ($arg_e)
        {$.=$.-1;}
        next;
    }
    
    if ($arg_w == 1 || $arg_i == 1 || $arg_d == 1) {
  
        @words = split(' ');
        $words = $words + $#words;
    }
    if ($arg_i == 1) {
      
        foreach (@words)
        {
            if (/^[-+]?\d+$/ ) {
                $ints = $ints + 1;
            }
        }
    }
    if ($arg_d == 1) {
        
        foreach (@words)
        {
            if (/^[-+]?\d*[,.]?\d+$/ ) {
                $numb = $numb + 1;
            }
            if (/^[-+]?\d*[,.]?\d+[eEdDqQ^]+[+-]?\d*[,.]?\d+$/ ) {
                $numb = $numb + 1;
            }
        }
    }
    
    if ($arg_m == 1) {
        @chars = split('');
        $chars = $chars + $#chars;
    }
    
    if (eof) {
        # out
        if ($arg_l == 1) {
            $.--;
            $Tlines = $Tlines + $.;
            print " $. ";
        }
        if ($arg_w == 1) {
            $words = $words+$.;
            $Twords = $Twords + $words;
            print " $words";
        }
        if ($arg_m == 1) {
            $chars = $chars+$.-1;
            $Tchars = $Tchars + $chars;
            print " $chars";
        }
        if ($arg_c == 1) {
            $size = -s @name[$actFile];
            $Tsize = $Tsize + $size;
            print " $size";
        }
        if ($arg_i == 1) {
            $Tints = $Tints + $ints;
            print " $ints";
        }
        if ($arg_d == 1) {
            $Tnumb = $Tnumb + $numb;
            print " $numb";
        }
        print " @name[$actFile]\n";
    
        $.=0;
        $words = 0;
        $chars = 0;
        $ints = 0;
        $actFile++;
    }
}

### View total (for two or more files)

if ($actFile > 1) {
    if ($arg_l == 1) {
        print " $Tlines ";
    }
    if ($arg_w == 1) {
        print " $Twords";
    }
    if ($arg_m == 1) {
        print " $Tchars";
    }
    if ($arg_c == 1) {
        print " $Tsize";
    }
    if ($arg_i == 1) {
        print " $Tints";
    }
    if ($arg_d == 1) {
        print " $Tnumb";
    }
    print " Total\n";
}
