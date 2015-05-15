#!/usr/bin/env ruby

if ARGV.count == 0
  $stderr.puts 'Usage: csvql "condition1" ["condition2"] [...]'
  exit 1
end

conditions = []

def op_equal(data, value)
  data == value
end

def op_not_equal(data, value)
  data != value
end

def op_less_or_equal_to(data, value)
  data.to_i <= value.to_i
end

def op_greater_or_equal_to(data, value)
  data.to_i >= value.to_i
end

def op_less_than(data, value)
  data.to_i < value.to_i
end

def op_greater_than(data, value)
  data.to_i > value.to_i
end

def op_include(data, value)
  data.include?(value)
end

def op_exclude(data, value)
  !data.include?(value)
end

operators = {
  "=="          => {func: method(:op_equal),                    value: ".*"},
  "!="          => {func: method(:op_not_equal),                value: ".*"},
  "<="          => {func: method(:op_less_or_equal_to),         value: ".*"},
  ">="          => {func: method(:op_greater_or_equal_to),      value: ".*"},
  "<"           => {func: method(:op_less_than),                value: "[0-9]*"},
  ">"           => {func: method(:op_greater_than),             value: "[0-9]*"},
  "include:"    => {func: method(:op_include),                  value: ".*"},
  "exclude:"    => {func: method(:op_exclude),                  value: ".*"},
}

ARGV.each do |c|
  index = c.scan(/^\[([0-9]*)\].*$/).last.first
  if index == ""
    $stderr.puts "Error: bad index"
    exit 1
  end
  index = index.to_i - 1

  operator = nil
  value = nil
  operators.each do |k, v|
    unless c.scan(/^\[[0-9]*\]#{k}#{v[:value]}$/).last.nil?
      operator = k
      value = c.scan(/\[[0-9]*\]#{k}(#{v[:value]})/).last.first
    end
  end
  if operator.nil?
    $stderr.puts "Error: unknown operator"
    exit 1
  end

  conditions << {index: index, operator: operator, value: value}
end

while line = $stdin.gets
  f = line.split(';')
  display = true
  conditions.each do |c|
    func = operators[c[:operator]][:func]
    data = f[c[:index].to_i]
    value = c[:value]
    display = false unless func.call(data, value)
  end
  puts line if display
end

exit 0
