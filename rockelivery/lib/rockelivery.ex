defmodule Rockelivery do
 defdelegate create_user(params), to: Rockelivery.Users.Create, as: :call
 defdelegate delete_user(id), to: Rockelivery.Users.Delete, as: :call
 defdelegate get_user_by_id(id), to: Rockelivery.Users.Get, as: :by_id
 defdelegate update_user(id), to: Rockelivery.Users.Update, as: :call

 defdelegate create_item(params), to: Rockelivery.Items.Create, as: :call
 defdelegate create_order(params), to: Rockelivery.Orders.Create, as: :call

end
