class ItemAmountsController < ApplicationController
  before_action :get_item, only: [ :create, :update ]
  before_action :get_item_amount, only: [ :destroy, :edit ]

  def create
    @item_amount = ItemAmount.new(item_amount_params)
    @item_amount.item = @item
    if @item_amount.save
      log(@item.id,
          "Added new amount: #{@item_amount.amount}, with expiration date:  #{@item_amount.exp_date}",
          @item_amount.amount,
          @item_amount.exp_date,
        )

      redirect_to item_path(@item, anchor: "reload")
    else
      render "item/#{@item.id}"
    end
  end

  def edit
  end

  def update
    @item_amount.update(item_amount_params)

    if @item_amount.save
      log(@item.id, "Updated item's info")
    end

    redirect_to items_path(@item)
  end

  def destroy
    @item_amount.destroy
    log(@item_amount.item_id, "Deleted amount: #{@item_amount.amount}")

    redirect_to item_path(@item_amount.item)
  end

  private

  def item_amount_params
    params.require(:item_amount).permit(:amount, :exp_date, :item)
  end

  def get_item_amount
    @item_amount = ItemAmount.find(params[:id])
  end

  def get_item
    @item = Item.find(params[:item_id])
  end
end
