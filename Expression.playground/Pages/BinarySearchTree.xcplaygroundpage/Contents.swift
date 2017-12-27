//
// NOTE: If you're using Xcode and seeing raw markdown contents, go to the
// Editor menu -> Show Rendered Markup.
//

/*:
 ## Visualizing Binary Search Trees
 While the initial aim of this project was to visualize expressions as trees,
 protocol-oriented programming allows for easy implementation of other tree structures--and
 we get visualization through Playground QuickLook for free.
*/
import Expression

let tree = BinarySearchTree("the quick brown fox jumps over the lazy dog")
/*:
 Changes to a tree's structure can be visualized via comparison before/after an insertion or deletion.
*/
var tree2 = BinarySearchTree([2, 3, 5, 1, 4, 6, 7, 8, 10, 9])
tree2.insert(11)
tree2.delete(5)
/*:
 You may notice that the node positioning algorithm lines up a node's single child directly below it.
 This can make it difficult to distinguish between right and left child nodes. To better visualize this,
 you can use the tree's `renderWide()` method. However--as the name suggests--these images can
 easily grow wide, as the width of the image grows exponentially with the tree's height. A future
 update to this project will use a different positioning algorithm to remedy this.
*/
tree2.renderWide()
