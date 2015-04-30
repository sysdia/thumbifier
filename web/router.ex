defmodule Thumbifier.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug Thumbifier.Plug.Authenticated
  end

  scope "/", Thumbifier do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/users", Thumbifier do
    pipe_through :api
    post "/", UserController, :create

    pipe_through :authenticated
    get "/:email", UserController, :show
  end
end
