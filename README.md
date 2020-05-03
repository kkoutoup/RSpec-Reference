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

| Flag          | Result        | 
| ------------- |:-------------:|
| `--c color` or `-c` | applies green/red color for successful/failing tests|
| `--no-color` |  tests don't have color |
| `--format progress` or `-f p` | progress is shown as one dot (.) assinged for each test that passes or one 'F' for each failing test |

