# cite_mapper

Quick and dirty mapper of cite urns to standard abbreviations

## Installation

Add this line to your application's Gemfile:

    gem 'cite_mapper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cite_mapper
    

## Usage

Run `rackup` to start a webserver (its port defaults to 9292).

At the moment the server will only respond to one GET method.

If you want to know what `urn:cts:greekLit:tlg0007.tlg015.perseus-eng1:16.1` means, you can ask the server
```
http://localhost:9292/find_cite?cite=urn%3Acts%3AgreekLit%3Atlg0007.tlg015.perseus-eng1%3A16.1
```

and it will respond in JSON:

```
{ "author" : "Plut.", "work" : "Alc.", "section" : "16.1" }
```
    
## Contributing

1. Fork it ( https://github.com/[my-github-username]/cts_mapper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
