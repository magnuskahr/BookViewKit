# BookViewKit

A simple BookView implemented in SwiftUI.

![](https://repository-images.githubusercontent.com/248848709/75dce300-6afa-11ea-87f0-4c1d4d4ceeb0)


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

> If an uneven number of content is provided, the last two pages will be the same

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


