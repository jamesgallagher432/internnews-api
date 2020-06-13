# Intern News API

Intern News is a news aggregator for news about internships and young people working in tech.

![Image of Intern News homepage](https://github.com/jamesgallagher432/internnews-client/blob/master/homepage.png?raw=true)

## Installation

To setup Intern News, follow these steps:

1. Install packages

`bundle install`

2. Set up the database

```
rails db:setup
rails db:migrate
```

3. Create demo user and link

`rails db:seed`

4. Run in development mode

`rails s`

You will also need to install the client to set up Intern News. The code for the Intern News client is hosted [here](https://github.com/jamesgallagher432/internnews-client).

## Stack

This project was built using the following tools:

- Ruby on Rails
- GraphQL
- PostgreSQL

## Contributing

Pull requests to Intern News are welcome. If you want to make a major change, open an issue first so we can discuss what you would like to change.

## License

This project is licensed under the terms of the MIT license.

## Authors and acknowledgment

This project was built by me, James. The inspiration for this project was Y Combinator's [Hacker News](https://news.ycombinator.com), and the [How to GraphQL](https://howtographql.com) tutorial on building a news aggregator.
