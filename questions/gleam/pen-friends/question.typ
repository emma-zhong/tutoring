#import "../../../61c_exam/lib.typ": *
#import "../../../61c_exam/questions/answer-box.typ": answer_box

= Making Pen Friends!

#block(width: 100%, stroke: (left: 2pt), inset: 7pt)[
  *Adapted from:* Spring 2026 - Midterm 2 - Question 5 | *Level:* Challenge
]

A `Pen` has a name and a dict that maps each animal's name to its `Animal`
record. An `Animal` has a unique name and a list of the names of its friends.
Two animals may only become friends if they are in the same pen. When they do,
each one's name is added to the front of the other's list of friends.

Implement `add_animal`, which returns a new pen that also holds an animal named
`name` with no friends. Then implement `befriend`, which returns `Ok` of a new
pen in which the animals named `a` and `b` are friends, or an `Error` if either
animal is not in `pen`.

```gleam
import gleam/dict.{type Dict}

pub type Animal {
  Animal(name: String, friends: List(String))
}

pub type Pen {
  Pen(name: String, animals: Dict(String, Animal))
}

pub fn add_animal(pen: Pen, name: String) -> Pen {
  Pen(..pen, animals: _______)                                    // (a)
}

pub fn befriend(pen: Pen, a: String, b: String) -> Result(Pen, String) {
  case _______, _______ {                                         // (b), (c)
    Ok(x), Ok(y) -> {
      let new_x = Animal(..x, friends: _______)                   // (d)
      let new_y = Animal(..y, friends: [a, ..y.friends])
      Ok(Pen(..pen, animals: _______))                            // (e)
    }
    _, _ -> Error("Cannot befriend an animal that doesn't share a pen!")
  }
}

let my_pen = add_animal(add_animal(Pen("coop", dict.new()), "Alice"), "Clarice")
let other_pen = add_animal(Pen("barn", dict.new()), "Bob")
assert dict.get(other_pen.animals, "Bob") == Ok(Animal("Bob", []))
assert befriend(my_pen, "Clarice", "Bob")
  == Error("Cannot befriend an animal that doesn't share a pen!")
assert befriend(my_pen, "Clarice", "Alice")
  == Ok(Pen("coop", dict.from_list([
    #("Alice", Animal("Alice", ["Clarice"])),
    #("Clarice", Animal("Clarice", ["Alice"])),
  ])))
```

#part(points: 1)[
  Fill in blank (a).

  #answer_box(width: 100%)[`dict.insert(pen.animals, name, Animal(name, []))`]
]

#part(points: 2)[
  Fill in blanks (b) and (c).

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    answer_box(width: 100%, pre: [(b)#h(0.6em)])[`dict.get(pen.animals, a)`],
    answer_box(width: 100%, pre: [(c)#h(0.6em)])[`dict.get(pen.animals, b)`],
  )
]

#part(points: 1)[
  Fill in blank (d).

  #answer_box(width: 70%)[`[b, ..x.friends]`]
]

#block(breakable: false)[
  #part(points: 2)[
    Fill in blank (e).

    #answer_box(width: 100%)[`dict.insert(dict.insert(pen.animals, a, new_x), b, new_y)`]
  ]
]

#part(points: 1)[
  In the original Python version, `befriend` changed both animals in place.
  After `befriend(my_pen, "Clarice", "Alice")` above, what does
  `dict.get(my_pen.animals, "Alice")` evaluate to?

  #answer_box(width: 70%)[`Ok(Animal("Alice", []))`]
]

// Gleam records cannot point back to their pen, so the pen holds its animals by
// name and "sharing a pen" means both names are keys of the same dict. The
// original's inheritance parts (Chicken, BabyChick) are left out because Gleam
// has no inheritance. befriend returns a new pen, so my_pen is unchanged.
