//
// NOTE: If you're using Xcode and seeing raw markdown contents, go to the
// Editor menu -> Show Rendered Markup.
//

/*:
 ## Visualizing Arithmetic Expressions
 Create the expression you want to visualize by typing it naturally, using integer literals
 and operators. Its tree representation is readily available through the Playground QuickLook.
*/
import Expression

let expression: ArithmeticExpression<Int> = 2*(1+3)-8/4
/*:
 Integer expressions can utilize any of the standard operators you might encounter in Swift,
 including the bitwise operators and the arithmetic operators that ignore overflow.
*/
let fancyExpression: ArithmeticExpression<UInt64> = 2<<3|8&*(5&3)
/*:
 Use `FloatingPointArithmeticExpression` for expressions with operands of floating point types.
*/
let floatingPointExpression: FloatingPointArithmeticExpression<Double> = 1.5*2.0-4.5/3.0
/*:
 Animate the evaluation of an expression using `animateEvaluation(of:)`. The animation will be presented
 in the Playground's Live View, which is visible in the Assistant Editor.
*/
animateEvaluation(of: expression)
