# Lunatube-API

To start app for development:

  * Install dependencies with `mix deps.get`
  * Run `docker-compose up` (Run it in the foreground, don't detach it and run as a daemon)
  * Open a new terminal
  * Create and migrate the database with `docker-compose run elixir mix ecto.migrate`
  
**WARNING:** It is heavily recommended to run docker in the terminal 
 without daemonization. Running as a daemon leaves makes it harder
 to find out what the cause of the app crash may or may not be.

You should now be able to visit [`localhost:4000`](http://localhost:4000) from your browser.
