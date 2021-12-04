class ItemAmountsController < ApplicationController
  before_action :get_item, only: [ :new, :create ]
  # before_action :set_item_amount, only: [ :destroy ]

  def new
    @item_amount = ItemAmount.new
  end

  def create
    @item_amount = ItemAmount.new(item_amount_params)
    @item_amount.item = @item
    @item_amount.save

    redirect_to item_path(@item)
  end

  # def destroy
  #   @item_amount.destroy

  #   redirect_to item_item_amounts_path(@item)
  # end

  private

  def item_amount_params
    params.require(:item_amount).permit(:amount, :exp_date, :item)
  end

  # def set_item_amount
  #   @item_amount = @item.item_amounts.find(params[:id])
  # end

  def get_item
    @item = Item.find(params[:item_id])
  end
end
