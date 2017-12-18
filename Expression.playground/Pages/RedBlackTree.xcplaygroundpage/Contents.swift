import UIKit
import PlaygroundSupport
import Expression


let tree = RedBlackTree("the quick brown fox jumps over the lazy dog")
tree.height
tree.count
tree.min()
tree.max()

let tree2 = RedBlackTree(1...27)
tree2.height
tree2.count
tree2.min()
tree2.max()
