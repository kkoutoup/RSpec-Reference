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
The following flags should follow the name of your spec file i.e. `my_spec.rb --color`

| Flag          | Short for Flag        | Result        |
| ------------- |:-------------:|:-------------:|
| `--color` | `-c` | Applies green/red color for successful/failing tests|
| `--no-color` | N/A |Tests don't have color |
| `--format progress` | `-f p` | One dot (.) for each test that passes or one 'F' for each failing test |
| `--format documentation` | `-f d` | Detailed decriptions for each test |
| `--order random` | N/A | Runs tests in random order |
| `--profile` | `-p` | Gives timings for slower examples |
| `--fail fast` | N/A | Stops at first failing test |
| `:line_number` | N/A | i.e. `my_spec.rb:3` will run tests for code on line 3 |


