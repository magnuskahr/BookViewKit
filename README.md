# BookViewKit

A simple BookView implemented in SwiftUI.

## Usage

A `BookView` takes an array of `Identifiable`  along with a builder that produces a `View`.
Lets define a Quote-struct: 

```
struct Quote: Identifiable {
    let id: UUID().uuidString
    let quote: String
    let author: String
}
```

Create an arrays of quotes, and then use `BookView` like so:

```
let book = BookView(content: quotes) { data in
    VStack {
        Text(data.content.quote)
        Text(data.content.author).bold()
    }
}
```

A basic gradient is also provided for the pages:
```
let book = BookView(content: quotes) { data in
    ZStack {
        VStack {
            Text(data.content.quote)
            Text(data.content.author).bold()
        }
        PageGradient(placement: data.placement)
    }
}
```

