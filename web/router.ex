defmodule Joshua.Router do
  use Joshua.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Joshua do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", Joshua do
    pipe_through :api
    resources "/badges", BadgeController, except: [:new, :edit]
  end
end
