require_relative 'LinkedList.rb'

class HashTable < LinkedList
    # make a hash table of the passed size
    # needs to be above 0 in size
    def initialize(size = 0)
        if size <= 0
            raise RangeError.new "Please enter a non-zero size"
        else
            @size = size
            # makes each index in the table its own linked list
            @table = Array.new(size) { LinkedList.new }
        end
    end

    # make a hash from the given word
    # uses some fun math,
    # and loops through indices and characters of the word
    def make_hash(word)
        my_hash = 0
        word.each_char.with_index { |c,i| 
            my_hash += c.ord * (31 ** i)
        }
        my_hash % @size
    end

    # insert a word at its appropriate hash
    # prints error message if the table isn't of size
    # uses the linked list insert method
    def insert(word)
        if @size <= 0
            puts "Cannot Insert, Invalid Size"
        else
            index = make_hash(word)
            @table[index].insert_word(word)
        end
    end

    # lookup a word at its appropriate hash
    # prints error message if the table isn't of size
    # uses the linked list lookup method
    def lookup(word)
        if @size <= 0
            puts "Cannot Lookup, Invalid Size"
        else
            index = make_hash(word)
            @table[index].lookup_word(word)
        end
    end

    # we don't want the user to have direct access
    # to hash outputs
    private :make_hash
end