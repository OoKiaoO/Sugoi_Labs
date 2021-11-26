class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :show_item_amount, only: [:show]
  
  def home
  end

  def index
    @items = Item.all
  end

  def show
    @all_amounts = show_item_amount
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save

    redirect_to item_path(@item)
  end

  def edit
  end

  def update
    @item.update(item_params)

    redirect_to items_path(@item)
  end

  def destroy
    @item.destroy

    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :brand, :barcode)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def show_item_amount # check how to bloody use custom methods in cotrollers!
    item = params[:item_id]
    all_amounts = []
    item.item_amounts.each { |item_amount| all_amounts << item_amount.amount }
    all_amounts.sum
  end
end
