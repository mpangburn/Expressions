import UIKit
import PlaygroundSupport
import Expression


let expression: LogicalExpression = (true || false) && true && (false || true)
expression.description

expression.view

let v = expression.view
PlaygroundPage.current.liveView = v
