class ItemAmountsController < ApplicationController
  before_action :get_item, only: [ :new, :create, :update, :edit ]
  before_action :get_item_amount, only: [ :update, :destroy, :edit ]

  def new
    @item_amount = ItemAmount.new()
  end

  def create
    @item_amount = ItemAmount.new(item_amount_params)
    @item_amount.item = @item

    respond_to do |format|
      if @item_amount.save
        log(@item.id,
            "Added new amount: #{@item_amount.amount}, with expiration date:  #{@item_amount.exp_date}",
            @item_amount.amount,
            @item_amount.exp_date)
        format.html { redirect_to item_path(@item, anchor: "reload") }
        format.json # normal Rails flow will look for a file called 'create.json'
      else
        format.html { render "items/#{@item.id}" }
        format.json
      end
    end
  end

  def edit
  end

  def update
    @item_amount.update!(item_amount_params)

    if @item_amount.save
      log(@item.id, "Updated item's info")
    end

    redirect_to item_path(@item)
  end

  def destroy
    @item_amount.destroy
    log(@item_amount.item_id, "Deleted amount: #{@item_amount.amount}")

    redirect_to item_path(@item_amount.item)
  end

  # def manage(item_amount)
  #   @item_amount = item_amount

  #   @item_amount.checked = true
  #   @item_amount
  # end

  private
  def item_amount_params
    params.require(:item_amount).permit(:amount, :exp_date, :checked, :exp_amount, :item)
  end

  def get_item_amount
    @item_amount = ItemAmount.find(params[:id])
  end

  def get_item
    @item = Item.find(params[:item_id])
  end

  def check(item_amount)
    item_amount.toggle(:checked)
  end
end
