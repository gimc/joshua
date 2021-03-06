defmodule Joshua.Router do
  use Joshua.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Joshua do
    pipe_through :api
    resources "/badges", BadgeController, except: [:edit, :new]
    resources "/events", EventController, except: [:edit, :new]
    resources "/progress", ProgressController, only: [:show]
  end

  forward "/graphql", Absinthe.Plug, schema: Joshua.Schema
  forward "/graphiql", Absinthe.Plug.GraphiQL, schema: Joshua.Schema
end
