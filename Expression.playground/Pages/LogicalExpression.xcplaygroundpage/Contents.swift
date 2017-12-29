//
// NOTE: If you're using Xcode and seeing raw markdown contents, go to the
// Editor menu -> Show Rendered Markup.
//

/*:
 ## Visualizing Logical Expressions
 Akin to arithmetic expressions, logical expressions can be written
 and visualized using natural Swift.
*/
import Expression

let expression: LogicalExpression = !(true || false) && false || !true
/*:
 And, of course, the evaluation of these expressions can be animated in the Playground's live view.
*/
animateEvaluation(of: expression)
