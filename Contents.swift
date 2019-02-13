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
