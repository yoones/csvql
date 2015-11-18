# csvql.rb

### Minimalist CSV query tool


#### Syntax:

	[index]  : Which field (starting from 1) to look in
	operator : What check to do on this field

| Operator                      | Description                                 |
|-------------------------------|---------------------------------------------|
| ==                            | numerical value must be equal               |
| !=                            | numerical value must be different than      |
| <                             | numerical value must be less than           |
| >                             | numerical value must be greater than        |
| <=                            | numerical value must be less or equal to    |
| >=                            | numerical value must be greater or equal to |
| include:                      | must contain the string                     |
| exclude:                      | must not contain the string                 |
| match\_line\_in\_file:        | Value must match any line in the file       |
| doesnt\_match\_line\_in_file: | Value must not match any line in the file   |

Note that the first field's index is 1 (not 0).

#### Example:

	./csvql "[1]==toto" "[2]>=12" <<EOF
	toto;2
	titi;14
	toto;12
	EOF

#### This will output:

	toto;12

#### Example with other conditions:

	csvql "[1]>=12" "[2]include:HelloWorld!" "[4]match_line_in_file:/tmp/whitelist.txt"

#### Configuration:
	-v : verbose mode
		 Displays step by step debug information in addition to matching lines
	-q : quiet mode
		 Displays only matching lines
