require 'socket'

def fizzbuzz(number)
  return 'Integers only' if number != 0 && number.to_i.zero?
  number = number.to_i
  result = ''
  result += 'Fizz' if (number % 3).zero?
  result += 'Buzz' if (number % 5).zero?
  result.empty? ? number : result
end

TCPServer.open('0.0.0.0', 5555) do |server|
  serv = server.accept
  serv.puts 'Welcome to the FizzBuzz Server'
  serv.puts 'Type `exit` to quit'
  serv.puts Time.now

  loop do
    input = serv.gets.chomp
    serv.close if input == 'exit'
    serv.puts fizzbuzz(input).to_s
  end

  serv.close
end
