#import "../../../61c_exam/lib.typ": *

#metadata("gleam-reference") <titled-question>

#align(center)[
  #text(size: 15pt, weight: "bold")[Gleam Reference]
]

#block(width: 100%, stroke: (left: 2pt), inset: 7pt)[
  This page summarizes the Gleam features used in this worksheet. Types are
  capitalized, function bodies end with the expression they return, and values
  are immutable.
]

#grid(
  columns: (1fr, 1fr),
  gutter: 14pt,
  [
    *Functions and types*

    ```text
    pub fn square(x: Int) -> Int {
      x * x
    }

    pub fn twice(f: fn(a) -> a, x: a) -> a {
      f(f(x))
    }
    ```

    `a` is a type variable. For example, `List(a)` means a list whose elements
    all have the same type, whatever that type is.

    Anonymous functions use `fn`:

    ```text
    fn(x) { x + 1 }
    ```

    Define named recursive helpers at the top level, not inside another
    function. A recursive call is tail recursive when its result is returned
    directly, with no remaining operation.

    *Operators*

    - Arithmetic: `+`, `-`, `*`, `/`, `%`
    - Comparison: `==`, `!=`, `<`, `<=`, `>`, `>=`
    - Boolean: `&&`, `||`, `!`
    - Strings: `<>` joins two strings

    *Custom types and records*

    ```text
    pub type Shape {
      Circle(name: String, radius: Int)
      Square(name: String, side: Int)
    }

    pub type Box(a) {
      Box(label: String, item: a)
    }
    ```

    `Circle` and `Square` are the variants of `Shape`. Call a variant to make
    a value, such as `Square("tile", 2)`.

    `Box(a)` has a type variable `a`, so `Box("n", 7)` has type `Box(Int)`.

    `shape.name` works because every variant has `name` in the same position
    with the same type. For other fields, use `case`:

    ```text
    case shape {
      Circle(_, r) -> 2 * r
      Square(_, s) -> s
    }
    ```

    In a pattern, `_` ignores one field, and `..` ignores the rest, as in
    `Square(..)`.

    `Box(..b, item: 8)` is a record update: a new `Box` with the same fields as
    `b` except `item`. `b` itself is unchanged.
  ],
  [
    *Case expressions and patterns*

    ```text
    case n {
      0 -> "zero"
      _ if n < 0 -> "negative"
      _ -> "positive"
    }
    ```

    A `case` can match multiple subjects: `case x, y { ... }`. The `_` pattern
    matches any value, and `if` adds a guard to a pattern.

    *Lists*

    ```text
    case s {
      [] -> []
      [first, ..rest] -> [first, ..rest]
      [a, b, ..tail] -> [a, b, ..tail]
    }
    ```

    - `[]` is empty.
    - `[first, ..rest]` splits a non-empty list.
    - `[first, ..rest]` also constructs a new list.
    - `#(x, y)` is a two-element tuple.

    Useful standard-library functions:

    - `list.append(xs, ys)` joins two lists.
    - `list.map(xs, f)` applies `f` to each value.
    - `list.filter(xs, keep)` keeps values satisfying `keep`.
    - `list.length(xs)` returns a list's length.
    - `int.absolute_value(n)` returns an integer's absolute value.
    - `int.to_string(n)` converts an integer to a string.

    Import their modules with `import gleam/list` or `import gleam/int`.

    *Results and dicts*

    `Result(value, error)` has two variants: `Ok(value)` for success and
    `Error(error)` for failure. `Nil` is a value that holds no information.

    `import gleam/dict.{type Dict}` lets you write `Dict(k, v)`, a dict with
    keys of type `k` and values of type `v`. Dicts are immutable.

    - `dict.new()` is an empty dict.
    - `dict.from_list(pairs)` builds a dict from a list of `#(k, v)` tuples.
    - `dict.insert(d, k, v)` returns a new dict where `k` maps to `v`.
    - `dict.get(d, k)` returns `Ok(v)` if `k` maps to `v`, or `Error(Nil)` if
      `k` is not a key.
  ],
)
