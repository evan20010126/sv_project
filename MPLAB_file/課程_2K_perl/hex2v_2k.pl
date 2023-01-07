#!/usr/bin/perl -w
print "\n PIC16F84  Hex to Verilog HDL ";
print "\n Type file name \n";

#$filename = <STDIN>;
$filename = "Program_Rom.HEX";
################################################################# 
#$filename = "..\\PIC16F84_ASM\\test.hex";
#$filename = "..\\Pic16F84_C\\test.hex";

chomp ($filename);
print "\nReading file \"$filename\"\n";
open (SRECORDFILE,$filename) || 
  die "\nCan't open \"$filename\" for input.\n";

# Handle getting a new extension for the output filename
$i = index($filename,".");
   # If no period is found, simply add the extension to the end.
   
#ymh   
#if ($i < 0) { $i = length($filename); }
#substr($filename,$i,4) = ".232";
$filename_w = "Program_Rom.sv";

print "\nWriting file \"$filename_w\"\n";

# Open the output file
open (OUTPUTFILE,">".$filename_w) || 
  die "\nCan't open \"$filename\" for output.\n";  
  
  
  
 #Print head
  print OUTPUTFILE "module Program_Rom(\n";
  print OUTPUTFILE "	output logic [13:0] Rom_data_out, \n";
  print OUTPUTFILE "	input [10:0] Rom_addr_in\n";
  print OUTPUTFILE ");\n\n";
  print OUTPUTFILE "    logic [13:0] data;\n";
  print OUTPUTFILE "    always_comb\n";
  print OUTPUTFILE "        begin\n";
  print OUTPUTFILE "            case (Rom_addr_in)\n";     
 ################################################################# 
  
  
$line_number = 0;
while ($line = <SRECORDFILE>) {
  # increment the line number counter
  $line_number += 1;
  # ignore lines that begin with semicolon
  if (index($line,";")==0) { next; }
  # Get the position of the start of data
  # (Usually there is a colon at the very start of the line...)
  $i = index($line,":");
  if ($i < 0) {
    print "\nError!  No colon found on line: $line_number";
    last;
    }
    
  # Get the length of the line
  $line_length = hex(substr($line,($i+1),2));
  
 if ($line_length == 0) {
    	print "0";
    	next;
    	}
    
  
  #ymh
  #print OUTPUTFILE "line_length = $line_length\n";
  
   $tt = hex(substr($line,($i+7),2)); 
   
   if ($tt != 04){
	   
    	
  		# Extract the starting address
  		$line_starting_address = hex(substr($line,($i+3),4));
  		
  		#ymh
		$j = $line_starting_address;
  	  
  #ymh
  #print OUTPUTFILE "line_starting_address = $line_starting_address\n";
  

  # Extract the data substring - length is in units of bytes,
  # but each character is 1/2 byte, so multiply by 2.
  #$line_data = substr($line,($i+9),($line_length*2));
  $line_data = substr($line,($i+9),($line_length*2));  
  
  #ymh
  #print OUTPUTFILE "line_data = $line_data\n";
  
  
  
  # Send data characters to output file as rs232_syscon commands
  # increment by 2 in order to send 1 byte per command...
  
  #no warnings 'numeric';
  $j = $line_starting_address/2;
  #$k = $j;
  
  for ($i=0;$i<($line_length)*2;$i+=4) {
	
   # $j = $line_starting_address + $i/4;
    $addr = sprintf "%lx",$j;  # Convert address to hexadecimal
    $byte = substr($line_data,$i,2);
    $byte_high = substr($line_data,$i+2,2);
    
    print OUTPUTFILE "                10'h$addr : data = 14'h$byte_high$byte;\n";
    
    #no warnings 'numeric';
    $j = $j + 1;
        
    #print OUTPUTFILE "w $j $byte\n";
  }
  
  #$j = $j + $line_length;
  
  
  
  
  
# Verbose debug information...
#  print "\nline $line_number: starts at $line_starting_address ";
#  print "length is $line_length ";
#  print "data is $line_data ";
  # Print a little period for each line processed...
  # (to complement the 0 printed for zero length lines encountered.)
  	print ".";

  	
  	  	} ## if ($tt != 04){

  }
  
## Print Tail
  print OUTPUTFILE "                default: data = 14'h0;   \n";
  print OUTPUTFILE "            endcase\n";
  print OUTPUTFILE "        end\n";
  print OUTPUTFILE "\n";
  print OUTPUTFILE "     assign Rom_data_out = data;\n";
  print OUTPUTFILE "\n";
  print OUTPUTFILE "endmodule\n";
   
  
  
#Close all open files
close (SRECORDFILE);
close (OUTPUTFILE);
