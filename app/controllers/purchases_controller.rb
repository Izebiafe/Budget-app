class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_purchase, only: %i[show edit update destroy]

  def index
    @purchases = Purchase.all
  end

  def show; end

  def new
    @attributes = []
    @purchase = Purchase.new
    @attributes << @purchase
    @categories = current_user.categories
    @attributes << @categories
  end

  def edit
    @attributes = []
    @attributes << @purchase
    @categories = current_user.categories
    @attributes << @categories
  end

  def create
    @attributes = []
    @purchase = Purchase.new(purchase_params)
    @purchase.author = current_user
    category_id = params[:purchase][:category_id]
    if category_id.present?
      category = Category.find(category_id)
      @purchase.categories << category
    end
    @attributes << @purchase
    @categories = current_user.categories
    @attributes << @categories

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to category_url(@purchase.categories[0]), notice: 'Purchase was successfully created.' }
        format.json { render :show, status: :created, location: @purchase }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to purchase_url(@purchase), notice: 'Purchase was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @purchase.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  def purchase_params
    params.require(:purchase).permit(:name, :amount)
  end
end
