//
// NOTE: If you're using Xcode and seeing raw markdown contents, go to the
// Editor menu -> Show Rendered Markup.
//

/*:
 ## Visualizing Red-Black Trees
 A red-black tree is a form of self-balancing binary search tree where each node
 is labeled "red" or "black" according to a certain set of rules.
 The color structure of these trees can be seen through the Playground QuickLook.
*/
import Expression

let tree = RedBlackTree("the quick brown fox jumps over the lazy dog")
/*:
 Changes to a tree's structure can be visualized by comparing before
 and after an insertion. A future update to this project will support deletion
 in red-black trees.
*/
var tree2 = RedBlackTree(1...10)
tree2.insert(11)
