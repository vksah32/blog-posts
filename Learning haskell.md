## Setup

Read instructions here: [HaskellStack:README](https://docs.haskellstack.org/en/stable/README/)

A simple hello world

```haskell
--file: hello.hs
main = do
	print "hello world"
```

To run it: (for mac, just use `stack`)

```bash
# to compile
stack ghc hello.hs

./hello # to run
"hello world"
```

#### Learning Resources

I looked into "learn you a haskell for greater good". found it lacking in terms of practical examples. I tried to follow `Haskell school of music` , but got lost in music concepts.

Now, following `Get programming with haskell` from Manning.

Chapter 1 -

- restrictions on a function:
	- A function must always take an argument.
	- A function must always return a value.
	- Calling the same function with the same argument must always return the same result.”

- Use of `where` to define a variable in a function

- Lambda functions- anonymous functions eg:

	```haskell
	(\x -> x*2) 2
	=> 4
	```
```
	
	




```

-- <--->-----



- look into category theory



## Haskell cookbook

- Chapter 1 : Setup

	```bash
	#create project
	stack new project_name
	
	#build it
	cd project_name
	# modify app/Main.hs 
	stack build
	
	#to run it
	stack exec -- project_name-exe
	```

	

- Chapter 2 : data types

	type class  = interface ? like `Num` and `Eq`

	data is more like a struct eg:

	```haskell
	data Something = Something { a :: Double, b :: Double} deriving Show
	```

	Called Type-constructor, data constructor and record syntax; note each field is a function which returns its value given data object so `a someQuadratic` will return `someQuadratic.a` / can also create anonymous fields ` data Something = Something Double Double`

	

	