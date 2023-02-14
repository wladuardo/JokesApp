import UIKit

var greeting = "Hello, playground"
var nubmer = 0

let closure = { [nubmer] in
  print("Number is \(nubmer)")
}

nubmer += 1

closure()
