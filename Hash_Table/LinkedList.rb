# Linked List Node Class
class LLNode
    # initializes with the data passed,
    # sets next_node to nil
    def initialize(data)
        @data = data
        @next_node = nil
    end
    # helper method for knowing the data
    def get_data
        @data
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
        # makes a new node with the word
        node = LLNode.new(word)
        # checks if the list is empty
        if @head == nil
            # if so, update all variables to the node
            @current = @head = @tail = node
        else
            # if not, point current tail to the node,
            # then update tail
            @tail = @tail.next_node = node
        end
    end

    # public function to looking up a word
    def lookup_word(word)
        # if the list is empty, word isn't there
        if @head == nil
            false
        else
            # if nonempty, set current to the head
            go_head
            # traverse as long as current is valid
            while @current != nil
                # comparison looking for the word
                if @current.get_data == word
                    # early return if the word is found
                    return true
                else
                    go_next
                end
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
        # updates current as 'next'
        def go_next
            @current = @current.next_node
        end
end