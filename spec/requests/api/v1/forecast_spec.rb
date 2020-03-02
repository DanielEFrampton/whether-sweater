require 'rails_helper'

describe 'As a developer of the front-end' do
  describe 'when I send a post request to the forecast endpoint with a city name' do
    before(:each) do
      denver_geocode_fixture = JSON.parse(file_fixture('denver_geocode.json').read)
      denver_forecast_fixture = JSON.parse(file_fixture('denver_forecast.json').read)

      allow_any_instance_of(GoogleApiService).to receive(:get_geocode).with('denver,co').and_return(denver_geocode_fixture)
      allow_any_instance_of(DarkSkyService).to receive(:get_forecast).with('39.7392358,-104.990251').and_return(denver_forecast_fixture)

      get '/api/v1/forecast?location=denver,co'

      @data = JSON.parse(response.body)

      expected_json = JSON.generate({
        'data': {
          'attributes': {
            'time': '1583010500',
            'timezoneOffset': -7,
            'timezone': 'America/Denver',
            'city': 'Denver',
            'state': 'CO',
            'country': 'United States',
            'temperature': 54.3,
            'feelsLike': 54.3,
            'dayTemperatureHigh': 57.41,
            'dayTemperatureLow': 31.44,
            'summary': 'Overcast',
            'icon': 'cloudy',
            'humidity': 0.16,
            'uvIndex': 3,
            'uvExposureCategory': 'moderate',
            'visibility': 10.00,
            'todaySummary': 'Overcast throughout the day.',
            'tonightSummary': '',
            'hourlyForecasts': [
              {
                'time': '1583013600',
                'temperature': 55.19,
                'icon': 'cloudy'
              },
              {
                'time': '1583017200',
                'temperature': 56.88,
                'icon': 'cloudy'
              },
              {
                'time': '1583020800',
                'temperature': 55.93,
                'icon': 'cloudy'
              },
              {
                'time': '1583024400',
                'temperature': 51.8,
                'icon': 'cloudy'
              },
              {
                'time': '1583028000',
                'temperature': 47.56,
                'icon': 'cloudy'
              },
              {
                'time': '1583031600',
                'temperature': 44.58,
                'icon': 'cloudy'
              },
              {
                'time': '1583035200',
                'temperature': 42.47,
                'icon': 'cloudy'
              },
              {
                'time': '1583035200',
                'temperature': 41.17,
                'icon': 'cloudy'
              }
            ],
            'dailyForecasts': [
              {
                'weekday': 'Sunday',
                'time': 1583046000,
                'icon': 'snow',
                'temperatureHigh': 51.99,
                'temperatureLow': 23.74,
                'humidity': 0.63
              },
              {
                'weekday': 'Monday',
                'time': 1583132400,
                'icon': 'snow',
                'temperatureHigh': 44.69,
                'temperatureLow': 24.83,
                'humidity': 0.75
              },
              {
                'weekday': 'Tuesday',
                'time': 1583218800,
                'icon': 'clear-day',
                'temperatureHigh': 56.47,
                'temperatureLow': 28.74,
                'humidity': 0.51
              },
              {
                'weekday': 'Wednesday',
                'time': 1583305200,
                'icon': 'clear-day',
                'temperatureHigh': 65.56,
                'temperatureLow': 34.44,
                'humidity': 0.33
              },
              {
                'weekday': 'Thursday',
                'time': 1583391600,
                'icon': 'cloudy',
                'temperatureHigh': 65.69,
                'temperatureLow': 32.56,
                'humidity': 0.25
              }
            ]
          }
        }
        })
      @expected = JSON.parse(expected_json)
    end

    describe 'I receive a JSON:API response' do
      describe 'with weather data about current conditions, including' do
        it 'current weather condition, matching icon, and current temperature' do
          expect(@data['data']['attributes']['summary']). to eq(@expected['data']['attributes']['summary'])
          expect(@data['data']['attributes']['icon']). to eq(@expected['data']['attributes']['icon'])
          expect(@data['data']['attributes']['formattedTemperature']). to eq(@expected['data']['attributes']['formattedTemperature'])
        end

        it 'feels like, humidity, visability, uv index and uv exposure category' do
          expect(@data['data']['attributes']['formattedFeelsLike']). to eq(@expected['data']['attributes']['formattedFeelsLike'])
          expect(@data['data']['attributes']['formattedHumidity']). to eq(@expected['data']['attributes']['formattedHumidity'])
          expect(@data['data']['attributes']['formattedVisibility']). to eq(@expected['data']['attributes']['formattedVisibility'])
          expect(@data['data']['attributes']['uvIndex']). to eq(@expected['data']['attributes']['uvIndex'])
          expect(@data['data']['attributes']['uvExposureCategory']). to eq(@expected['data']['attributes']['uvExposureCategory'])
        end

        it 'daily high and low, daily summary, and overnight summary' do
          expect(@data['data']['attributes']['dayTemperatureLow']). to eq(@expected['data']['attributes']['dayTemperatureLow'])
          expect(@data['data']['attributes']['dayTemperatureHigh']). to eq(@expected['data']['attributes']['dayTemperatureHigh'])
          expect(@data['data']['attributes']['dayTemperatureHigh']). to eq(@expected['data']['attributes']['dayTemperatureHigh'])
          expect(@data['data']['attributes']['todaySummary']). to eq(@expected['data']['attributes']['todaySummary'])
          expect(@data['data']['attributes']['next24HoursSummary']). to eq(@expected['data']['attributes']['next24HoursSummary'])
        end
      end

      it 'with data about city, state, country, time, and date' do
        expect(@data['data']['attributes']['formattedCityState']).to eq(@expected['data']['attributes']['formattedCityState'])
        expect(@data['data']['attributes']['country']).to eq(@expected['data']['attributes']['country'])
        expect(@data['data']['attributes']['formattedDateTime']).to eq(@expected['data']['attributes']['formattedDateTime'])
      end

      it 'with hourly temperature forecast for next 8 hours' do
        @data['data']['attributes']['hourlyForecasts'].each_with_index do |hourly, index|
          expect(hourly['formattedHour']).to eq(@expected['data']['attributes']['hourlyForecasts'][index]['formattedHour'])
          expect(hourly['formattedTemperature']).to eq(@expected['data']['attributes']['hourlyForecasts'][index]['formattedTemperature'])
          expect(hourly['icon']).to eq(@expected['data']['attributes']['hourlyForecasts'][index]['icon'])
        end
      end

      it 'with weather summary, icon, high and low temps data for next 5 days' do
        @data['data']['attributes']['dailyForecasts'].each_with_index do |daily, index|
          expect(daily['weekday']).to eq(@expected['data']['attributes']['dailyForecasts'][index]['weekday'])
          expect(daily['icon']).to eq(@expected['data']['attributes']['dailyForecasts'][index]['icon'])
          expect(daily['formattedTemperatureHigh']).to eq(@expected['data']['attributes']['dailyForecasts'][index]['formattedTemperatureHigh'])
          expect(daily['formattedTemperatureLow']).to eq(@expected['data']['attributes']['dailyForecasts'][index]['formattedTemperatureLow'])
          expect(daily['formattedHumidity']).to eq(@expected['data']['attributes']['dailyForecasts'][index]['formattedHumidity'])
        end
      end
    end
  end
end
