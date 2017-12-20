import UIKit
import PlaygroundSupport
import Expression


var tree = BinarySearchTree("The quick brown fox jumps over the lazy dog")

tree.delete(" ")
tree.delete("T")
tree.delete("h")
tree.delete("y")
tree.delete("b")

//tree.renderWide().saveToDocumentsDirectory(as: "tree.png")

