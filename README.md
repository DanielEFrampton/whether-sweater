# Whether Sweater API

## Deployed App

![Screenshot of deployed site](https://user-images.githubusercontent.com/40702808/75869398-bcc29d00-5dc6-11ea-9fdd-f989c8df0495.png)

This application is live at: http://whether-sweater-df.herokuapp.com/

## Table of Contents
- [Description](#description)
- [Technologies & Architecture](#technologies--architecture)
- [Test Coverage & Metrics](#test-coverage--metrics)
- [Endpoints](#endpoints)
  - [Forecast](#forecast)
  - [Backgrounds](#backgrounds)
  - [Users](#users)
  - [Sessions](#sessions)
  - [Road Trip](#road-trip)
  - [Munchies](#munchies)

## Description

This is the Weather Sweater API, an API-only Rails back-end application designed to serve data to a fictional "Sweater Weather" front-end application. It was developed by [Daniel Frampton](https://github.com/DanielEFrampton) as a project for <a href="http://turing.io">Turing School of Software & Design</a> in order to practice 3rd party API consumption, combining outputs, and exposing data and authentication functionality via an API.

## Technologies & Architecture

- Framework: Ruby on Rails
- Testing: RSpec
- Deployment: Heroku
- CI/CD: TravisCI
- JSON Serializer: FastJsonAPI
- 3rd Party APIs:
  - Google Direction Matrix API
  - Google Geocoding API
  - Yelp API
  - Unsplash API
  - DarkSky API
- Response Caching: VCR & Webmock
- Linting: Rubocop
- Test Coverage: SimpleCov

## Test Coverage & Metrics

At time of project submission, Whether Sweater has 100% test coverage, zero Rubocop violations, and all tests passing.

The [project requirements](https://backend.turing.io/module3/projects/sweater_weather/requirements), [description](https://backend.turing.io/module3/projects/sweater_weather/), and [rubric](https://backend.turing.io/module3/projects/sweater_weather/rubric) are available on Turing's [back-end curriculum website](https://backend.turing.io/).

## Endpoints

All endpoints are built on this API URL:
```
http://whether-sweater-df.herokuapp.com/api/v1
```
Note the appropriate HTTP verb for each endpoint.

### Forecast

Retrieve detailed weather information for a given city, including:
- Current conditions
- Location details
- Tonight's weather (at 9pm, or currently if between 9 and midnight)
- Hourly forecasts for next 8 hours
- Daily forecasts for next 5 days

Endpoint:
```
/forecast
```

Query Parameter(s):
- `location`, which should be a string containing a city and state, comma-separated (e.g., "denver,co").

HTTP Request Example:
```
GET http://whether-sweater-df.herokuapp.com/api/v1/forecast?location=indianapolis,in
```

Response example:
```json
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "location": {
                "city": "Indianapolis",
                "state": "IN",
                "country": "United States",
                "city_state": "Indianapolis, IN",
                "lat": 39.768403,
                "long": -86.158068
            },
            "currentForecast": {
                "feels_like": 29.88,
                "humidity": 0.78,
                "icon": "clear-night",
                "summary": "Clear",
                "temperature": 35.84,
                "time": 1583312586,
                "uv_index": 0,
                "visibility": 10,
                "day_temperature_high": 50.62,
                "day_temperature_low": 30.02,
                "today_summary": "Partly cloudy throughout the day.",
                "timezone_offset": -5,
                "timezone": "America/Indiana/Indianapolis",
                "uv_exposure_category": "low"
            },
            "tonightSummary": "Clear",
            "hourlyForecasts": [
                {
                    "time": 1583316000,
                    "icon": "rain",
                    "temperature": 35.42,
                    "summary": "Possible Drizzle"
                },
                {
                    "time": 1583319600,
                    "icon": "clear-night",
                    "temperature": 36.19,
                    "summary": "Clear"
                },
                {
                    "time": 1583323200,
                    "icon": "clear-night",
                    "temperature": 37.22,
                    "summary": "Clear"
                },
                {
                    "time": 1583326800,
                    "icon": "partly-cloudy-day",
                    "temperature": 39.01,
                    "summary": "Partly Cloudy"
                },
                {
                    "time": 1583330400,
                    "icon": "partly-cloudy-day",
                    "temperature": 42.91,
                    "summary": "Mostly Cloudy"
                },
                {
                    "time": 1583334000,
                    "icon": "partly-cloudy-day",
                    "temperature": 46.24,
                    "summary": "Mostly Cloudy"
                },
                {
                    "time": 1583337600,
                    "icon": "partly-cloudy-day",
                    "temperature": 48.21,
                    "summary": "Mostly Cloudy"
                },
                {
                    "time": 1583341200,
                    "icon": "partly-cloudy-day",
                    "temperature": 49.13,
                    "summary": "Partly Cloudy"
                }
            ],
            "dailyForecasts": [
                {
                    "time": 1583384400,
                    "icon": "partly-cloudy-day",
                    "temperature_high": 56.95,
                    "temperature_low": 32.37,
                    "humidity": 0.61,
                    "weekday": "Thursday"
                },
                {
                    "time": 1583470800,
                    "icon": "partly-cloudy-day",
                    "temperature_high": 42.02,
                    "temperature_low": 25.71,
                    "humidity": 0.68,
                    "weekday": "Friday"
                },
                {
                    "time": 1583557200,
                    "icon": "clear-day",
                    "temperature_high": 53.87,
                    "temperature_low": 35.58,
                    "humidity": 0.61,
                    "weekday": "Saturday"
                },
                {
                    "time": 1583643600,
                    "icon": "partly-cloudy-day",
                    "temperature_high": 62.26,
                    "temperature_low": 47.59,
                    "humidity": 0.55,
                    "weekday": "Sunday"
                },
                {
                    "time": 1583726400,
                    "icon": "rain",
                    "temperature_high": 60.46,
                    "temperature_low": 43.27,
                    "humidity": 0.76,
                    "weekday": "Monday"
                }
            ]
        }
    }
}
```

### Backgrounds

Retrieve a background image URL from Unsplash for a given city, which can be resized to fit one's needs.

Endpoint:
```
/backgrounds
```

Query Parameter(s):
- `location`, which should be a string containing a city and state, comma-separated (e.g., "denver,co").

HTTP Request Example:
```
GET http://whether-sweater-df.herokuapp.com/api/v1/backgrounds?location=indianapolis,in
```

Response example:
```json
{
    "data": {
        "id": null,
        "type": "background",
        "attributes": {
            "image_url": "https://images.unsplash.com/photo-1570039486851-9caa462a2cd3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjExODU0MH0"
        }
    }
}
```

### Users

Submit a user's email, password, and password confirmation to create that user in the database and receive a unique API key for the user.

POST Request Body Parameter(s):
- `email`, which is a string value and must be unique in the database.
- `password`, which is a string value.
- `password_confirmation`, which is a string value and must be present and match the `password`.

Endpoint:
```
/users
```

HTTP Request example:
```
POST http://whether-sweater-df.herokuapp.com/api/v1/users
```
Headers example:
```
Content-Type: application/json
Accept: application/json
```
Body example:
```json
{
  "email": "daniel@whethersweater.org",
  "password": "123badpassword",
  "password_confirmation": "123badpassword"
}
```

Response example:
```json
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "api_key": "2spUUHk5he9QyaejKsPKcYV6"
        }
    }
}
```

If there is a problem with the parameters provided, a JSON:API error object will be returned containing details about which parameter caused the error.

Error example:
```json
{
    "errors": [
        {
            "status": "400",
            "source": {
                "pointer": "/api/v1/users",
                "parameter": "email, password_confirmation"
            },
            "title": "Invalid Request",
            "detail": "Email has already been taken, Password confirmation doesn't match Password."
        }
    ]
}
```

### Sessions

Submit an existing user's email and password and receive their unique API key generated by the previous endpoint.

Endpoint:
```
/sessions
```

POST Request Body Parameter(s):
- `email`, which is a string value and must be unique in the database.
- `password`, which is a string value.


HTTP Request example:
```
POST http://whether-sweater-df.herokuapp.com/api/v1/sessions
```
Headers example:
```
Content-Type: application/json
Accept: application/json
```
Body example:
```json
{
  "email": "daniel@whethersweater.org",
  "password": "123badpassword",
}
```

Response example:
```json
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "api_key": "2spUUHk5he9QyaejKsPKcYV6"
        }
    }
}
```

If there is a problem with the parameters provided, a JSON:API error object will be returned containing details about which parameter caused the error.

Error example:
```json
{
    "errors": [
        {
            "status": "400",
            "source": {
                "pointer": "/api/v1/sessions",
                "parameter": "email"
            },
            "title": "Invalid Credentials",
            "detail": "Invalid email."
        }
    ]
}
```

### Road Trip

Submit an origin and a destination along with a user's API key and receive information on travel time and the temperature and weather upon arrival.

Endpoint:
```
/road_trip
```

POST Request Body Parameter(s):
- `origin`, which should be a string containing a city and state, comma-separated (e.g., "denver,co").
- `destination`, which should be another string containing a city and state, comma-separated (e.g., "pueblo,co").
- `api_key`, which should be a valid 24-character API key acquired from either the `/users` or `/sessions` endpoints above, as a string.

HTTP Request example:
```
POST http://whether-sweater-df.herokuapp.com/api/v1/road_trip
```
Headers example:
```
Content-Type: application/json
Accept: application/json
```
Body example:
```
{
  "origin": "broomfield,co",
  "destination": "estes park,co",
  "api_key": "2spUUHk5he9QyaejKsPKcYV6"
}
```

Example response:
```json
{
    "data": {
        "id": null,
        "type": "roadTrip",
        "attributes": {
            "travelTime": "1 hour 8 mins",
            "forecast": {
                "summary": "Clear",
                "temperature": 27.7
            },
            "origin": "broomfield, co",
            "destination": "estes park, co"
        }
    }
}
```

If there is a problem with the API key provided, a JSON:API error object will be returned containing details.

Error example:
```json
{
    "errors": [
        {
            "status": "401",
            "source": {
                "pointer": "/api/v1/road_trip",
                "parameter": "api_key"
            },
            "title": "Unauthorized Request",
            "detail": "The API key provided was invalid."
        }
    ]
}
```

### Munchies

Submit start and end locations and a preferred food type, and receive information about travel time, weather conditions upon arrival, and the closest restaurant to your arrival location that will be open at your arrival time.

Endpoint:
```
/munchies
```

Query Parameter(s):
- `start`, which should be a string containing a city and state, comma-separated (e.g., "denver,co").
- `end`, which should be another string containing a city and state, comma-separated (e.g., "pueblo,co").
- `food`, a preferred food type as a string value.

Example request:
```
GET http://whether-sweater-df.herokuapp.com/api/v1/munchies?start=indianapolis,in&end=chicago,il&food=donuts
```

Example response:
```json
{
    "data": {
        "id": null,
        "type": "munchies",
        "attributes": {
            "travel_time": "2 hours 56 mins",
            "forecast": "Possible Light Snow",
            "end_location": "Chicago, IL",
            "restaurant": {
                "name": "Bridgeport Bakery",
                "address": "2907 S Archer Ave, Chicago, IL 60608"
            }
        }
    }
}
```
