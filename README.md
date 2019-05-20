# nyc-bus-and-train 

Displays real-time information on NYC buses and trains.  Rails backend with Vue frontend.

Requires a [Google Maps API key](https://developers.google.com/maps/documentation/javascript/get-api-key) and an [MTA Bus Time API key](http://bustime.mta.info/wiki/Developers/Index) See `config/secrets.yml.example`.

## Installation

```$sh
    bundle
    yarn install
    cp config/database.yml.example config/database.yml
    rake db:migrate RAILS_ENV=development
    rake db:seed
    rails s & 
    ./bin/webpack-dev-server
```

Please note that seeding the database will take some time.
