# Hash Table in Ruby

A Hash Table implemented in Ruby. Collisions are resolved with chaining via Linked List.

## Linked List File

Contains class definitions for a Linked List Node (`LLNode`), and the Linked List itself (`LinkedList`).

### Linked List Node

Contains `data` and `next` as values. Invokes the `attr_accessor` and `attr_reader` methods.

* In this implementation `data` is a string (the same string that is used in our hashing method), but could be changed to hold other values.
* `next` is a pointer to the next node in the linked list. Its default value is `nil` (we're using a singly linked list, non-circular)
* The `attr_accessor` method is invoked to allow reading from and overwriting of our `next` data, since we need to know if it's `nil`, and also potentially add new nodes chaining after the node.
* The `attr_reader` method is invoked to allow reading from `data`, for use in our `lookup` method.

Snippet:

```ruby
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
```

### Linked List

Inherits LLNode. Has data members `head`, `tail`, and `current`. Has methods `insert_word`, `lookup_word`, and private method `go_head`.

* `head` points to the first node within the linked list. It's initially set to `nil`, and is only set 1 time at most.
* `tail` points to the last node within the linked list. It updates when nodes are added to the list. Initially set to `nil`
* `current` is used for traversal of the list, which is used in the `lookup_word` function (which `insert_word` uses by calling `lookup_word`, to avoid adding repeated elements). Initially set to `nil`
* `insert_word` appends words, and has two cases:
  * Empty List
    * Creates a node with the data, and points `current`, `head`, and `tail` to that node
  * Non-empty List
    * Checks if the word is already in the list (via `lookup_word`)
    * If the word isn't in the list, then it creates a node, points `tail.next` to that node, and finally updates `tail` as the new node
* `lookup_word` checks to see if a word is in the linked list
  * If the list is empty (`if not @head`), then the word isn't in the list
  * If non-empty, then `current` is set to `head` (via `go_head`)
    * The list is traversed by a loop, comparing `current.data` against the 'word' that we're looking up.
    * If the end of the list is reached, `false` is returned
    * If our comparison finds the word, `true` is returned
* `go_head` simply updates `current` as `head`. It's useful to have as its own method to reduce the potential of mistakes, especially if more functionality was added. `go_head` is private because only internal methods should be manipulating `current`

## Hash Table File

Contains the `HashTable` class, which inherits the `LinkedList` class. Has data members `size` and `table`. Has methods `make_hash`, `insert`, and `lookup`.

* `size` is the size of the hash table. A `RangeError` is raised if a size of 0 or lower is passed as the size (since the minimum valid size of a hash table is 1).
* `table` is the actual hash table. It's an array of size `size`, and each index is initialized as an empty `LinkedList`.
* `make_hash` takes a word, and returns an appropriate hash value for it.
  * A summation method was used for the hash; here's the equation:
    * ![Summation Equation](https://latex.codecogs.com/gif.latex?$$\sum_{i=0}^{word.length-1}&space;word[i]&space;\cdot&space;31^{i}$$ "Summation Equation")
  * The hash is bounded by the size of the table at the end of the method
  * `make_hash` snippet:

```ruby
def make_hash(word)
    my_hash = 0
    word.each_char.with_index { |c,i|
        my_hash += c.ord * (31 ** i)
    }
    my_hash % @size
end
```

* `insert` tries to insert a word into the hash table.
  * First the size is checked. If the hash table is an invalid size, then a message is printed to note that, and the method ends.
  * If the size is valid, then the word is run through a hash, and the appropriate index has `insert_word` (the `LinkedList` method) called on it, passing the word.
* `lookup` tries to lookup a word in the hash table.
  * Again, if the size is invalid, then a message is printed, and the remaining code isn't ran.
  * If the size is valid, then the word is hashed, and `lookup_word` is called with the word on the corresponding linked list.

## Testing File

I created 3 tests for the hash table: `test_size_parameters`, `test_insert_lookup`, and `test_hash`.

### `test_size_parameters`

This test created hash tables of 4 different sizes; 2 invalid sizes, and 2 valid sizes. The sizes were stored in an array, and the array was iterated through. This test only created the hash table, and checked for any errors.

#### Invalid Sizes

Invalid sizes (sizes <= 0) should raise the `RangeError` that was programmed in. Because this should occur, a `rescue` was added to the test for `RangeError`'s. Within that test, the value that gave the `RangeError` is checked to see if it's an invalid size (because valid sizes shouldn't raise this, or any errors).

#### Valid Sizes

These sizes should successfully create a new hash table, and not raise any errors. Because of this, no general `Exception` is rescued in our `begin, rescue` block.

### `test_insert_lookup`

This test has 2 main parts, being individual testing for inserting and looking up elements. To start the test, a hash table of size 20 is created, and an array of the lowercase alphabet is also created (for use within the other test parts).

#### `insert`

`insert` was tested by inserting 'words' into the table, these words being the letter 'h' with an alphabetic letter attached (from 'ha' through 'hz'). A general `Exception` is rescued, with an immediate general exception raised, which states "Insert Had The Issues". This helps with immediately knowing which method failed its test.

#### `lookup`

`lookup` was tested by checking both 'words' that should be in the hash table, and words that should not be in the table. General exceptions were raised for their corresponding issue to allow further delving into the issue.

### `test_hash`

This is an empyric test to make sure that the hash created is within bounds of the table. Large words are inserted into the table, which due to our hashing method, would normally be outside the range of the table. If correctly bounded, however, then this test should pass (and it does).

## Notes

* The main issue I ran into while testing was from the `lookup` method. I had overlooked a simple aspect of traversing the linked list, which made it so that for lists of 2+ elements, I wasn't doing a comparison to the first node. This is fixed!
* Another initial issue I had was with the `attr_accessor` and `attr_reader` methods. I didn't know that these were required, and so I was running into plenty of issues there (I come from a C++/Python background)
* Ruby seems like a neat language to work with! It felt very Pythonic, but I like the differences of implicit returns and singular inheritance.
