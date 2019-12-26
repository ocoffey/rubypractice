# Node class for the KD-Tree
class KDNode
    # takes an array of dimensional data,
    # the depth of the node,
    # and possible data for the node
    # left and right children set to nil
    # also keeps track of the number of children
    # for nearest neighbor searches
    def initialize(dimensions, depth, data)
        @dimensions = dimensions
        @depth = depth
        @data = data
        @left = nil
        @right = nil
        @num_children = 0
    end

    # returns the depth of the node
    def get_depth
        @depth
    end

    # for keeping track of children
    def increment_children
        @num_children += 1
    end

    # returns the number of children
    def get_children
        @num_children
    end
end

class KDTree < KDNode
    # no nodes in the tree
    # empty root
    def initialize
        @num_nodes = 0
        @root = nil
        @num_dimensions = 0
    end

    # helper function to get the appropriate data
    # from the 'current' node
    def get_node_data(current)
        current[current.get_depth % @num_dimensions]
    end

    # initial inserting method
    # inserts at 'root' for an empty tree,
    # calls a recursive helper method if
    # root has a node
    def insert(dimensions, data = nil)
        # empty tree, make the first node the root
        if @root = nil
            @root = KDNode.new(dimensions, 0, data)
            # set the number of dimensions used as tree data
            # for modulus bounding
            @num_dimensions = dimensions.length
        # otherwise, call the recursive insert
        # overloaded method
        else
            self.insert(@root, dimensions, data)
        end
        # increment the total number of nodes
        @num_nodes += 1
    end

    # insert recursive method
    # compares the appropriate dimensional data passed
    # to the dimensional data of 'current'
    # recursively inserts appropriately 
    def insert(current, dimensions, data)
        # base case
        # if 'current' is nil,
        # let the previous frameknow to insert here
        if current == nil
            return true
        end
        # otherwise compare the appropriate dimension
        # of the current node to soon-to-be new node

        # if the current node data is less or equal to the passed node,
        if self.get_node_data(current) <= dimensions[current.get_depth % @num_dimensions]
            # go right
            insert_here = insert(current.right, dimensions, data)
            # if 'right' is nil, insert the node there
            if insert_here
                current.right = KDNode.new(dimensions, current.get_depth + 1, data)
                current.increment_children
            end
        # otherwise the node is less
        else
            # go left
            insert_here = insert(current.left, dimensions, data)
            # if 'left' is nil
            if insert_here
                current.left = KDNode.new(dimensions, current.get_depth + 1, data)
                current.increment_children
            end
        end
        # to let any previous frames know not to insert
        # based off of 'current'
        return false
    end

    # for fun, keep track of the total number of nodes
    def get_size
        @num_nodes
    end

    def k_traverse(k, current)
        # less than required neighbors at the current node
        if current.num_children < k
            return true
        # correct amount of neighbors at the current node
        elsif current.num_children == k
            return current
        # need more neighbors
        else
            find_neighbors = self.k_traverse(k, )
        end
    end
    
    # returns the 'k' nearest neighbors
    # of given dimensional data
    def nearest_neighbors(k, dimensions)
        # if the passed array isn't the same length as
        # the number of dimensions recorded
        if dimensions.length != @num_dimensions
            # print to stderror to let the user know to input
            # appropriate data
            # no error raised because we don't want
            # to halt the program
            STDERR.puts "dimensional data inappropriate length"
            return
        else

        end

    end

    # returns all nodes within the given range
    # of given dimensional data
    def range_search(range, )

    end

end