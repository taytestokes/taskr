defmodule TaskrWeb.Router do
  use TaskrWeb, :router

  # Makes the is_authenticated function  plug available for
  # use in the router that gets plugged into the pipeline used
  # the tasks endpoints
  import TaskrWeb.Plugs.Authenticator, only: [is_authenticated: 2]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TaskrWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # Custom auth plug that fetches the user
    # based off of the user id stored in the session
    # and stores the user into the session as :current_user
    # or if the user id doesn't exist, :current_user will be nil
    plug TaskrWeb.Plugs.Authenticator
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/dashboard", TaskrWeb do
    pipe_through [:browser, :is_authenticated]
    # Dashboard Home
    get "/", DashboardController, :index
    # Task Routes
    post "/tasks", TaskController, :create
    put "/tasks/:task_id/toggle", TaskController, :toggle
    get "/tasks/:task_id", TaskController, :show

    # get "/collections/:collection_id/tasks/toggle/:task_id", TaskController, :toggle
    # delete "/collections/:collection_id/tasks/:task_id", TaskController, :delete

    # get "/new", TaskController, :new
    # get "/:id", TaskController, :show
    # get "/:id/edit", TaskController, :edit
    # put "/:id", TaskController, :update
  end

  scope "/", TaskrWeb do
    pipe_through [:browser]

    get "/", PageController, :index
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", TaskrWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TaskrWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
