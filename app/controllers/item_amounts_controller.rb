class ItemAmountsController < ApplicationController
  before_action :get_item, only: [ :new, :create ]
  before_action :get_item_amount, only: [ :destroy ]

  def new
    @item_amount = ItemAmount.new
  end

  def create
    @item_amount = ItemAmount.new(item_amount_params)
    @item_amount.item = @item
    if @item_amount.save
      log(@item.id, @item_amount.amount, @item_amount.exp_date, "Added new amount: #{@item_amount.amount}, with expiration date:  #{@item_amount.exp_date}")
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def destroy
    @item_amount.destroy

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
