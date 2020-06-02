## Setup

Read instructions here: [HaskellStack:README](https://docs.haskellstack.org/en/stable/README/)

A simple hello world

```haskell
--file: hello.hs
main = do
	print "hello world"
```

To run it:

```bash
# to compile
stack ghc hello.hs

./hello # to run
"hello world"
```

