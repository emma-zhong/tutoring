#import "../../../61c_exam/lib.typ": *
#import "../../../61c_exam/questions/answer-box.typ": answer_box

= A Parentheses Gleam

#block(width: 100%, stroke: (left: 2pt), inset: 7pt)[
  *Adapted from:* Fall 2018 Final - Question 8 | *Level:* Regular
]

A `Nested(a)` value is either an `Atom` containing one value or a `Group`
containing a list of nested values. Implement `remove_parens`, which removes
all `Group` boundaries and returns the atoms from left to right.

`list.append(xs, ys)` returns a new list containing the elements of `xs`
followed by the elements of `ys`.

```gleam
import gleam/list

pub type Nested(a) {
  Atom(a)
  Group(List(Nested(a)))
}

pub fn remove_parens(s: List(Nested(a))) -> List(a) {
  case s {
    [] -> []
    [Group(items), ..rest] ->
      list.append(_______, _______)             // (a), (b)
    [Atom(value), ..rest] ->
      [_______, .._______]                      // (c), (d)
  }
}

assert remove_parens([
  Group([Group([Atom(1)]), Atom(2), Atom(3)]),
  Atom(4),
  Group([Atom(5), Group([Atom(6)])]),
]) == [1, 2, 3, 4, 5, 6]

assert remove_parens([
  Group([Atom("a"), Group([Atom("b"), Atom("c")])]),
  Group([]),
  Atom("d"),
]) == ["a", "b", "c", "d"]
```

#part(points: 3)[
  Fill in blanks (a) and (b).

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    answer_box(width: 100%, pre: [(a)#h(0.6em)])[`remove_parens(items)`],
    answer_box(width: 100%, pre: [(b)#h(0.6em)])[`remove_parens(rest)`],
  )
]

#part(points: 3)[
  Fill in blanks (c) and (d).

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    answer_box(width: 100%, pre: [(c)#h(0.6em)])[`value`],
    answer_box(width: 100%, pre: [(d)#h(0.6em)])[`remove_parens(rest)`],
  )
]

// Nested is generic so the same implementation works for integers, strings,
// or any other single atom type while preserving Gleam's homogeneous lists.
