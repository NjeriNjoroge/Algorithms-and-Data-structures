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
    var children: [TreeNode] = [] //declare childres as an array of nodes
    weak var parent: TreeNode? //parent property is optional bcoz not all nodes have parents and also to avoid retain cycles
    
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

/* Search */
