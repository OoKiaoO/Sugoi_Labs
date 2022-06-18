class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :show_item_amount]
  # skip_before_action :authenticate_user!, only: (:home) -> Uncomment for landing page/page that doesn't require login
  
  def home
  end

  def index
    if params[:query].present?
      @items = Item.search_by_all_item_info(params[:query])
    elsif params[:filter].present? && params[:filter] == 'brand'
      @items = Item.all.order(brand: :asc)
    elsif params[:filter].present? && params[:filter] == 'category'
      @items = Item.all.order(category: :asc)
    elsif params[:filter].present? && params[:filter] == 'location'
      @items = Item.all.order(location: :asc)
    else
      @items = Item.all.order(name: :asc)
    end
  end

  def show
    @total_amount = show_item_amount
    
    sorted_amounts = @item.item_amounts.order(exp_date: :asc)
    expiring = sorted_amounts.first.amount
    upcoming = sorted_amounts[1].amount
    remaining_amounts = sorted_amounts.drop(2)
    remaining_amount = []
    remaining_amounts.each { |amount| remaining_amount << amount.amount }
    remaining_total = remaining_amount.sum
    @data_values = [expiring, upcoming, remaining_total]
    @data_keys = ['Expiring next', 'Upcoming', 'Remaining']
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
    params.require(:item).permit(:name, :brand, :barcode, :secondary_barcode, :description, :category, :location, :retail)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def show_item_amount
    all_amounts = []
    @item.item_amounts.each { |item_amount| all_amounts << item_amount.amount }
    all_amounts.sum
  end

  # def pie_chart_amounts
  #   sorted_amounts = @item.item_amounts.order(exp_date: :asc)
  #   @upcoming = sorted_amounts.first.amount
  #   remaining_amounts = sorted_amounts.drop(1)
  #   remaining_amount = []
  #   remaining_amounts.each { |amount| remaining_amount << amount.amount }
  #   @remaining_total = remaining_amount.sum
  # end
end
