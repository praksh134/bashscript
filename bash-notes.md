
## Coprocesses

**Meaning**:
A **coprocess** is some more bash syntax sugar: it allows you to easily run a command asynchronously `(without making bash wait for it to end, also said to be "in the background")` and also set up some new file descriptor plugs that connect directly to the new command's input and output. You won't be using **coprocesses** too often, but they're a nice convenience for those times you're doing advanced things.

**Syntax**:
```syntax
coproc [ name ] command [ redirection ... ]
```

**Example**:
```bash
coproc auth { tail -n1 -f /var/log/auth.log; }
read latestAuth <&"${auth[0]}"
echo "Latest authentication attempt: $latestAuth"
```

**Explanation of example**:
The example starts an asynchronous `tail` command. While it runs in the background, the rest of the script continues. First the script reads a line of output from the coprocess called `auth` (which is the first line of the `tail` command output). Next, we write a message showing the latest authentication attempt we read from the coprocess. The script can continue and each time it reads from the coprocess pipe, it will get the next line from the `tail` command.

## Functions in single line

**Syntax**:
```syntax
 name () compound-command [ redirection ]
```

**Example**:
```bash
exists() { [[ -x $(type -P "$1" 2>/dev/null) ]]; }
exists gpg || echo "Please install GPG." <&2
```

**Explanation of example**:
You begin by specifying a `name` for your function. This is the name of your new command, you'll be able to run it later on by writing a simple command with that name.

After the command name go the `()` parentheses. Some languages use these parentheses to declare the arguments the function accepts: **bash does not**. The parentheses should always be empty. They simply denote the fact that you're declaring a function.

Next comes the compound command that will be executed each time you run the function.

To change the file descriptors of the script for the duration of running the function, you can optionally specify the function's custom file redirections.

## The `PATH`

We have all sorts of programs installed on our computer. Different programs are installed in different places. Some programs shipped with our **OS**, others were added by our distribution and yet others were installed by us or our systems administrator. On a standard UNIX system, there are [a few standardized locations](http://refspecs.linuxfoundation.org/fhs.shtml) for programs to go. Some programs will be installed in `/bin`, others in `/usr/bin`, yet others in `/sbin` and so on. It would be a real bother if we had to remember the exact location of our programs, especially since they may vary between systems. To the rescue comes the `PATH` **environment variable**. Your `PATH` variable contains a set of directories that should be searched for programs.

**Example**:
```bash
ping 127.0.0.1

PATH=/bin:/sbin:/usr/bin:/usr/sbin
           │     │
           │     ╰──▶ /sbin/ping ?  found!
           ╰──▶ /bin/ping ?  not found.
```

Bash honors this variable by looking through its listed directories whenever you try to to start a program it doesn't yet know the location of. Say you're trying to start the `ping` program which is installed at `/sbin/ping`. If your `PATH` is set to `/bin:/sbin:/usr/bin:/usr/sbin` then bash will first try to start `/bin/ping`, which doesn't exist. Failing that, it will try `/sbin/ping`. It finds the `ping` program, records its location in case you need `ping` again in the future and goes ahead and runs the program for you.

if you curious, where bash will find this command use `type` to find that command.
```bash
$ type ping
```

**output**:
```output
ping is /sbin/ping
```

# Important
**Note**: `PATH` is environment variable
```bash
PATH=~/bin:/usr/local/bin:/bin:/usr/bin
```

