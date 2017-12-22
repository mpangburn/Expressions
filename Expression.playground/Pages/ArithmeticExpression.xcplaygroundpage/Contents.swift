import UIKit
import PlaygroundSupport
import Expression


var integerExpression: ArithmeticExpression<Int> = ((25-5)/4+3)/2
integerExpression += 3*(4-2)+12-6
integerExpression.description


let (superview, rootNodeView) = integerExpression.makeView()

func animateEvaluation(of nodeView: BinaryTreeNodeView, completion: (() -> Void)? = nil) {
    guard let leftNodeView = nodeView.childNodeViews.first, let rightNodeView = nodeView.childNodeViews.last,
        let leftLineView = nodeView.childLineViews.first, let rightLineView = nodeView.childLineViews.last else {
            completion?()
            return
    }

    animateEvaluation(of: leftNodeView) {
        animateEvaluation(of: rightNodeView) {
            let moveOperandsIn = {
                nodeView.label.alpha = 0
                leftNodeView.frame = nodeView.frame
                rightNodeView.frame = nodeView.frame
                leftLineView.transform = CGAffineTransform(translationX: leftLineView.frame.width / 2, y: -leftLineView.frame.height / 2).scaledBy(x: 0.0001, y: 0.0001)
                rightLineView.transform = CGAffineTransform(translationX: -rightLineView.frame.width / 2, y: -rightLineView.frame.height / 2).scaledBy(x: 0.0001, y: 0.0001)
            }

            let updateText = {
                nodeView.updateText()
            }

            UIView.animate(withDuration: 3.0,
                           animations: moveOperandsIn,
                           completion: { _ in updateText(); completion?() })
        }
    }
}

//PlaygroundPage.current.liveView = superview
//animateEvaluation(of: rootNodeView)

let fExpression: FloatingPointArithmeticExpression<Double> = 1.2 + 3.8 * 4.9 - (5 + 3)
let (sv2, rnv2) = fExpression.makeView()

PlaygroundPage.current.liveView = sv2
animateEvaluation(of: rnv2)

let logical: LogicalExpression = true || false && (false || true) && false
let (sv3, rnv3) = logical.makeView()
//PlaygroundPage.current.liveView = sv3
//animateEvaluation(of: rnv3)





