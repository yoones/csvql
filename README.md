# csvql
Minimalist CSV query tool

Syntax:
[index]  : Which field (starting from 1) to look in
operator : == != < > <= >= include: exclude:

Example:
./csvql "[1]==toto" "[2]>=12" <<EOF
toto;2
titi;14
toto;12
EOF

This will output:
toto;12
