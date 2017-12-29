import UIKit
import PlaygroundSupport
import Expression


private let animationDuration = 3.0

public func animateEvaluation<T>(of expression: T) where T: EvaluatableExpressionProtocol {
    let (liveView, rootNodeView) = EvaluatableExpressionViewFactory.makeView(of: expression)
    PlaygroundPage.current.liveView = liveView
    animateEvaluation(of: rootNodeView)
}

private func animateEvaluation(of nodeView: BinaryTreeNodeView, completion: (() -> Void)? = nil) {
    switch nodeView.childNodeViews.count {
    case 0:
        completion?()
        return
    case 1:
        animateEvaluation(of: nodeView.childNodeViews[0]) {
            UIView.animate(withDuration: animationDuration,
                           animations: nodeView.bringInChildNodes,
                           completion: { _ in
                            nodeView.updateToNextState()
                            completion?()
            })
        }
    case 2:
        let leftNodeView = nodeView.childNodeViews[0]
        let rightNodeView = nodeView.childNodeViews[1]
        animateEvaluation(of: leftNodeView) {
            animateEvaluation(of: rightNodeView) {
                UIView.animate(withDuration: animationDuration,
                               animations: nodeView.bringInChildNodes,
                               completion: { _ in
                                nodeView.updateToNextState()
                                completion?()
                })
            }
        }
    default:
        fatalError("A binary tree node can have no more than two children.")
    }
}
