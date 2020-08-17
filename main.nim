import std/sugar
import std/with
import std/options
import std/strutils
import std/strformat
from std/unicode
  import toRunes, toUTF8, reversed
import console/console
import console/consoleutils
import timecode


# --------------------------------------------------------
# learning nim!
# --------------------------------------------------------
echo "\nLearning Nim!!!"
writeHorizontalFill()
writeHorizontalFill("N I M / ")
writeHorizontalFill()


# --------------------------------------------------------
echo "\n- string and array -"
# --------------------------------------------------------
# fromat string
# --------------------------------------------------------
block:
  let
    hello = "   Hello Nim!   "
    someFloat = 0.123456
  
  echo "someString: " & hello.strip() & "\nsomeFloat: " & someFloat.formatFloat(ffDecimal, 3) & "\n"
  echo &"someString: {hello.strip()}\nsomeFloat: {someFloat.formatFloat(ffDecimal, 3)}\n"

# --------------------------------------------------------
# get each runes
# --------------------------------------------------------
block:
  stdout.write "write unicode string: "
  for i, s in consoleReadLine().toRunes(): # unicode module
    echo &"{i}: {s}"

# --------------------------------------------------------
# reverse string
# --------------------------------------------------------
block sol1:
  let input = "Hello world!"
  var output: string
  for i in countdown(input.high, 0): output.add input[i]
  echo output

block sol2:
  let input = "Hello world!"
  var output: string
  for c in input: output = c & output
  echo output

block sol3:
  let input = "Hello world!"
  var output = newString input.len
  for i, c in input: output[output.high - i] = c
  echo output

block sol4:
  let input = "Hello world!"
  let output = input.reversed # unicode module
  echo output

# --------------------------------------------------------
# array slice
# --------------------------------------------------------
block:
  var someArray = "Hello world!"
  var someArray2 = someArray[0 .. ^5]
  var someArray3 = someArray[0 .. 3] & someArray[7 .. 10]

  for i in someArray: stdout.write i
  echo ""
  for i in someArray2: stdout.write i
  echo ""
  for i in someArray3: stdout.write i
  echo ""
# --------------------------------------------------------
writeHorizontalFill()


# --------------------------------------------------------
echo "\n- loop -"
block:
# --------------------------------------------------------
# while
# --------------------------------------------------------
  echo "while loop"
  while true:
    echo "break"
    break
  
  echo ""

# --------------------------------------------------------
# for
# --------------------------------------------------------
  echo "classic for loop"
  for i in 0..<10:
    echo i
  
  echo ""

  echo "for each"
  for i, item in @[1, 3, 5, 4, 6]:
    echo &"[{i}]: {item}"
  
  echo ""

  for k, v in items(@[(person: "You", power: 100), (person: "Me", power: 9000)]):
    echo &"{k}: {v} power."
# --------------------------------------------------------
writeHorizontalFill()


# --------------------------------------------------------
echo "\n- time -"
block:
# --------------------------------------------------------
# simple benchmark
# --------------------------------------------------------
  let fibbNum = consoleReadLineParse(parseInt, "fibbonacci num: ")

  proc fibbonacci(n: int): int =
    if n <= 1: n else: fibbonacci(n - 1) + fibbonacci(n - 2)

  timeCode: echo &"fibbonacci {fibbNum} = {fibbonacci fibbNum}"
# --------------------------------------------------------
writeHorizontalFill()


# --------------------------------------------------------
echo "\n- std macro -"
block:
# --------------------------------------------------------
# with
# --------------------------------------------------------
  var parsed = consoleReadLineParse(parseFloat, "write any number: ")
  with parsed:
    stdout.write " + 8 = "
    += 8
    echo
    stdout.write " - 20 = "
    -= 20
    echo
    stdout.write " * 2 = "
    *= 2
    echo
    stdout.write " / 3 = "
    /= 3
    echo

# --------------------------------------------------------
# collect
# --------------------------------------------------------
  let randomInts = [1, 21, 312, 12, 10, 14, 45]
  let oddSeq = collect newSeq:
    for i in randomInts:
      if i mod 2 != 0:
        i

  echo &"\nGet Odd Numbers from {randomInts}"
  echo &"result: {oddSeq}"
# --------------------------------------------------------
writeHorizontalFill()


# --------------------------------------------------------
echo "\n- tuple -"
block:
  # 주소 예시 소스: https://dorojuso.kr/서울특별시/서대문구/홍은제1동?page=67
  var homeAddress: tuple[street: string, buildingNumber: int, buildingName: string] = (
    street: "홍지문길",
    buildingNumber: 7,
    buildingName: "대진하이츠빌라"
  )
  echo &"{homeAddress.street} {homeAddress.buildingNumber} {homeAddress.buildingName}\n"

  echo "Value swap using Tuple:"
  var
    a = 10
    b = 20
  echo &"a = {a}, b = {b}"
  (a, b) = (b, a)
  echo &"a = {a}, b = {b}"
# --------------------------------------------------------
writeHorizontalFill()


# --------------------------------------------------------
echo "\n- defer -"
block:
  defer: 
    echo "#1.1 defer"
    echo "#1.2 defer"
  defer:
    echo "#2.1 defer"
    echo "#2.2 defer"
  defer:
    echo "#3.1 defer"
    echo "#3.2 defer"
# --------------------------------------------------------
writeHorizontalFill()


# --------------------------------------------------------
echo "\n- template -"
block:
  template test() =
    defer: echo "template defer"

  proc testProc() =
    defer: echo "proc defer"

  echo "Template Copy Pastes code"

  defer: echo "#1 defer"
  test()
  testProc()
  defer: echo "#2 defer"
# --------------------------------------------------------
writeHorizontalFill()


# --------------------------------------------------------
echo "\n- proc & func -"
block:
  echo "proc & func can be nested:"
  proc outerProc() =
    proc innerProc() =
      echo "inner proc"
    echo "outer proc"
    innerProc()
  
  outerProc()

  echo "\nfunc can't have side effect but can still change the var(c#: ref) parameter:"
  var someNumber = 10
  echo &"someNumber: {someNumber}"
  func noSideEffectProc(param: var int) =
    param = 100
  
  noSideEffectProc(someNumber)
  echo &"someNumber: {someNumber}"
# --------------------------------------------------------
writeHorizontalFill()


# --------------------------------------------------------
echo "\n- lambda -"
block:
  proc lambdaTest(lambdaProc: () -> string, b: int) =
    echo lambdaProc()
  
  echo "Singleline Lambda:"
  lambdaTest(proc: string = "Lambda Return value", 10)
  lambdaTest(() => "Lambda Return value (sugar)", 10)
  
  echo "\nMultiline Lambda:"
  lambdaTest(
    proc: string =
      echo "Lambda echo"
      if true: 
        "Lambda Return value"
      else:
        "Nope",
    10
  )
  lambdaTest(
    () => ( 
      block: 
        echo "Lambda echo (sugar) "
        if true: 
          "Lambda Return value (sugar)"
        else:
          "Nope"
    ),
    10
  )
  # when using a sugar syntax
  # () => (block: ...)
  #       ^^^^^^^^^^^^
  #       |
  #       this is necessary for the multi line code.
# --------------------------------------------------------
writeHorizontalFill()


# --------------------------------------------------------
echo "\n- options -"
block:
  proc find(text: string, toFind: char): Option[int] =
    for i, c in text:
      if c == toFind:
        return some(i)
    return none(int)  # This line is actually optional,
                      # because the default is empty
  
  var found = "abc".find('c')
  if found.isSome:
    echo found.get()
    found = none(int) # <- Sets the option to none.
  
  # echo found.get() # <- Exception because found is none.
# --------------------------------------------------------
writeHorizontalFill()


#---------------------------------------------------------
# enum
#---------------------------------------------------------
echo "\n- enums -"
block:
  type SomeEnum = enum
    A = 0,
    B = 2,
    C = 3

  proc hasOrd(T: typedesc[enum], i: int): bool {.inline.} =
    try: result = $T(i) != &"{i} (invalid data!)"
    except: result = false

  proc enumRange[T: enum](): Slice[int] {.inline.} = result = T.low.ord .. T.high.ord

  for i in enumRange[SomeEnum]():
    if not SomeEnum.hasOrd(i): continue
    stdout.write SomeEnum(i)
# --------------------------------------------------------
writeHorizontalFill()

# --------------------------------------------------------
echo "\n- object -"
# --------------------------------------------------------
# value and reference type
# --------------------------------------------------------
block:
  type
    # value type
    Person = object
      name: string
      age: int
    
    # reference type
    PersonRef = ref Person
  
  proc setNameAndAge(
      preson: var Person,
      name: typeof(preson.name),
      age: typeof(preson.age)
    ) =
    preson.name = name;
    preson.age = age;
  
  proc setNameAndAge(
      preson: PersonRef,
      name: typeof(preson.name),
      age: typeof(preson.age)
    ) =
    preson.name = name;
    preson.age = age;

  var personA = Person(name: "A", age: 10)
  var personB = Person(name: "B", age: 20)
  var personRefA = PersonRef(name: "A", age: 10)
  var personRefB = PersonRef(name: "B", age: 20)
  
  var presonSeq = newSeq[Person]()
  var presonRefSeq = newSeq[PersonRef]()
  presonSeq.add([personA, personB])
  presonRefSeq.add([personRefA, personRefB])
  
  echo "Person Seq:"
  for person in presonSeq: echo &"name: {person.name}, age: {person.age}"
  echo "PersonRef Seq:"
  for person in presonRefSeq: echo &"name: {person.name}, age: {person.age}"
  
  # Modify original data
  personA.setNameAndAge("WOW_A", 100)
  personB.setNameAndAge("WOW_B", 200)
  personRefB.setNameAndAge("WOW_RefB", 200)
  personRefB.setNameAndAge("WOW_RefB", 200)
  echo "\nAfter modifing the original objects...\n"

  echo "Person Seq:"
  for person in presonSeq: echo &"name: {person.name}, age: {person.age}"
  echo "PersonRef Seq:"
  for person in presonRefSeq: echo &"name: {person.name}, age: {person.age}"

  echo "\nAfter setting the refs to nil...\n"
  
  # In order to "free" ref object you need to nullify every referances. (just like C# class objects.)
  personRefA = nil;
  personRefB = nil;
  for i in 0 ..< presonRefSeq.len: presonRefSeq[i] = nil
  
  echo "PersonRef Seq:"
  for person in presonRefSeq: 
    if person != nil:
      echo &"name: {person.name}, age: {person.age}"
    else:
      echo "nil"

# --------------------------------------------------------
# method overloading
# --------------------------------------------------------
type
  A = ref object of RootObj
  B = ref object of A

method say(a1, a2: A) {.base.} = echo "aa"
method say(a: A, b: B) {.base.} = echo "ab"

method say(b1, b2: B) = echo "bb"
method say(b: B, a: A) = echo "ba"

let a = A()
let b = B()
a.say(b) # -> ab
b.say(b) # -> ab
# --------------------------------------------------------
writeHorizontalFill()


# --------------------------------------------------------
echo "\n- file read & write -"
block:
  let textFile = open( "./test.txt", FileMode.fmReadWrite)
  defer: close textFile

  textFile.write:
    """
    <Nim: Hello World>
    import std/strformat
    
    let hello = "hello"
    let world = "world"
    
    if true
    ··stdout.write hello
    ··stdout.write &"{world}\n"
    """.unindent().replace(r"··", "  ")
  
  textFile.write:
    """
    
    <나비보벳따우 가사>
    나비보벳따우 봅 보벳띠 보빗 따우
    나비보벳따우 봅 보벳띠 나비벳 뽀
    휘휘휘휘휘휘휘~ 빗뽀벳 뻬~뺘빗뽀
    """.unindent()

  textFile.setFilePos(0) # <- This is nessesary because readAll() start from the current file position.
  echo textFile.readAll()
# --------------------------------------------------------
writeHorizontalFill()

