require 'json'
require 'net/http'

zip_code = ARGV[0]
@weather_key = '11ddbdf681bffde5c997909789b50c7b'
@zipcodeapi_key = 'pAZ65aLcuXYmrMneOplYrwSXKUF9R4vMPW6qxWEVGGn5b7TFG9HxwsxNzM3rZdF2'

def zip_to_lat_long(zip_code)
  uri = URI("https://www.zipcodeapi.com/rest/#{@zipcodeapi_key}/info.json/#{zip_code}/degrees")

  response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    request = Net::HTTP::Get.new uri
    http.request request
  end

  JSON.parse(response.body)
end

def current_weather(zip_code)

  zip_data = zip_to_lat_long(zip_code)
  lat = zip_data['lat']
  long = zip_data['lng']

  weather_uri = URI("https://api.darksky.net/forecast/#{@weather_key}/#{lat},#{long}")

  weather_response = Net::HTTP.start(weather_uri.host, weather_uri.port, :use_ssl => weather_uri.scheme == 'https') do |http|
    request = Net::HTTP::Get.new weather_uri
    http.request request
  end

  JSON.parse(weather_response.body)
end

def fahrenheit_to_kelvin(temp)
  ((temp - 32) * 5 / 9) + 273.15
end

def friendly_output(weather)
  summary = weather['currently']['summary']
  daily_high = weather['daily']['data'][0]['temperatureHigh']
  kelvin_temp = fahrenheit_to_kelvin(daily_high).round(2)
  puts "#{summary} #{kelvin_temp} degrees Kelvin"
end

current_weather = current_weather(zip_code)
friendly_output(current_weather)

# puts "#{current_weather['currently']['summary']} #{fahrenheit_to_kelvin(current_weather['daily']['data'][0]['temperatureHigh'])} degrees Kelvin"
# puts fahrenheit_to_kelvin(current_weather['daily']['data'][0]['temperatureHigh'])


