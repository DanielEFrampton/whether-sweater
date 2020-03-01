require 'rails_helper'

describe 'As a developer of the front-end' do
  describe 'when I send a post request to the forecast endpoint with a city name' do
    before(:each) do
      allow_any_instance_of(GoogleApiService).to receive(:geocode).with('denver,co').and_return(file_fixture('denver_geocode.json').read)
      allow_any_instance_of(DarkSkyService).to receive(:forecast).with('denver,co').and_return(file_fixture('denver_forecast.json').read)

      get '/api/v1/forecast=denver,co'

      @data = JSON.parse(response.body)

      @expected = {
        'data': {
          'dateTime': {
            # 'time': '2:08',
            # 'period': 'PM',
            # 'date': '2/29',
            'formattedDateTime': '2:08 PM, 2/29',
            # 'unixTimestamp': '1583010500',
            # 'timezone': 'America/Denver',
            # 'utcHourDifference': -7
          },
          'location': {
            # 'city': 'Denver',
            # 'state': 'CO',
            'formattedCityState': 'Denver, CO',
            'country': 'United States'
          },
          'currently': {
            # 'temperature': 54.3,
            # 'roundedTemperature': 54,
            'formattedTemperature': '54°',
            # 'feelsLike': 54.3,
            # 'roundedFeelsLike': 54,
            'formattedFeelsLike': '54°',
            # 'dayTemperatureHigh': 57.41,
            # 'dayToundedTemperatureHigh': 57,
            'formattedDayTemperatureHigh': '57°',
            # 'dayTemperatureLow': 31.44,
            # 'dayToundedTemperatureLow': 31,
            'formattedDayTemperatureLow': '31°',
            'summary': 'Overcast',
            'summaryIcon': 'cloudy',
            # 'humidityFloat': 0.16,
            # 'humidityPercent': 16,
            'formattedHumidity': '16%',
            'uvIndex': 2,
            'uvExposureCategory': 'low',
            # 'visibility': 10.00,
            # 'visibilityUnits': 'miles'
            'formattedVisibility': '10.00 miles',
            'todaySummary': 'Overcast throughout the day.',
            'next24HoursSummary': 'Possible light snow tomorrow evening.'
          },
          'hourlyForecasts': [
            {
              # 'hour': 3,
              # 'period': 'PM',
              'formattedHour': '3 PM',
              # 'unixTimestamp': '1583013600',
              # 'temperature': 55.19,
              # 'roundedTemperature': 55,
              'formattedTemperature': '55°',
              'summaryIcon': 'cloudy'
            },
            {
              # 'hour': 4,
              # 'period': 'PM',
              'formattedHour': '4 PM',
              # 'unixTimestamp': '1583017200',
              # 'temperature': 56.88,
              # 'roundedTemperature': 56,
              'formattedTemperature': '56°',
              'summaryIcon': 'cloudy'
            },
            {
              # 'hour': 5,
              # 'period': 'PM',
              'formattedHour': '5 PM',
              # 'unixTimestamp': '1583020800',
              # 'temperature': 55.93,
              # 'roundedTemperature': 56,
              'formattedTemperature': '56°',
              'summaryIcon': 'cloudy'
            },
            {
              # 'hour': 6,
              # 'period': 'PM',
              'formattedHour': '6 PM',
              # 'unixTimestamp': '1583024400',
              # 'temperature': 51.8,
              # 'roundedTemperature': 52,
              'formattedTemperature': '52°',
              'summaryIcon': 'cloudy'
            },
            {
              # 'hour': 7,
              # 'period': 'PM',
              'formattedHour': '7 PM',
              # 'unixTimestamp': '1583028000',
              # 'temperature': 47.56,
              # 'roundedTemperature': 48,
              'formattedTemperature': '48°',
              'summaryIcon': 'cloudy'
            },
            {
              # 'hour': 8,
              # 'period': 'PM',
              'formattedHour': '8 PM',
              # 'unixTimestamp': '1583031600',
              # 'temperature': 44.58,
              # 'roundedTemperature': 45,
              'formattedTemperature': '45°',
              'summaryIcon': 'cloudy'
            },
            {
              # 'hour': 9,
              # 'period': 'PM',
              'formattedHour': '9 PM',
              # 'unixTimestamp': '1583035200',
              # 'temperature': 42.47,
              # 'roundedTemperature': 42,
              'formattedTemperature': '42°',
              'summaryIcon': 'cloudy'
            },
            {
              # 'hour': 10,
              # 'period': 'PM',
              'formattedHour': '10 PM',
              # 'unixTimestamp': '1583035200',
              # 'temperature': 41.17,
              # 'roundedTemperature': 41,
              'formattedTemperature': '41°',
              'summaryIcon': 'cloudy'
            }
          ]
          },
          'dailyForecasts': [
            {
              'weekday': 'Sunday',
              # 'unixTimestamp': 1583046000,
              'summaryIcon': 'snow',
              # 'temperatureHigh': 51.99,
              # 'roundedTemperatureHigh': 52,
              'formattedTemperatureHigh': '52°',
              # 'temperatureLow': 23.74,
              # 'roundedTemperatureLow': 24,
              'formattedTemperatureLow': '24°',
              # 'humidityFloat': 0.63,
              # 'humidityPercent': 63,
              'formattedHumidity': '63%'
            },
            {
              'weekday': 'Monday',
              # 'unixTimestamp': 1583132400,
              'summaryIcon': 'snow',
              # 'temperatureHigh': 44.69,
              # 'roundedTemperatureHigh': 45,
              'formattedTemperatureHigh': '45°',
              # 'temperatureLow': 24.83,
              # 'roundedTemperatureLow': 25,
              'formattedTemperatureLow': '25°',
              # 'humidityFloat': 0.75,
              # 'humidityPercent': 75,
              'formattedHumidity': '75%'
            },
            {
              'weekday': 'Tuesday',
              # 'unixTimestamp': 1583218800,
              'summaryIcon': 'clear-day',
              # 'temperatureHigh': 56.47,
              # 'roundedTemperatureHigh': 56,
              'formattedTemperatureHigh': '56°',
              # 'temperatureLow': 28.74,
              # 'roundedTemperatureLow': 29,
              'formattedTemperatureLow': '29°',
              # 'humidityFloat': 0.51,
              # 'humidityPercent': 51,
              'formattedHumidity': '51%'
            },
            {
              'weekday': 'Wednesday',
              # 'unixTimestamp': 1583305200,
              'summaryIcon': 'clear-day',
              # 'temperatureHigh': 65.56,
              # 'roundedTemperatureHigh': 66,
              'formattedTemperatureHigh': '66°',
              # 'temperatureLow': 34.44,
              # 'roundedTemperatureLow': 34,
              'formattedTemperatureLow': '34°',
              # 'humidityFloat': 0.33,
              # 'humidityPercent': 33,
              'formattedHumidity': '33%'
            },
            {
              'weekday': 'Thursday',
              # 'unixTimestamp': 1583391600,
              'summaryIcon': 'cloudy',
              # 'temperatureHigh': 65.69,
              # 'roundedTemperatureHigh': 66,
              'formattedTemperatureHigh': '66°',
              # 'temperatureLow': 32.56,
              # 'roundedTemperatureLow': 33,
              'formattedTemperatureLow': '33°',
              # 'humidityFloat': 0.25,
              # 'humidityPercent': 25,
              'formattedHumidity': '25%'
            }
          ]
        }
    end

    describe 'I receive a JSON:API response' do
      describe 'with weather data about current conditions, including' do
        it 'current weather condition, matching icon, and current temperature' do
          expect(@data['data']['currently']['summary']). to eq(@expected['data']['currently']['summary'])
          expect(@data['data']['currently']['summaryIcon']). to eq(@expected['data']['currently']['summaryIcon'])
          expect(@data['data']['currently']['formattedTemperature']). to eq(@expected['data']['currently']['formattedTemperature'])
        end

        it 'feels like, humidity, visability, uv index and uv exposure category' do
          expect(@data['data']['currently']['formattedFeelsLike']). to eq(@expected['data']['currently']['formattedFeelsLike'])
          expect(@data['data']['currently']['formattedHumidity']). to eq(@expected['data']['currently']['formattedHumidity'])
          expect(@data['data']['currently']['formattedVisibility']). to eq(@expected['data']['currently']['formattedVisibility'])
          expect(@data['data']['currently']['uvIndex']). to eq(@expected['data']['currently']['uvIndex'])
          expect(@data['data']['currently']['uvExposureCategory']). to eq(@expected['data']['currently']['uvExposureCategory'])
        end

        it 'daily high and low, daily summary, and overnight summary' do
          expect(@data['data']['currently']['dayTemperatureLow']). to eq(@expected['data']['currently']['dayTemperatureLow'])
          expect(@data['data']['currently']['dayTemperatureHigh']). to eq(@expected['data']['currently']['dayTemperatureHigh'])
          expect(@data['data']['currently']['dayTemperatureHigh']). to eq(@expected['data']['currently']['dayTemperatureHigh'])
          expect(@data['data']['currently']['todaySummary']). to eq(@expected['data']['currently']['todaySummary'])
          expect(@data['data']['currently']['next24HoursSummary']). to eq(@expected['data']['currently']['next24HoursSummary'])
        end
      end

      it 'with data about city, state, country, time, and date' do
        expect(@data['location']['formattedCityState']).to eq(@expected['location']['formattedCityState'])
        expect(@data['location']['country']).to eq(@expected['location']['country'])
        expect(@data['dateTime']['formattedDateTime']).to eq(@expected['dateTime']['formattedDateTime'])
      end

      it 'with hourly temperature forecast for next 8 hours' do
        @data['hourlyForecasts'].each_with_index do |hourly, index|
          expect(hourly['formattedHour']).to eq(@expected['hourlyForecasts'][index]['formattedHour'])
          expect(hourly['formattedTemperature']).to eq(@expected['hourlyForecasts'][index]['formattedTemperature'])
          expect(hourly['summaryIcon']).to eq(@expected['hourlyForecasts'][index]['summaryIcon'])
        end
      end

      it 'with weather summary, icon, high and low temps data for next 5 days' do
        @data['dailyForecasts'].each_with_index do |daily, index|
          expect(daily['weekday']).to eq(@expected['dailyForecasts'][index]['weekday'])
          expect(daily['summaryIcon']).to eq(@expected['dailyForecasts'][index]['summaryIcon'])
          expect(daily['formattedTemperatureHigh']).to eq(@expected['dailyForecasts'][index]['formattedTemperatureHigh'])
          expect(daily['formattedTemperatureLow']).to eq(@expected['dailyForecasts'][index]['formattedTemperatureLow'])
          expect(daily['formattedHumidity']).to eq(@expected['dailyForecasts'][index]['formattedHumidity'])
        end
      end
    end
  end
end
