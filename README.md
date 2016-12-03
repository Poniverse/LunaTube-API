# Lunatube-API

To start app for development:

  * Install dependencies with `mix deps.get`
  * Run `docker-compose up -d` to start background servers (postgres for now)
  * Create and migrate the database with `mix ecto.migrate`
  * Run `iex -S mix phoenix.server` (This allows you to [pry](http://blog.plataformatec.com.br/2016/04/debugging-techniques-in-elixir-lang/) at any time)

You should now be able to visit [`localhost:4000`](http://localhost:4000) from your browser.
