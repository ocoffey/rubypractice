# Linked List Node Class
class LLNode
    # so that we can read and write
    # the data for the next node
    attr_accessor :next
    # for reading the data
    attr_reader :data
    # initializes with the data passed,
    # sets next node to nil
    def initialize(data)
        @data = data
        @next = nil
    end
end

# Linked List class inherits Nodes
class LinkedList < LLNode
    # set all 'pointers' to 'null'
    def initialize
        @head = nil
        @tail = nil
        @current = nil
    end

    # public function for inserting a word
    def insert_word(word)
        # checks if the list is empty
        if not @head
            myNode = LLNode.new(word)
            # if so, update all variables to the node
            @current = @head = @tail = myNode
        else
            # check for the word already being in the list
            # if it is, then no need to insert the word again
            return if lookup_word(word)
            myNode = LLNode.new(word)
            # if not, then update tail
            @tail = @tail.next = myNode
        end
    end

    # public function to looking up a word
    def lookup_word(word)
        # if the list is empty, word isn't there
        if not @head
            false
        else
            # if nonempty, set current to the head
            go_head
            # if only one element, compare and return
            return (@current.data == word) if not @current.next
            # traverse as long as valid, comparing along the way
            while (@current = @current.next)
                return true if (@current.data == word)
            end
            # implicit return for the word not being found
            false
        end
    end

    private
        # helper methods for easy moving
        # sets current to 'head'
        def go_head
            @current = @head
        end
end