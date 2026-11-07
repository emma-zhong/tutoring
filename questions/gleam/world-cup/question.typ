#import "../../../61c_exam/lib.typ": *
#import "../../../61c_exam/questions/answer-box.typ": answer_box

= World Cup Efficiency

#block(width: 100%, stroke: (left: 2pt), inset: 7pt)[
  *Adapted from:* Summer 2026 - Final - Question 6.4 | *Level:* Challenge
]

Implement `count_duplicate_evens`, which returns how many different even
integers appear more than once in `scores`. It goes through `scores` only once.

Its helper `count_from` keeps `counts`, which maps each even score seen so far
to the number of times it has appeared, and `total`, the number of even scores
that have appeared more than once so far.

```gleam
import gleam/dict.{type Dict}

pub fn count_duplicate_evens(scores: List(Int)) -> Int {
  count_from(scores, dict.new(), 0)
}

fn count_from(scores: List(Int), counts: Dict(Int, Int), total: Int) -> Int {
  case scores {
    [] -> _______                                         // (a)
    [score, ..rest] if score % 2 != 0 -> count_from(rest, counts, total)
    [score, ..rest] -> {
      let seen = case _______ {                          // (b)
        Ok(n) -> n
        Error(Nil) -> 0
      }
      let new_total = case _______ {                     // (c)
        True -> total + 1
        False -> total
      }
      count_from(rest, _______, new_total)               // (d)
    }
  }
}

assert count_duplicate_evens([1, 5, 8, 8, 12]) == 1
assert count_duplicate_evens([4, 3]) == 0
assert count_duplicate_evens([1, 1, 4]) == 0
assert count_duplicate_evens([2, 2, 2, 1, 4, 4]) == 2
```

#part(points: 1)[
  Fill in blank (a).

  #answer_box(width: 70%)[`total`]
]

#part(points: 1)[
  Fill in blank (b).

  #answer_box(width: 70%)[`dict.get(counts, score)`]
]

#part(points: 2)[
  Fill in blank (c).

  #answer_box(width: 70%)[`seen == 1`]
]

#part(points: 2)[
  Fill in blank (d).

  #answer_box(width: 70%)[`dict.insert(counts, score, seen + 1)`]
]

#part(points: 1)[
  What does `count_duplicate_evens([6, 6, 6])` return?

  #answer_box(width: 40%)[1]
]

// The original Python solution counted every even score in a dict, then looped
// over the dict to count values above 1. Looping over a Gleam dict needs
// functions the course has not taught, so this version counts a duplicate at
// the moment an even score is seen for the second time. A third copy finds
// seen == 2 and does not count again.
