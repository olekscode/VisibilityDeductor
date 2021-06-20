# VisibilityDeductor

Many modern programming languages do not have visibility specifiers (a.k.a access specifiers) such as `public`, `private`, or `protected`. However, even though they can not be marked as private at language level, some methods or classes in software libraries are only meant for the internal use and are not supposed to be used by clients. For the tools that analyse the API of software libraries, it can be useful to "infer" the visibility of methods or classes even if it is not defined explicitly. This repository contains a simple package that can deduce the visibility of packages, classes, and methods in [Pharo](https://pharo.org/) programming language.

## Packages that can be considered private

* **Test packages** - contain unit tests and mock classes used for testing. They are not meant to be reused by clients.
  * When split by `-`, the package name contains the word `Test` or `Tests` (e.g., `Files-Tests`, `Fuel-Tests-Core`)
* **Example packages** - contain examples of how to use specific functionality. Examples only exist for demonstration purposes and are not meant to be reused.
  * Package name ends with `-Example` or `-Examples` (e.g., `Athens-Examples`, `Clap-Examples`)
* **Baseline packages** - define the baselines of project (specify which packages belong to the project and how to load the dependencies).
  * Package name begins with `BaselineOf` (e.g., `BaselineOfBasicTools`)
* **Help packages** - define documentation pages
  * Package name ends with `-Help` (e.g., `Pharo-Help`, `FreeType-Help`)

## Classes that can be considered private

* **Classes that belong to a package which can be considered private**
* **Test classes** - define unit tests (note that tests classes may be located outside test packages)
  * Class inherits from `TestCase`
* **Example classes** - contain examples of how to use specific functionality
  * Class name begins or ends with a word `Example` (e.g., `CheckBoxExample`, `ExampleSlotWithState`)
* **Baseline classes** - classes that define the baselines projects
  * Class inherits from `BaselineOf`
* **Help classes** - define documentation pages
  * Class inherits from `CustomHelp` or `CustomHelp2`

## Methods that can be considered private

* **Method that belong to a class which can be considered private**
* **Methods that belong to a private protocol**
  * Protocol of the method contains a substring `private` (e.g., `private`, `private - primitives`, `evaluating-private`)
* **Example methods** - contain examples of how to use specific functionality
  * Method name begins with `example` or ends with either `Example` or `Example*` where `*` represents a number (e.g. `examplePrintf`, `example42`, `annotationExample3`, `menuActivationExample`)

## How to use it?

```Smalltalk
deductor := VisibilityDeductor new.

deductor isMethodPublic: Collection >> #do:. "true"
deductor isMethodPrivate: Collection >> #do:. "false"
deductor isMethodPrivate: Collection >> #emptyCheck. "true"
deductor isMethodPrivate: CollectionTest >> #testCopyWithoutDuplicates. "true"
deductor isMethodPrivate: StringTest >> #setUp. "true"

deductor isClassPublic: AthensSurfaceExamples. "false"
deductor isClassPrivate: AthensSurfaceExamples. "true"
deductor isClassPrivate: AnnouncementsHelp "true".

deductor isPackagePublic: 'RPackage-Tests' asPackage. "false"
deductor isPackagePrivate: 'RPackage-Tests' asPackage. "true"
```
