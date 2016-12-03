defmodule ESpec.Phoenix.Extend do
  def model do
    quote do
      alias Lunatube.Repo
      import Lunatube.Factory
    end
  end

  def controller do
    quote do
      alias Lunatube
      import Lunatube.Factory
      import Lunatube.Router.Helpers

      @endpoint Lunatube.Endpoint
    end
  end

  def view do
    quote do
      import Lunatube.Router.Helpers
    end
  end

  def channel do
    quote do
      alias Lunatube.Repo
      import Lunatube.Factory

      @endpoint Lunatube.Endpoint
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
