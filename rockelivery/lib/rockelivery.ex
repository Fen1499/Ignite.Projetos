defmodule Rockelivery do
 defdelegate create_user(params), to: Rockelivery.Users.Create, as: :call
 defdelegate get_user_by_id(id), to: Rockelivery.Users.Get, as: :by_id
end
