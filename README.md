# Bandcamp

This is a gem that wraps the Bandcamp API in a warm Rubyish hug.
To use it you will need to request an API key from them. For details see
[http://bandcamp.com/developer#key_request][].

# Usage

In your Gemfile
```ruby
gem install bandcamp_api
```

## Getting started:
```ruby
require 'bandcamp_api'
Bandcamp.config.api_key = "your_api_key"
```

## Search

Search the Bandcamp.com API by band name:
```ruby
matching_bands = Bandcamp.search "pitch black"
=> [#<Bandcamp::Band:0x00000001efa168>, #<Bandcamp::Band:0x00000001e53278>, ...]
```

## Resolving URLs

Bandcamp lets you resolve a given url to given band, track or album:

```ruby
sea_oleena = Bandcamp.resolve.url "seaoleena.bandcamp.com"
=> #<Bandcamp::Band:0x00000001ef20f8>

emoxygen_by_sun_monx = Bandcamp.resolve.url "http://interchill.bandcamp.com/track/emoxygen"
```

## Getting stuff

A specific track:
```ruby
evolution_11 = Bandcamp.get.track 1735088360
=> #<Bandcamp::Track:0x0000000162c7e8>
```

Many specific tracks:
```ruby
tracks = Bandcamp.get.tracks 1735088360, 1739611553
=> [#<Bandcamp::Track:0x00000001316ab8>, #<Bandcamp::Track:0x00000001314a10>, ...]
```

A band:
```ruby
pitchblack = Bandcamp.get.band 950934886
=> #<Bandcamp::Band:0x000000017d43e8>
```

An album:
```ruby
ape_to_angel = Bandcamp.get.album 2909726980
=> #<Bandcamp::Album:0x00000001e20c60>
```

## TODO list

* Making the objects a little smarter. Tracks should be able to tell you what album
  they are from and what band did them. Same sort of thing for the other
  objects.
* Rails 3 integration so you can use these ojects with partials and form_for.
* Duck typing helpers along the lines of [ActiveSupport's
  #acts_like?](http://apidock.com/rails/Object/acts_like%3F)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### License

(The MIT License)

Copyright (c) 2013 Mike Williamson

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

