# two scenarios:
# a) if the form saves, we want to send back the saved item_amount to display on the page (html -> partials) + a blank form (cause it won't update automatically due to the event.preventDeafult() behaviour)
# b) if it won't save, we want to send back the form as is along with the associated error messages

if @item_amount.persisted?
  json.inserted_item json.partial!('items/item_amounts_show.html.erb', locals: { item_amount: @item_amount })
  json.form json.partial!('new_item_amount_form.html.erb', locals: { item: @item, item_amount: ItemAmount.new })
else
  json.form json.partial!('new_item_amount_form.html.erb', locals: { item: @item, item_amount: @item_amount })
end
