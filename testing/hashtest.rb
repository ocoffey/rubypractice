require 'test/unit'
require_relative '../Hash_Table/HashTable.rb'

class TestHashTable < Test::Unit::TestCase
    
    # try various sizes of hash tables
    # should get an error for sizes 0 and -1
    def test_size_parameters
        sizes = [0, -1, 10, 5000]
        for size in sizes do
            begin
                HashTable.new(size)
            # only rescue for the RangeError that we implemented
            rescue RangeError
                # only fires if input size of 10 or 5000
                # raised a RangeError, which
                # should not have been the case
                if not([0, -1].include? size)
                    raise "Should not happen"
                end
            end
        end
    end

    # both tests rolled into one (it just makes sense)
    def test_insert_lookup
        # make a Hash Table of size 20
        myTable = HashTable.new(20)
        # generate an array of all lowercase letters
        letters = ('a'..'z').to_a
        # with 26 values in a size 20 table,
        # there will be collisions, so our linked list should accomodate

        # test inserting
        begin
            for letter in letters do
                myTable.insert('h'+letter)
            end
        # if we do have an exception, this makes sure
        # that we know inserting caused the problem
        rescue Exception
            raise "Insert Had The Issues"
        end

        # test for lookups working
        #begin
            for letter in letters do
                # test for 'words' that should be in the table
                if not myTable.lookup('h'+letter)
                    raise "element not in table when it should be"
                end
                # test for 'words' that shouldn't be in the table
                if myTable.lookup('e'+letter)
                    raise "element in table when it shouldn't be"
                end
            end
        #rescue Exception
        #    raise "Lookup Had The Issues"
        #end
    end

    def test_hash
        # arbitrarily choosing a large number
        myTable = HashTable.new(900)
        # check that hashes aren't larger than the size of the table
        # although make_hash is private, we can empyrically test that
        # this works by inputting words that would be larger than the bounds
        # based on our hashing equation
        words = ["arbitrary", "largewords", "fortesting"]
        for word in words do
            myTable.insert(word)
        end
    end
end