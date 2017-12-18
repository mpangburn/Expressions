import UIKit
import PlaygroundSupport
import Expression


let integerExpression: ArithmeticExpression<Int> = 3*(1+2)-8
let view = binaryTreeView(of: integerExpression)
integerExpression.traverseInOrder { kind in
    switch kind {
    case let .leaf(operand): print(operand)
    case let .node(`operator`): print(`operator`)
    }
}
//view.setNeedsDisplay()
//PlaygroundPage.current.liveView = view

let expression: ArithmeticExpression<UInt64> = 80<<32&+15/3

let fExpression: FloatingPointArithmeticExpression<Double> = 1.3-10.8/3.3*1.5+4
