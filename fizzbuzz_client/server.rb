require 'socket'

def fizz(number)
  (number % 3).zero? ? 'Fizz' : nil
end

def buzz(number)
  (number % 5).zero? ? 'Buzz' : nil
end

def fizzbuzz(number)
  return 'Integers only' if !number.zero? && number.to_i.zero?
  number = number.to_i
  result = ''
  result += fizz(number)
  result += buzz(number)
  result.empty? ? number : result
end

TCPServer.open('0.0.0.0', 5555) { |server|
  s = server.accept
  s.puts 'Welcome to the FizzBuzz Server'
  s.puts 'Type `exit` to quit'
  s.puts Time.now

  loop {
    Thread.start(s) do |con|
      input = con.gets.chomp
      s.close if input == 'exit'
      s.puts fizzbuzz(input)
    end
  }

  s.close
}
