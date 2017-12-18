import UIKit
import PlaygroundSupport
import Expression


let tree: SingleTypeBinaryTree<Int> =
    .node(
        left: .leaf(5),
        value: 9,
        right: .node(
            left: .node(
                left: .leaf(8),
                value: 4,
                right: .leaf(5)
            ),
            value: 3,
            right: nil
        )
    )

tree.traverseInOrder {
    print($0)
}

