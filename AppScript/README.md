# AppScript

This package contains Swinject containers to manage all dependencies of the app.

For now, we use [the modularizing pattern](https://github.com/Swinject/Swinject/blob/master/Documentation/Assembler.md) provided by Swinject framework that makes work with DI containers much more flexible. 

## Structure

- Any services we keep in the `ServicesAssembly`
- Any stores we keep in the `StoresAssembly`
- `ServicesAssembly` is a parent of `StoresAssembly`

To manage the behaviour of each object we use [the ability to change object scope](https://github.com/Swinject/Swinject/blob/master/Documentation/ObjectScopes.md) which gives us a lot of variants to organise our global dependencies script, that is why the package is called `AppScript`.

We have public access for all dependencies through next assemblers: `ServicesAssembler` and `StoresAssembler`. For example, we can resolve some registered object with commands:
```swift
StoresAssembler.shared.resolve(YourServiceOrStoreType.self)
ServicesAssembly.shared.resolve(YourServiceType.self)
```

## Features

We have `@Store` wrapper to make our life much more comfortable with injecting stores like `@StateObject` to the view layer. Consider the next code:

```swift
import AppScript

struct PageView: View {
    @Store var store: PageStore
    var body: some View { EmptyView() } 
}
```

