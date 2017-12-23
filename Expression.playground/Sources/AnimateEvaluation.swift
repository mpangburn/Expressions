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
    guard let leftNodeView = nodeView.childNodeViews.first, let rightNodeView = nodeView.childNodeViews.last else {
        completion?()
        return
    }

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
}
