# Nim toolchain for RG35xx GarlicOS

This lets you compile your [Nim](https://nim-lang.org/) programs using the same C compiler everyone else uses for GarlicOS.

Based on [this docker image](https://github.com/edemirkan/rg35xx-toolchain).

# Usage

In your nimble file, create a task kind of like this:

```nim
import os

task release, "Build a release though the docker toolchain.":
  let
    nimbleCmd = join([
      "nimble build",
      "-y",
      "-l",
      "-d:release",
      "-d:strip",
      "--opt:speed",
      "--cpu:arm",
      "--os:linux",
      "--arm.linux.gcc.exe:$CC",
      "--arm.linux.gcc.linkerexe:$CC",
    ]," ")
    dockerCmd = join([
      "docker run -it --rm -v ", 
      thisDir() & ":/root/workspace",
      "mihara/nim-rg35xx-toolchain", 
      "/bin/bash -ic '" & nimbleCmd & "'",
    ]," ")

  echo "=== Building for RG35XX..."
  echo dockerCmd
  exec(dockerCmd)
  echo "Done."
```

`nimble release` will then build you an executable for RG35XX which you can then `adb push` where it needs to go.

Be sure to add `nimpkgs` to your `.gitignore`.

# License

Srsly? WTFPL.
