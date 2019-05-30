passwords = IO.readlines('passwords.txt', chomp: true)

if passwords.include? ARGV[0]
  puts 'Common Password'
else
  puts 'Not Common Password'
end
