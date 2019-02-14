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
