# Agreed

Agreed is a ruby gem which provides some tools for assessing statistical agreement. This can be useful in a number of
scenarios, for example - if you wanted to assess whether an algorithm could classify something as well as a subject
matter expert.

As of now, only the Cohen's Kappa statistic is supported but if you have a need for additional functionality feel free
to submit submit an issue or a pull request.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'agreed'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install agreed

## Usage

### Cohen's Kappa

```
rater1 = ['yes','no','no','yes','yes']
rater2 = ['no','yes','no','yes','yes']

ck = Agreed::CohensKappa.new(rater1, rater2)

ck.kappa # => 0.166666
ck.p # => 0.6
ck.p_e # => 0.52
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dansbits/agreed.

