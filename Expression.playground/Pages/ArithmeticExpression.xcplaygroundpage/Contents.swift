import UIKit
import PlaygroundSupport
import Expression


var integerExpression: ArithmeticExpression<Int> = 3*(1+2)-8
integerExpression.description

let view = integerExpression.view
PlaygroundPage.current.liveView = view

UIView.animate(withDuration: 5.0, animations: { view.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1) }, completion: {_ in UIView.animate(withDuration: 5.0, animations: { view.transform = .identity }, completion: nil)})





