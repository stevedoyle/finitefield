$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

# = fieldElements.rb - Generate the anti-log and log tables for a finite field.
#
# Copyright (C) 2008  Stephen Doyle
#
# This example illustrates using the finitefield library to generate the
# anti-log and log tables for a finite field for a given field polynomial 
# and generator.
#
# The anti-log table for a finite field is constructed using a generator
# whose successive powers g^n for the range n[0, 255] produce all the 
# in the field without repeating any element.
#
# If the anti-log and log tables are available for a finite field, 
# multiplication can be performed very quickly using these tables, e.g.
#   mult(a, b) = anti_log( [log(a) + log(b)] % 0xFF )
# where + is normal addition, i.e. not addition within the finite field.
#

require 'finitefield'

# Utility method to print a nicely formatted 16x16 table of hex values
def printTable(table)
  0.upto(255) do |i|
    printf("%02x ", table[i])
    if i!=0 and i%16==15
      puts ''
    end
  end
end

# Compute the inverse or anti log table for a given field polynomial and generator.
# Note that the last value of the ilogTable is invalid and present in this example
# as a placeholder to produce a nicely dimensioned array.
def getILogTable(poly, generator)
  field = FiniteField.new(8, poly)
  ilogTable = [1]

  1.upto(0xFF) do |i|
    ilogTable[i] = field.multiply(ilogTable[i-1], generator)
  end
  return ilogTable
end

# Compute the log log table for a given field polynomial and generator.
def getLogTable(poly, generator)
  # The log table is most easily generated from the inverse log table.
  # Note that the last element in the inverse log table is invalid and so
  # should be discarded to avoid introducing errors into the log table
  # generation.
  ilogTable = getILogTable(poly, generator)[0...-1]
  tmp = {}
  ilogTable.each_with_index { |value, index| tmp[value] = index }
  logTable = [0] + tmp.sort.collect { |x| x[1]}
  return logTable
end


# Generate and print the anti-log and log tables for two well known fields ...
# ... the 0x11D field is the default polynomial used for the GF(2^8)
# computations used in RAID 6 for the generation of the Q parity block.
puts "Inverse log table for polynomial 0x11D: "
ilogTable = getILogTable(0x11D, 2)
printTable(ilogTable)
puts ''

puts "Log table for polynomial 0x11D: "
logTable = getLogTable(0x11D, 2)
printTable(logTable)
puts ''

# ... the 0x11B polynomial is the polynomial used in AES computations.
# See: http://www.cs.utsa.edu/~wagner/laws/FFM.html for further details.
puts "Inverse log table for polynomial 0x11b:"
ilogTable = getILogTable(0x11b, 3)
printTable(ilogTable)
puts ''

puts "Log table for polynomial 0x11b: "
logTable = getLogTable(0x11b, 3)
printTable(logTable)
puts ''

# Demonstrate multiplication using the tables.
a = 0x12
b = 0x34

field = FiniteField.new(8, 0x11D)
r1 = field.multiply(a, b)

ilogTable = getILogTable(0x11D, 2)
logTable = getLogTable(0x11D, 2)
r2 = ilogTable[ (logTable[a] + logTable[b]) % 0xFF ]

puts "Result using FiniteField.multiply(): #{r1}"
puts "Result using log tables: #{r2}"
