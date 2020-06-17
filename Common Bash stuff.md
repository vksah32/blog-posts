# Common terminal/bash stuff

- Use shellcheck for automatic checking. See [koalaman/shellcheck](https://github.com/koalaman/shellcheck)

- Check existence of a file

  ```bash
  [ -f "somefile.txt"] || { echo "file doesn't exist"; exit 1; }
  ```

- Check existence of a directory

  ```bash
  [ -d "some/dir"] || { echo "directory doesn't exist"; exit 1; }
  ```

- Check existence of a program

```bash

[ -x "$(command -v some-program)" ] || { echo "program not installed"; exit 1; }

```

- functions

  ```bash
  function somefunc() {
   #takes parameters
   # does something
  
  }
  
  somefunc "$@" #invoke somefunc and pass all commandline parameters
  ```

  

- Check number of arguments 

```bash
  if [ "$#" -ne 1 ]; then
      printf "Invalid number fo parameters\n"
      exit 1
  fi

```

other comparators:  `-eq`, `-ne`, `-lt`, `-le`, `-gt`, or `-ge`



### ssh stuff

- Start ssh-agent process

	```bash
	eval `ssh-agent -s`
	```

- Add a key to ssh-agent

	```bash
	ssh-add ~/.ssh/id_rsa
	```

	

