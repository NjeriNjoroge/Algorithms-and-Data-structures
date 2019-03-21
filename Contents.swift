import UIKit

/* Big O notations
 
 O(n) - Linear
 */

let gotCharacters = [ "Jon Snow", "Arya Stark", "Mother of Dragons", "Sansa Stark", "Little Finger"]

let characterToSearchFor = "Arya Stark"

for allActors in gotCharacters {
    //check if empty
    if allActors == characterToSearchFor {
        print(allActors)
        break
    }
}

/* Big O notations
 
 O(1) - Constant time
 We use a dictionary, because it doesnt matter what names we have it only looks at specific memory address to see if it exists
 */

let gotBadasses = ["Jon Snow": 1,
                   "Arya Stark": 1,
                   "Mother of Dragons": 1,
                   "Sansa Stark": 1,
                   "Little Finger": 1
]

let characterWeWant = gotBadasses[characterToSearchFor]


/* Linked Lists
 Types: Singly & Doubly Linked Lists
 */

//Doubly Linked Lists
//Create a Node class

public class Node {
    
    var value: String // A Node needs a value associated with it
    
    init(value: String) {
        self.value = value
    }
    
    //Each node needs a pointer to the next node
    // Note that you’ve made next an optional. This is because the last node in the linked list does not point to another node.
    var next: Node?
    weak var previous: Node? //weak var to avoid the nodes being alive and not being used
}

/* Linked Lists
 Now that you have created the Node you also need to keep track of where the list begins and ends.
 This class will keep track of where the list begins and ends. It will also provide a number of other helper functions.
 */

public class LinkedLists {
    fileprivate var head: Node?
    private var tail: Node?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node? {
        return head
    }
    
    public var last: Node? {
        return tail
    }
    
    /*
     To handle appending a new node on your list, you’ll declare a append(value:) method in your LinkedList class
     */
    
    public func append(value: String) {
        // 1 create a new node to contain the value
        let newNode = Node(value: value)
        //2 if tailNode(theres sth in the linked list) is not empty configure the new item to point to the tail of the list as it’s previous item
        if let tailNode = tail {
            newNode.previous = tailNode
            tailNode.next = newNode
        }
            // 3
        else {
            head = newNode
        }
        
        tail = newNode //set the tail to be the new item
    }
    
    /*
     Accessing Nodes
     */
    public func nodeAt(index: Int) -> Node? {
        //1 Added a check that the specified index is not negative. This prevents an infinite loop if the index is a negative value
        if index >= 0 {
            var node = head
            var i = index
            //2 Loop through the nodes until you reach the node at the specified index and return the node
            while node != nil {
                if i == 0 { return node }
                i -= 1
                node = node!.next
            }
        }
        //3 If the index less than 0 or greater than the number of items in the list, then return nil
        return nil
    }
    
    /*
     Remove all nodes
     */
    public func removeAll() {
        head = nil
        tail = nil
    }
    
    /*
     Remove individual nodes
     */
    public func remove(node: Node) -> String {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            //1 Update the next pointer if you are not removing the first node in the list.
            prev.next = next
        } else {
            //2 Update the head pointer if you are removing the first node in the list.
            head = next
        }
        //3 Update the previous pointer to the previous pointer of the deleted node.
        next?.previous = prev
        
        //4 Update the tail if you are removing the last node in the list.
        if next == nil {
            tail = prev
        }
        
        //5 Assign nil to the removed nodes previous and next pointers.
        node.previous = nil
        node.next = nil
        
        //6 Return the value for the removed node.
        return node.value
    }
    
}

/*
 To display a more readable output string, you can make LinkedList adopt the CustomStringConvertable protocol
 */
extension LinkedLists: CustomStringConvertible {
    //1 You’ve declared the description property. This is a computed property, a read only property that returns a String
    public var description: String {
        //2 You’ve declared a text variable. This will hold the entire string. For now, it contains an opening brace to represent the start of the list.
        var text = "["
        var node = head
        //3 You then loop through the list appending the value of each item to the text string.
        while node != nil {
            text += "\(node!.value)"
            node = node!.next
            if node != nil { text += ", "}
        }
        // 4  You add a closing brace to the end of the text variable.
        return text + "]"
    }
}

//Printing the Linked List
let dogBreeds = LinkedLists()
dogBreeds.append(value: "Bulldog")
dogBreeds.append(value: "Beagle")
dogBreeds.append(value: "Husky")

print(dogBreeds)



/* Trees
 */

class TreeNode {
    var value: String
    var children: [TreeNode] = [] //declare children as an array of nodes
    weak var parent: TreeNode? //parent property is optional bcoz not all nodes have parents and also to avoid retain cycles its made weak
    
    init(value: String) {
        self.value = value
    }
    
    //handling insertion to the tree
    func add(child: TreeNode) {
        children.append(child)
        child.parent = self
    }
    
}

//printing the tree objects
extension TreeNode: CustomStringConvertible {
    var description: String {
        var text = "\(value)"
        
        if !children.isEmpty {
            text += " {" + children.map {$0.description}.joined(separator: ", ") + "} "
        }
        return text
    }
}


/* Example */
let beverages = TreeNode(value: "Beverages") //parent
let hotBeverages = TreeNode(value: "hot")
let coldBeverages = TreeNode(value: "cold")

//children
let hotTea = TreeNode(value: "tea")
let hotCoffee = TreeNode(value: "coffee")
let hotCocoa = TreeNode(value: "cocoa")

let coldSoda = TreeNode(value: "soda")
let coldMilk = TreeNode(value: "milk")

beverages.add(child: hotBeverages)
beverages.add(child: coldBeverages)

hotBeverages.add(child: hotTea)
hotBeverages.add(child: hotCoffee)
hotBeverages.add(child: hotCocoa)

coldBeverages.add(child: coldSoda)
coldBeverages.add(child: coldMilk)

print(beverages)

/* Stack */
//declared a Stack with an array property in it
struct Stack {
  fileprivate var array = [Int]()
  
  public var isEmpty: Bool {
    return array.isEmpty
  }
  
  public var count: Int {
    return array.count
  }
  
  //pushing
  public mutating func push(_ element: Int) {
    array.append(element)
  }
  
  //popping
  public mutating func pop() -> Int? {
    return array.popLast()
  }
  
  //peeking. Mutating keyword isnt used because peeking avoids mutating the contents of the array
  public func peek() -> Int? {
    return array.last
  }
  
}

var newBookStackCount = Stack()
newBookStackCount.push(12)
newBookStackCount.push(57)
newBookStackCount.peek()
newBookStackCount.pop()

/* Queue */
struct Queue {
  fileprivate var array = [String]()
  
  public var isEmpty: Bool {
    return array.isEmpty
  }
  
  public var count: Int {
    return array.count
  }
  
  public mutating func enqueue(_ element: String) {
    array.append(element)
  }
  
  public mutating func dequeue() -> String? {
    if isEmpty {
      return nil
    } else {
      return array.removeFirst()
    }
  }
  
  public var front: String? {
    return array.first
  }
  
}

var anotherBookStack = Queue()
anotherBookStack.enqueue("book")
anotherBookStack.enqueue("are")
anotherBookStack.enqueue("awesome")
anotherBookStack.dequeue()
print(anotherBookStack)


/* Set */
//The reason we use a dictionary is that dictionary keys must be unique, just like the elements from a set
//a dictionary has O(1) time complexity for most of its operations, making this set implementation very fast.
//Because we're using a dictionary, the generic type T must conform to Hashable. You can put any type of object into our set, as long as it can be hashed.
public struct HashSet<T: Hashable> {
  fileprivate var dictionary = Dictionary<T, Bool>()
  
  public init() {}
  
  public mutating func insert(_ element: T) {
    dictionary[element] = true
  }
  
  public mutating func remove(_ element: T) {
    dictionary[element] = nil
  }
  
  public mutating func contains(_ element: T) -> Bool {
    return dictionary[element] != nil
  }
  
  public mutating func allElements() -> [T] {
    return Array(dictionary.keys)
  }
  
  public var isEmpty: Bool {
    return dictionary.isEmpty
  }
  
  public var count: Int {
    return dictionary.count
  }
  
}

var modernFamilyCharacters = HashSet<String>()
modernFamilyCharacters.insert("Phil")
modernFamilyCharacters.insert("Gloria")
modernFamilyCharacters.insert("Haley")
modernFamilyCharacters.insert("Joe")
modernFamilyCharacters.remove("Joe")
print(modernFamilyCharacters)
modernFamilyCharacters.allElements()

/* Combining Sets */
//A lot of the usefulness of sets is in how you can combine them
//The union of two sets creates a new set that consists of all the elements in set A plus all the elements in set B. Of course, if there are duplicate elements they count only once
extension HashSet {
  public func union(_ otherSet: HashSet<T>) -> HashSet<T> {
    var combined = HashSet<T>()
    for obj in self.dictionary.keys {
      combined.insert(obj)
    }
    for obj in otherSet.dictionary.keys {
      combined.insert(obj)
    }
    return combined
  }
}

var setA = HashSet<Int>()
setA.insert(1)
setA.insert(2)
setA.insert(3)
setA.insert(4)

var setB = HashSet<Int>()
setB.insert(3)
setB.insert(4)
setB.insert(5)
setB.insert(6)

var union = setA.union(setB)
union.allElements()

/* Intersecting Sets */
//The intersection of two sets contains only the elements that they have in common
extension HashSet {
  public func intersect(_ otherSet: HashSet<T>) -> HashSet<T> {
    var common = HashSet<T>()
    for obj in dictionary.keys {
//      if otherSet.contains(obj) {
//        common.insert(obj)
//      }
    }
    return common
  }
}

var intersection = setA.intersect(setB)
intersection.allElements()


/* Differences in sets */
//the difference between two sets removes the elements they have in common
extension HashSet {
  public func difference(_ otherSet: HashSet<T>) -> HashSet<T> {
    var diff = HashSet<T>()
//    for obj in dictionary.keys {
//      if !otherSet.contains(obj) {
//        diff.insert(obj)
//      }
//    }
    return diff
  }
}

var difference1 = setA.difference(setB)
difference1.allElements()                // [2, 1]

var difference2 = setB.difference(setA)
difference2.allElements()

/* Insertion Sort */
struct InsertionSort {
  public func insertionSort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else { return array }
    var key = array //Make a copy of the array because we cannot modify the contents of the array parameter directly. The insertionSort() function will return a sorted copy of the original array
    for i in 1..<array.count { //2
      var y = i
      while y > 0 && key[y] < key[y - 1] { //3
        key.swapAt(y - 1, y)
        y -= 1
      }
    }
    return key
  }
}

let list = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
var insertSort = InsertionSort()
insertSort.insertionSort(list)

//2 There are two loops inside this function. The outer loop looks at each of the elements in the array in turn; this is what picks the top-most number from the pile. The variable i is the index of where the sorted portion ends and the pile begins (the position of the | bar). Remember, at any given moment the beginning of the array -- from index 0 up to i -- is always sorted. The rest, from index i until the last element, is the unsorted pile. The outer loop starts at index 1, not 0. Moving the very first element from the pile to the sorted portion doesn't actually change anything, so we might as well skip it

//3 The inner loop looks at the element at position i. This is the number at the top of the pile, and it may be smaller than any of the previous elements. The inner loop steps backwards through the sorted array; every time it finds a previous number that is larger, it swaps them. When the inner loop completes, the beginning of the array is sorted again, and the sorted portion has grown by one element
