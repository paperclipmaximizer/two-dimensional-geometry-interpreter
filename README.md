# two-dimensional-geometry-interpreter
Two implementations of an interpreter for a small language that can be used to describe two-dimensional geometry.


## The SML implementation...
The SML approach is written in a "functional style" meaning it makes use of functions and pattern-matching.

## The Ruby implementation...
The Ruby approach is implemented in an "object-oriented style" meaning it makes use of subclassing, methods, double-dispatch and dynamic dispatch, even where a functional style may be easier to understand.

The purpose is to demonstrate a clear understanding the differences between the two styles. The obvious implication is that the "right approach" would probably fall somewhere in the middle.

# Language features
The language is a small language that can be used to describe two-dimensional geometry. It supports the following features:
| | |
| --- | --- |
| `NoPoints` | The empty set of points. |
| `Point(x, y)` | A point in two-dimensional space. |
| `Line(p1, p2)` | A line between two points, represents slope: $y=mx+c$. |
| `VerticalLine(x)` | A infinite (in y-space) vertical line at the given x-coordinate. |
| `LineSegment(p1, p2, x, y)` | A finite line reoresented by x-/y- of its endpoints  |
| `Intersect(s1, s2)` | The intersection of two shapes, subexp evaluated in the same environment. |
| - - - | `NoPoints -> NoPoints` (if lines are parralel) |
| - - - | `-> Point(x, y)` (if lines intersect) |
| - - - | `-> Line(p1, p2, x, y)` (if lines overlap) |
| `Let (s1, s2)` | Evaluates first subexpression and binds it to a variable added to the environment of the next subexpression. |
| `Var (s)` | looks up a string in the environment and returns geometric value |
| `Shift(deltax, deltay, s)` | It evaluates the subexpression and shifts it by the given (deltax and deltay) amount. |
| - - - | `NoPoints -> NoPoints` |
| - - - | `Point(x, y) -> Point(x+deltax, y+deltay)` |
| - - - | `Line(p1, p2) -> Line(p1', p2')` |
| - - - | `VerticalLine(x) -> VerticalLine(x+deltax)` |
| - - - | `LineSegment(p1, p2, x, y) -> LineSegment(p1', p2', x+deltax, y+deltay)` |

* $ y=mx+c -> b+deltaY - m \cdot deltaX $


#### Note on Floats
Do not use equality signifiers on floats. Instead use a tolerance value to determine if two floats are equal. This is because floats are not stored as exact values, but as approximations. This means that two floats that should be equal may not be equal when compared using the equality signifier.

#### Expressional Preprocessing
The expressions are preprocessed, and simplified, in the case of `LineSegement` that violate the following invariants:
- Line segments that have similar endpoints as their segment points are converted to a point.
-  Line segments that have first end-points smaller than the second end-point are swapped.

