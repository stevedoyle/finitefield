$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

# = exampleUtils.rb - Utility methods used by the other examples.
#
# Copyright (C) 2008  Stephen Doyle
#

# Utility method to print a nicely formatted 16xn table of hex values
def printTable(table)
  (0...table.length).each do |i|
    printf("%02x ", table[i])
    if i!=0 and i%16==15
      puts ''
    end
  end
end
