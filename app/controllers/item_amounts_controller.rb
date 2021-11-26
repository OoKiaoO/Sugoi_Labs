class ItemAmountsController < ApplicationController

  # def index
  #   @item_amounts = ItemAmount.all
  # end

  def new
    @item_amount = ItemAmount.new
  end

  def create
    @item_amount = ItemAmount.new(item_amount_params)
    @item_amount.save

    redirect_to item_path(@item_amount.item)
  end

  # def all_amounts
  #   @total_amounts = 
  # end

  private

  def item_amount_params
    params.require(:item_amount).permit(:amount, :exp_date, :item)
  end
end
