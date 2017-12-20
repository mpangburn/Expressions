import UIKit
import PlaygroundSupport
import Expression


var integerExpression: ArithmeticExpression<Int> = 3*(1+2)-8
integerExpression.description


//let view = binaryTreeView(of: integerExpression)
//view.setNeedsDisplay()
//PlaygroundPage.current.liveView = view

let fExpression: FloatingPointArithmeticExpression<Double> = 1.3-10.8/3.3*1.5+4
fExpression.description

let e: ArithmeticExpression<Int> = 1000000
