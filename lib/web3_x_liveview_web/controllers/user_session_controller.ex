defmodule Web3XLiveviewWeb.UserSessionController do
  use Web3XLiveviewWeb, :controller

  alias Web3XLiveview.Accounts
  alias Web3XLiveview.Accounts.User
  alias Web3XLiveviewWeb.{LoginLive, UserAuth}

  def new(conn, _params) do
    Phoenix.LiveView.Helpers.live_render(conn, LoginLive, session: %{"error_message" => nil})
  end

  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    if user = Accounts.get_user_by_email_and_password(email, password) do
      UserAuth.log_in_user(conn, user, user_params)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      Phoenix.LiveView.Helpers.live_render(conn, LoginLive,
        session: %{"error_message" => "Invalid email or password"}
      )
    end
  end

  def create(conn, params) do
    if user = Accounts.verify_message_signature(params["public_address"]) do
      UserAuth.log_in_user(conn, user)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      Phoenix.LiveView.Helpers.live_render(conn, LoginLive,
        session: %{"error_message" => "Invalid wallet"}
      )
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
