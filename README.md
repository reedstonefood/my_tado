# MyTado

A Ruby wrapper for interacting with Tado's v2 API.

The API is officially undocumented so there are no guarantees that this will work for you!

## Installation

`gem install my_tado`

## Usage

To connect to Tado's API, you need to have a username, password, and (optionally) client_secret.

At time of writing, the client_secret that is widely used is `wZaRN7rpjn3FoNyF5IFuxg9uMzYJcvOoQ8QWiIqS3hfk6gLhVlG57j5YNoZL2Rtc`, so if you do not provide a client_secret of your own, MyTado will use that one. See https://shkspr.mobi/blog/2019/02/tado-api-guide-updated-for-2019/ for more information on this.

Once you have all three, you can put them into MyTado either as a hash (using strings or symbols as keys), or a YML file (for example, see [secrets.example.yml](https://github.com/reedstonefood/my_tado/blob/master/lib/secrets.example.yml)), like so:

```ruby
# Using a hash
credentials = { username: "foo@example.com", password: "terrible_password" }
tado = MyTado.new(credentials)

# Or, using a YML file
tado = MyTado.new("secrets.yml")
```

Once initialized you can call other endpoints like so:

```ruby
tado.home # no extra parameters needed

tado.zone_state(zone_id: 0) # an example where a parameter is needed

# treat the output as an Array/Hash
tado.zones.map { |zone| zone["name"] } # gives the names of all zones
```

## Endpoints

- `day_report` - detailed data from a zone for a specific day
- `me` - your account information - name, email etc.
- `home` - information about your home, address, contact details
- `presence` - returns whether tado thinks your presence is HOME or AWAY
- `weather` - the external weather for your home
- `zones` - a lot of information about your installation
- `zone_state` (requires `zone_id`) - information about your hot water or heating

## Responses

The response object that MyTado returns from the endpoints has the following methods:

- `raw_response` if you want the HTTParty response class
- `["thing"]` for looking at the response
- `ok?` - a convenience method for `raw_response.ok?` which lets you know if the response was an HTTP 200 or not.

Differences between `raw_response["thing"]` and `["thing"]` are:
- `["thing"]` will have automatically converted dates into Ruby Date objects to make it easier to use.
- You can call regular Array/Hash methods on ["thing"] directly, eg `tado.zones.count`. Easy!

## Example usage

```ruby
credentials = { username: "foo@example.com", password: "terrible_password" }
tado = MyTado.new(credentials)

# Get the state of every zone
zones_state = tado.zones.map { |zone| tado.zone_state(zone["id"]) }

# Get the temperature in every zone, in celsius
acutal_temperatures = zone_states.map do |zone_state|
  zone_state.dig('sensorDataPoints', 'insideTemperature', 'celsius')
end
```

## Running tests

~~There is no known test environment, so if you want to run tests you have to use your own Tado username and password. Don't worry, the tests only read data, they do not make any changes to your tado setup.~~

~~Put your username & password into spec/spec_helper, in the `test_username` and `test_password` methods. Then run `rspec spec`.~~
None of the tests that have been written test the actual API, they only test internal aspects of the client.

## Future development

This gem does what I want to do for my own purposes. I may add to it in the future, or I may not.

If you want to expand the functionality, feel free to fork it or raise a PR.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Helpful resources

https://shkspr.mobi/blog/2019/02/tado-api-guide-updated-for-2019/
