# Demo project for Swift Coders LA & Learn swift LA Meetups 20-May-2020

This project demostrates how to create a `@propertyWrapper` and how to make use of the `projectedValue`s for `@State`, `@Binding`, `@ObservedObject` and `@Published`.

Key takeaways:

* property wrappers have three components:
  * a `wrappedValue` (required)
  * a `projectedValue` (optional)
  * a initializer that takes a `wrappedValue` or an `@autoclosure wrappedValue`

* property wrappers have three forms of syntactic sugar.  For example with `@Rounded var number = 1.0`:
  * `number` refers to the `wrappedValue`
  * `$number` refers to the `projectedValue`
  * `_number` refers to the instance of the `Rounded` `struct`

* The projected values for `@State` and `@Binding` are `Binding`s
* The projected values for `@ObservedObject` and `@EnvironmentObject` are `Wrappers` that vend a `Binding` by dynamic memeber lookup of a keyPath


