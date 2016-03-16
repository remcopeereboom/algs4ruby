# Algs4ruby

The algs4ruby library is a ruby port of the algorithms, data structures and
command-line clients in the [Algs4 repository]. The companion code to Algorithms
4th edition text book. For more information on the original library (in Java),
the text book, or the accompanying Coursera course, please goto the
[Algs4 repository].

The code in this repository is designed more for compatability to the original
Java library than for being idiomatic ruby. If you are purely interested in a
library more focussed on production code, than you might be better of using a
different ruby library. The [`algorithms`] gem is aparently quite popular and
makes use of C-extensions for extra speed. All that is not to say that the
algs4ruby algorithms and data structures cannot be used in production code, but
it's important to be aware that the ruby interpreter adds an overhead that may
impact the overall performance of your code.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'algs4ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install algs4ruby

## Usage

You can use the entire code base in your own code by adding the algs4ruby to
your class path and then requiring the gem:

````ruby
require 'algs4ruby'
````

Most files are also an in-built testing client that can be run directly from
the command-line by having ruby run just that file:

    $ ruby lib/algs4_ruby/fundamentals/binary_search.rb whitelist.txt < input.txt

If you need to generate code documentation, than you make sure the library is
class pathed and run:

    $ yard


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push git
commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at the
[algs4ruby repository]. Additional tests are especially welcome. If you
contribute code, please make sure that it is sufficiently tested and make sure
that it has no obvious styling issues by running [Flay], [Flog], and [Rubocop]:

    $ flay your_file.rb
    $ flog your_file.rb
    $ rubocop your_file.rb

It's okay if your does not pass all the linting errors - they tend to find
algorithms too complex - but make sure that there are no obvious issues.

## License

The gem is available as open source under the terms of the [GPLv3 License],
a copy of which can be found in this repository.

[algs4ruby](https://github.com/remcopeereboom/algs4ruby)
[algs4ruby reposityory](https://github.com/remcopeereboom/algs4ruby)
[Algs4 repository](https://github.com/kevin-wayne/algs4)
[`algorithms` gem](https://github.com/kanwei/algorithms)
[Flay](https://github.com/seattlerb/flay)
[Flog](https://github.com/seattlerb/flog)
[Ruboco](https://github.com/bbatsov/rubocop)
[GPLv3 License](http://gplv3.fsf.org/).
