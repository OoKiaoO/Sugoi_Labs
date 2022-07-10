class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :show_item_amount]
  # skip_before_action :authenticate_user!, only: (:home) -> Uncomment for landing page/page that doesn't require login
  
  def home
    items = Item.all
    current_month = Date.today
    next_month = Date.today.next_month
    next_next_month = Date.today.next_month(2)
    
    @current_month_items = get_monthly_items(items, get_monthly_range(current_month))
    @next_month_items = get_monthly_items(items, get_monthly_range(next_month))
    @next_next_month_items = get_monthly_items(items, get_monthly_range(next_next_month))
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
    @item_amount = ItemAmount.new
    
    unless @item.item_amounts.empty?
      if @item.item_amounts.count == 1
        @item_amounts = @item.item_amounts.order(created_at: :desc)
        @data_values = [@item.item_amounts.first.amount]
        @data_keys = ['Expiring next']
      else
        chart_data = get_chart_data
        @data_values = chart_data[:data_values]
        @data_keys = chart_data[:data_keys]

        if params[:option] == 'amount'
          @item_amounts = @item.item_amounts.order(amount: :desc)
        elsif params[:option] == 'exp'
          @item_amounts = @item.item_amounts.order(exp_date: :asc)
        elsif params[:option] == 'remaining'
          @item_amounts = @item.item_amounts.order(exp_date: :asc)
        else
          @item_amounts = @item.item_amounts.order(created_at: :desc)
        end
      end
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save!

    if @item.save
      log(@item.id, "Created new item")
    end

    redirect_to item_path(@item)
  end

  def edit
  end

  def update
    @item.update(item_params)

    if @item.save
      log(@item.id, "Updated item's info")
    end

    redirect_to item_path(@item)
  end

  def destroy
    @item.destroy

    redirect_to items_path
  end

  def expiring_soon
    items = Item.all
    current_month = Date.today
    next_month = Date.today.next_month
    next_next_month = Date.today.next_month(2)

    @current_month_items = get_monthly_items(items, get_monthly_range(current_month))
    @next_month_items = get_monthly_items(items, get_monthly_range(next_month))
    @next_next_month_items = get_monthly_items(items, get_monthly_range(next_next_month))

    if params[:start_date].present? && params[:end_date].present?
      range = (params[:start_date]..params[:end_date])
      @filtered_items = get_monthly_items(items, range)
    elsif params[:monthly_items].present?
      @filtered_items = {
        items: params[:monthly_items].map { |item| Item.find(item) }
      }
    end
    
    # raise
  end

  #######################################################################################
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

  def get_chart_data
    sorted_exp_date = @item.item_amounts.order(exp_date: :asc)
    expiring_next = sorted_exp_date.first.amount
    upcoming = sorted_exp_date[1].amount
    remaining_amounts = sorted_exp_date.drop(2)
    remaining_amount = []
    remaining_amounts.each { |amount| remaining_amount << amount.amount }
    remaining_total = remaining_amount.sum
    {
      data_values: [expiring_next, upcoming, remaining_total],
      data_keys: ['Expiring next', 'Upcoming', 'Remaining']
    }
  end

  def get_monthly_range(month)
    beginning_of_month = month.beginning_of_month
    end_of_month = beginning_of_month.end_of_month
    (beginning_of_month..end_of_month)
  end

  def get_monthly_items(items, range)
    items_results = []
    total_items = 0

    items.each do |item|
      results = item.item_amounts.where(exp_date: range) # check for item_amounts with exp_date in current month
      unless results.empty? # unless the search for exp_dates in current month returned empty, do hte following:
        items_results << item # save the current item in results array, to be used to be displayed in expiring soon view page
        total_items += results.sum(:amount) # get the total number of item_amounts included in teh specified range & add to total
      end
    end
    {
      items: items_results,
      total_items: total_items
    }
  end

end
