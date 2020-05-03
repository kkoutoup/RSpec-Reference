# RSpec-Reference
A reference for writing and running tests with RSpec for Ruby

## Purpose
Putting this together as I'm learning TDD with Ruby and RSpec

## File structure
```
lib
  |__file_name.rb
spec
  |__file_name_spec.rb
```

## Flags
The following flags should follow the name of your spec file i.e. my_spec.rb --color

`--c color` or `-c`                     applies green/red color for successful/failing tests

`--no-color`                            tests don't have color

`--format progress` or `-f p`           progress is shown as one dot (.) assinged for each test that 
passes or one 'F' for each failing test

`--format documentation` or `-f d`      detailed decriptions for each test

`--order random`                        runs tests in random order

`--profile` or `-p`                     gives timings for slowest examples

`--fail fast`                           stops at first failing test

`:line_number`                          i.e. my_spec:3 will run tests for code on line 3
