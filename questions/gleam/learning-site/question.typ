#import "../../../61c_exam/lib.typ": *
#import "../../../61c_exam/questions/answer-box.typ": answer_box

= Online Learning Site

#block(width: 100%, stroke: (left: 2pt), inset: 7pt)[
  *Adapted from:* Spring 2021 - Midterm 2 - Question 5 | *Level:* Regular
]

An online learning site is described by the `LearningSite` record, which keeps track
of the following information:

- `catalog`: a dictionary of the published content, keyed by title
- `watched`: a list of `Content` records that students have opened, in the
  order they opened them. The first element is the first content viewed.
- `missing`: a list of titles that students asked for but could not be found. The
  most recently searched title should be at the front of the list.

Both exercises and videos have a title and an author, so they share a `Details`
record. Additionally, the `watched` and `missing` lists may contain duplicates if content
is viewed or searched more than once.

```gleam
import gleam/dict.{type Dict}
import gleam/int
import gleam/list

pub type Details {
  Details(title: String, author: String)
}

pub type Content {
  Exercise(details: Details, num_questions: Int)
  Video(details: Details, num_seconds: Int)
}

pub type LearningSite {
  LearningSite(
    catalog: Dict(String, Content),
    watched: List(Content),
    missing: List(String),
  )
}

pub fn description(content: Content) -> String {
  case content {
    Exercise(details, _) -> details.title <> " by " <> details.author
    Video(details, seconds) ->
      details.title <> " by " <> details.author
      <> " (" <> int.to_string(seconds) <> " seconds)"
  }
}
```

Implement the following functions for the online learning site:

- `fn publish(s: LearningSite, content: Content) -> LearningSite`: adds `content` to the `LearningSite` catalog
- `fn view(s: LearningSite, title: String) -> LearningSite`: a student views the content with `title`. If the
  catalog has this content, add the content object to the end of the watched list. If not, add the title
  to the front of the missing list.
- `fn watch_list(s: LearningSite) -> List(String)`: return the description of each watched content,
  in the order watched.
- `fn count_videos(s: LearningSite) -> Int`: return how many of the watched contents are videos. A video
  that was watched twice counts twice.

`list.append(xs, ys)` returns a new list containing the elements of `xs`
followed by the elements of `ys`.

```gleam
let cs61a = LearningSite(dict.new(), [], [])
let recursion = Exercise(Details("Recursion", "Chris D"), 5)
let efficiency = Video(Details("Efficiency", "Kay O"), 881)

let cs61a = publish(cs61a, recursion)
let cs61a = publish(cs61a, efficiency)
assert dict.get(cs61a.catalog, "Recursion") == Ok(recursion)

let cs61a = view(cs61a, "Efficiency")
let cs61a = view(cs61a, "LinkedLists")
let cs61a = view(cs61a, "Efficiency")
let cs61a = view(cs61a, "Recursion")
let cs61a = view(cs61a, "Mutability")
let cs61a = view(cs61a, "Efficiency")
assert cs61a.watched == [efficiency, efficiency, recursion, efficiency]
assert cs61a.missing == ["Mutability", "LinkedLists"]

assert watch_list(cs61a)
  == [
    "Efficiency by Kay O (881 seconds)",
    "Efficiency by Kay O (881 seconds)",
    "Recursion by Chris D",
    "Efficiency by Kay O (881 seconds)"
  ]

assert count_videos(cs61a) == 3
```

```gleam
pub fn publish(s: LearningSite, content: Content) -> LearningSite {
  LearningSite(..s, catalog: _______)                    // (a)
}

pub fn view(s: LearningSite, title: String) -> LearningSite {
  case _______ {                                         // (b)
    Ok(content) -> _______                               // (c)
    Error(Nil) -> _______                                // (d)
  }
}

pub fn watch_list(s: LearningSite) -> List(String) {
  _______                                                // (e)
}

pub fn count_videos(s: LearningSite) -> Int {
  list.length(
    list._______(_______, _______ {                      // (f), (g), (h)
      case _______ {                                     // (i)
        _______                                          // (j)
        _______                                          // (k)
      }
    }),
  )
}
```

#part(points: 1)[
  Fill in blank (a).

  #answer_box(width: 100%)[`dict.insert(s.catalog, content.details.title, content)`]
]

#part(points: 1)[
  Fill in blank (b).

  #answer_box(width: 90%)[`dict.get(s.catalog, title)`]
]

#part(points: 1)[
  Fill in blank (c).

  #answer_box(width: 100%)[`LearningSite(..s, watched: list.append(s.watched, [content]))`]
]

#part(points: 1)[
  Fill in blank (d).

  #answer_box(width: 90%)[`LearningSite(..s, missing: [title, ..s.missing])`]
]

#part(points: 1)[
  Fill in blank (e).

  #answer_box(width: 90%)[`list.map(s.watched, description)`]
]

#part(points: 3)[
  Fill in blanks (f), (g), and (h).

  #grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 1em,
    answer_box(width: 100%, pre: [(f)#h(0.6em)])[`filter`],
    answer_box(width: 100%, pre: [(g)#h(0.6em)])[`s.watched`],
    answer_box(width: 100%, pre: [(h)#h(0.6em)])[`fn(content)`],
  )
]

#part(points: 1)[
  Fill in blank (i).

  #answer_box(width: 70%)[`content`]
]

#part(points: 2)[
  Fill in blanks (j) and (k).

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    answer_box(width: 100%, pre: [(j)#h(0.6em)])[`Video(_, _) -> True`],
    answer_box(width: 100%, pre: [(k)#h(0.6em)])[`Exercise(_, _) -> False`],
  )
]
