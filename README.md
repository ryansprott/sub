# WARNING, THIS APPLICATION DOES NOT WORK ANYMORE

For reasons beyond anyone's comprehension, the MTA seems to have invalidated all existing API keys and decommissioned datamine.mta.info.

Surprise, surprise - try as you might to [create a new account](https://api.mta.info/#/signup), it won't work and you'll never be able to log in again.  (Please let me know if your experience has been different.)

As far as I can tell, the MTA is only pretending to allow API access to their train schedules, so there will be no further development on this project.  Thanks, MTA!

# nyc-bus-and-train

Displays real-time information on NYC buses and trains.  Rails backend with Vue frontend.

Requires a [Google Maps API key](https://developers.google.com/maps/documentation/javascript/get-api-key) and an [MTA Bus Time API key](http://bustime.mta.info/wiki/Developers/Index) See `config/secrets.yml.example`.

## Installation

```$sh
    bundle
    yarn install
    cp config/database.yml.example config/database.yml
    cp config/secrets.yml.example config/secrets.yml
    # make sure to add your API keys to secrets.yml
    rake db:migrate RAILS_ENV=development
    rake db:seed
    rails s &
    ./bin/webpack-dev-server
```

Please note that seeding the database will take some time.
