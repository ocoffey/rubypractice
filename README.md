# Ruby Practice Projects

## KD-Tree

Made with 2 main classes:

1. KDTree
2. KDNode

### KDTree

k-Dimensional Binary Search Tree

#### Tree Public Methods

* Range search? (all nodes within range)
* Nearest Neighbors search
* Element Search

#### Tree Data

* Holds KDNodes
* Has a variable for the number of dimensions
* Could have a variable for the amount of nodes?

### KDNode

k-Dimensional Node

#### Node Data

* array? of features/dimensions
* Pointers? to Left and Right KDNodes
  * See if Ruby uses null pointers or otherwise

## Hash Table

Three subclasses:

1. HashTable
2. LL (Linked List)
3. LLNode

### HashTable

#### Hash Table Public Methods

* Make Table?
* Insert/Delete Element
* Lookup

#### Hash Table Data

* array-like, where each index is a linked list
* Integer size of hash table

### L(inked) L(ist)

#### LL Methods

* Insert/Delete Node
* Search

#### LL Data

* Head (First Node)

### Linked List Node

#### LL Node Data

* String (data)
* Pointer -> Next Node