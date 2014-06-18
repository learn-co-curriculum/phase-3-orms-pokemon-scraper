class Person
  attr_reader :nick_names
end

# p.nick_names << "go for it" :nick_names

p = Person.new

# p.nick_names << "go for it"
# p.nick_names.<<()
return_val = p.nick_names
return_val = "Tristan"
#=> nil = "Tristan"
# p.nick_names.<<("")

@nick_names = "hello world"