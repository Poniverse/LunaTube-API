# Lunatube-API

To start app for development:

  * Install dependencies with `mix deps.get`
  * Run `docker-compose up` (add the `-d` if you want have it detach from the terminal and run in the background)
  * Open a new terminal if you didn't specify `-d`
  * Create and migrate the database with `docker-compose run elixir mix ecto.migrate`
  
You should now be able to visit [`localhost:4000`](http://localhost:4000) from your browser.
