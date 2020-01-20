# Node class for the KD-Tree
class KDNode
    # permission definitions for the variables
    attr_accessor :left, :right, :parent, :num_children
    attr_reader :data, :depth, :dimensions
=begin
    takes an array of dimensional data,
    the depth of the node,
    and possible data for the node (for k-nn)
    left and right children set to nil;
    also keeps track of the number of children
    for nearest neighbor searches
    and the parent node, for ease of traversal
=end
    def initialize(dimensions, depth, data, parent = nil)
        @dimensions = dimensions
        @depth = depth
        @data = data
        @left = nil
        @right = nil
        @num_children = 0
        @parent = parent
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

# inherits KDNode
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

    # finds the leaf closest to given dimensional data
    # used in insert and nn search
    def find_leaf(current, dimensions, data)
        # base case
        # if we hit nil, we know that the previous node is a leaf
        if current == nil
            return true
        # otherwise, traverse down left and right
        # until we find the leaf
        else
            # if the current node is greater or equal
            # to the current node, then traverse right
            if self.get_node_data(current) <= dimensions[current.depth % @num_dimensions]
                leaf = find_leaf(current.right, dimensions, data)
                if leaf == true
                    return current
                end
            # otherwise, traverse left
            else
                leaf = find_leaf(current.right, dimensions, data)
                if leaf == true
                    return current
                end
            end
            # if leaf wasn't 'true',
            # it means that it's a node address
            # that we should return
            return leaf
        end
    end

    # initial inserting method
    # inserts at 'root' for an empty tree,
    # calls a recursive helper method if
    # root has a node
    def insert(dimensions, data = nil)
        # empty tree, make the first node the root
        if @root == nil
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

    # insert helper method
    # calls find_leaf to know where to place the node
    # does a comparison for which child to place node at
    # then places it there
    def insert(current, dimensions, data)
        leaf = find_leaf(current, dimensions, data)
        # if node to make has greater or equal data than the leaf
        if self.get_node_data(leaf) <= dimensions[leaf.depth % @num_dimensions]
            # place to the right
            leaf.right = KDNode.new(dimensions, leaf.depth + 1, data, leaf)
        # otherwise place the node to the left
        else
            leaf.left = KDNode.new(dimensions, leaf.depth + 1, data, leaf)
        end
    end

    # for fun, keep track of the total number of nodes
    def get_size
        @num_nodes
    end
    
    def bubble_up(current, dimensions, data)
        
    end

    # returns the 'k' nearest neighbors
    # of given dimensional data
    def nearest_neighbors(k, dimensions, data)
        # if the passed array isn't the same length as
        # the number of dimensions recorded
        if dimensions.length != @num_dimensions
            # print to stderror to let the user know to input
            # appropriate data
            # no error raised because we don't want
            # to halt the program/destroy the tree
            STDERR.puts "dimensional data inappropriate length"
            return
        else
            # otherwise, find the leaf nearest the point
            leaf = find_leaf(@root, dimensions, data)
            
            
            # look up more in the algorithm
        end

    end

    # returns all nodes within the given range
    # of given dimensional data
    def range_search(range, )

    end

end