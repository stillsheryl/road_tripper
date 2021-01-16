# Road Tripper

This is the backend of a road trip planning app will allow users to see the current weather as well as the forecasted weather at the destination they're looking to visit. This application provides multiple enpoints for the front end application, including weather, images, and login capabilities.

## Summary

  - [Getting Started](#getting-started)
  - [Runing the tests](#running-the-tests)
  - [API Endpoint](#api-endpoints)
  - [Built With](#built-with)
  - [Contributing](#contributing)
  - [Versioning](#versioning)
  - [Authors](#authors)
  - [License](#license)
  - [Acknowledgments](#acknowledgments)

## Getting Started

These instructions will get you a copy of the project up and running on
your local machine for development and testing purposes. See deployment
for notes on how to deploy the project on a live system.

### Installing

A step by step series of examples that tell you how to get a development
env running

```
git clone git@github.com:stillsheryl/road_tripper.git
cd road_tripper
bundle install
rake db:create
figaro install
```

* Visit the [OpenWeather API documentation](https://openweathermap.org/api) and follow the link to sign up for an API key.

* Visit the [Mapquest API documentation](https://developer.mapquest.com/documentation/geocoding-api/address/get/) and follow the link to sign up for an API key.

The `figaro install` command will create an `application.yml` file in your config folder. In that folder, at the bottom of the file add your API as below:
```
WEATHER_API_KEY: "<<Your API key here>>"
GEOCODING_API_KEY: "<<Your API key here>>"
```

Say what the step will be

    Give the example

And repeat

    until finished

End with an example of getting some data out of the system or using it
for a little demo

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

### Break down into end to end tests

Explain what these tests test and why

    Give an example

### And coding style tests

Explain what these tests test and why

    Give an example

## API Endpoints

`GET /api/v1/forecast`

Required parameters:

- `location`: (string) - this is the city and state in the format as seen below

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
                    "icon": "01d",
                    "id": null
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
                    "icon": "01d",
                    "id": null
                },
                  ... you'll see 7 more hourly_weather results here ...
            ],
            "id": null
        }
    }
}
```

## Built With

  - [Contributor Covenant](https://www.contributor-covenant.org/) - Used
    for the Code of Conduct
  - [Creative Commons](https://creativecommons.org/) - Used to choose
    the license

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code
of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions
available, see the [tags on this
repository](https://github.com/PurpleBooth/a-good-readme-template/tags).

## Author

Sheryl Stillman: [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/sherylstillman1/), [Email](mailto:sheryl.stillman@gmail.com), [GitHub](https://github.com/stillsheryl)

## License

This project is licensed under the [CC0 1.0 Universal](LICENSE.md)
Creative Commons License - see the [LICENSE.md](LICENSE.md) file for
details

## Acknowledgments

  - Hat tip to anyone whose code was used
  - Inspiration
  - etc
