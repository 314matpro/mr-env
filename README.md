## Basic Environment

### Setup

Modify `~/.bashrc`, adding the following
```
MR_ENV_BASH="/path/to/this/repo"
export PATH="${PATH}:${MR_ENV_BASH}"

if [ -f "${MR_ENV_BASH}/.shell.init" ]; then
	source .shell.init
fi
```

Re-source `~/.bashrc` or restart your shell to pick up the latest commands
```
source ~/.bashrc
```

### Basic Features

#### Source-able "plugins"

##### `.colors` - Color/formatting library

This library allows for formatted (with colors) echos

Example in a script being used (`test-script`)
```
#!/bin/bash

. .colors

echo -e "${red}some red text${none} in front of non-colored text"
```

These colors can be disabled automatically by calling `noformat` prior in the command

Example using script file above (`test-script`) where no colors are added
```
noformat ./test-script
```

##### `.errors` - Error handling

If you have commands that need executed without errors as prerequisite calls to other commands, you can use `execute` to force errors from exiting the current script

Example script (`test-script`)
```
#!/bin/bash

. .errors

execute some other "command with its value"
execute another command
```

If `some other "command with its value"` fails by return code in `$?`, then the entire scripts exits with the return code and a failure message outputted to `stderr`, without ever executing the following `another command`

##### `.info` - Basic script information

A plugin that provides some basic information useable by the script
- `script_path`: the canonical path to this script (including the script itself in the path)
- `script_dir`: the canonical path to the directory parent of this script
- `script_name`: the file name of this cript

An example script using `.info` to call another script in the same directory:
```
#!/bin/bash

. .info

"${script_dir}/some-other-script-in-the-same-directory"
```

##### `.cmd`/`.lib` - Command scripts/libraries

Commands are intended to have some basic information for listing in menus of a library, and consistency for users to get information

Every command should have the following variables defined:
`args` provides information about what arguments the command accepts
`description` provides a description of the purpose of the script

Example script:
```
#!/bin/bash

args="<arg 1> [<optional arg 2>]"
description="Does stuff"

. .cmd

# Do stuff
```

Libraries are a directory of sub-commands/libraries with a root script

- `lib1` (sources .lib)
- `.lib1` (directory)
  - `subcmd2` (sources .cmd)
  - `sublib3` (sources .lib)
  - `.sublib3` (directory)
    - `subsubcmd4` (sources .cmd)

This allows you to call commands like so
- `lib1` displays a menu listing out it's children
```
subcmd2 - <args> - <description>
sublib3 - .. - <description>
```
- `lib1 subcmd2` executes `subcmd2`
- `lib1 sublib3` displays a menu listing out it's children
```
subsubcmd4 - <args> - <description>
```
- `lib1 sublib3 subsubcmd4` executes `subsubcmd4`

## Enhanced Environment

### Setup

More notes to come