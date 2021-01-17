<!-- Shields -->
![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Ruby-2.5.3-orange)


# Road Tripper

This is the backend of a road trip planning app will allow users to see the current weather as well as the forecasted weather at the destination they're looking to visit. This application provides multiple enpoints for the front end application, including weather, images, and login capabilities.

## Summary

  - [Getting Started](#getting-started)
  - [Runing the tests](#running-the-tests)
  - [API Endpoint](#api-endpoints)
  - [Versioning](#versioning)
  - [Authors](#authors)
  - [Acknowledgments](#acknowledgments)

## Getting Started

These instructions will get you a copy of the project up and running on
your local machine for development and testing purposes. See deployment
for notes on how to deploy the project on a live system.

### Installing

```
git clone git@github.com:stillsheryl/road_tripper.git
cd road_tripper
bundle install
rake db:create
figaro install
```

* Visit the [OpenWeather API documentation](https://openweathermap.org/api) and follow the link to sign up for an API key.

* Visit the [Mapquest API documentation](https://developer.mapquest.com/documentation/geocoding-api/address/get/) and follow the link to sign up for an API key.

* Visit the [Unsplash API documentation](https://unsplash.com/developers) and follow the link to sign up for an API key.

The `figaro install` command will create an `application.yml` file in your config folder. In that folder, at the bottom of the file add your API as below:
```
WEATHER_API_KEY: "<<Your API key here>>"
GEOCODING_API_KEY: "<<Your API key here>>"
PHOTO_API_KEY: "<<Your API key here>>"
```

### Dependencies

The following gems were used:
```
gem 'faraday'
gem 'figaro'
gem 'fast_jsonapi'

group :development, :test do
  gem 'rspec-rails'
  gem 'pry'
end

group :test do
  gem 'capybara'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'simplecov'
end
```

## Running the tests

* For testing I implemented RSpec, which is a tool for unit testing that will ensure we have the intended functionality at each level of our code.

* In order to run the tests, run `bundle exec rspec` in the command line and you should have all passing tests.

## API Endpoints

### `GET /api/v1/forecast`

Required parameters:

- `location`: (string) - the city and state in the format as seen below

Example:
`{
  location: "denver,co"
  }`

* In order to see this on your local machine, you can run your rails server with the `rails s` command, making sure that the server is running on port 3000.

* In the url bar or in [Postman](https://www.postman.com/), add `http://localhost:3000/api/v1/forecast?location=%22denver,co%22`

Example results:
```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2021/01/16 23:16:44",
                "sunrise": "2021/01/16 14:18:33",
                "sunset": "2021/01/17  0:00:41",
                "temperature": 37.75,
                "feels_like": 34.77000000000004,
                "humidity": 44,
                "uvi": 0.18,
                "visibility": 10000,
                "conditions": "clear sky",
                "icon": "01d"
            },
            "daily_weather": [
                {
                    "date": "2021/01/16",
                    "sunrise": "2021/01/16 14:18:33",
                    "sunset": "2021/01/17  0:00:41",
                    "max_temp": 38.620000000000005,
                    "min_temp": 33.03000000000003,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                ... you'll see 4 more daily_weather results here ...
            ],
            "hourly_weather": [
                {
                    "time": " 0:00:00",
                    "temperature": 37.75,
                    "wind_speed": "2.59 mph",
                    "wind_direction": "from SE",
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                  ... you'll see 7 more hourly_weather results here ...
            ],
            "id": null
        }
    }
}
```

### `GET /api/v1/backgrounds`

Required parameters:

- `location`: (string) - the city and state in the format as seen below

Example:
`{
  location: "denver,co"
  }`

* In order to see this on your local machine, you can run your rails server with the `rails s` command, making sure that the server is running on port 3000.

* In the url bar or in [Postman](https://www.postman.com/), add `http://localhost:3000/api/v1/backgrounds?location=denver,co`

Example results:
```
{
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "image": {
                "location": "denver,co",
                "image_url": "https://images.unsplash.com/photo-1600041161228-519e6dd27bac?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxOTkxNDl8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MHx8fA&ixlib=rb-1.2.1&q=80&w=1080",
                "credit": {
                    "photographer_name": "Michael Kilcoyne",
                    "photographer_profile_link": "https://unsplash.com/@mikekilcoyne?utm_source=road_tripper&utm_medium=referral",
                    "source_link": "https://unsplash.com/?utm_source=road_tripper&utm_medium=referral"
                }
            }
        }
    }
}
```

### `POST /api/v1/users`

Required parameters:

- `email`: (string) - user email, must be unique
- `password`: (string) - user password
- `password_confirmation`: (string) - user password confirmation must match the password field

Example:
`{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}`

* In order to see this on your local machine, you can run your rails server with the `rails s` command, making sure that the server is running on port 3000.

* In the url bar or in [Postman](https://www.postman.com/), add ???

Example results:

```
{
    "data": {
        "id": "3",
        "type": "users",
        "attributes": {
            "email": "whatever@example.com",
            "api_key": "e28ab574-8cd0-45cd-9b5d-39bb263e1f14"
        }
    }
}
```

**Note**: Please see the [Unsplash Attribution Guidelines](https://help.unsplash.com/en/articles/2511315-guideline-attribution) for information correctly crediting the photographer for an image.

## Versioning

This is the first version of this API. If you have any comments or feedback, please feel free to reach out to me!

## Author

Sheryl Stillman: [![LinkedIn](https://www.linkedin.com/in/sherylstillman1/) - [Email](mailto:sheryl.stillman@gmail.com) -  [GitHub](https://github.com/stillsheryl)

## Acknowledgments

Thank you to Ian and Dione, my Mod 3 Turing Instructors, for the continued support and encouragement!
