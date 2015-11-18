# csvql.rb

### Minimalist CSV query tool


#### Syntax:

	[index]  : Which field (starting from 1) to look in
	operator : What check to do on this field

* ==
* !=
* <
* >
* <=
* >=
* include:
* exclude:
* match_line_in_file:
* doesnt_match_line_in_file:

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
