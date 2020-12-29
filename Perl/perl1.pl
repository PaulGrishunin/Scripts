#!/usr/bin/perl

# Pavel Hryshunin, grupa 1



for ( my $i = 0 ; $i <= $#ARGV ; $i++ ){
    
    if ( $ARGV[$i] eq '-c' ){    
        while(<>){
            print "$. $_";
            next;
            break;
                if (eof) {
                    close(ARGV);
                    print "\n";
                    print "\n";
                }
            }            
        }  
     
    
    elsif ( $ARGV[$i] eq '-N' ){    
        while(<>){
                                    
                print "$. $_" if (!/^#/) ;
                
                next;
                if (eof) {
                    close(ARGV);
                    print "\n";
                    print "\n";
                }
         }
     }  
      
    
    elsif ( $ARGV[$i] eq '-p' ){    
        while (<>) {
                        
            print  "$. $_";
            if (eof) {
                close(ARGV);
                print "\n";
                print "\n";
            }
        }  
    }    
    
     
    else{
         while (<>) {                        
             print  "$, $_";    # print STDERR "$, $_"; -- wyprowadzam na stderr
             if (eof) {
                 close(ARGV);
                 print "\n";
                 print "\n";
             }
         }  
    }
    
}  
    
    

    
    

    
    
    
#     print STDOUT "Welcome to our little program\n";
#     print STDERR "Could not open file\n";
    

