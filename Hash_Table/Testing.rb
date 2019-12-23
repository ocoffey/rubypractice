#!/usr/bin/env ruby

require_relative 'HashTable.rb'

myTable = HashTable.new(100)

myTable.insert("hi")
myTable.insert("hello")
puts myTable.lookup("hi")
puts myTable.lookup("hello")
puts myTable.lookup("hey")
