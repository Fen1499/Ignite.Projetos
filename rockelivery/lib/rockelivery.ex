defmodule Rockelivery do
 defdelegate create_user(params), to: Rockelivery.Users.Create, as: :call
end
