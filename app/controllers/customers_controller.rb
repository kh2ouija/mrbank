class CustomersController < ApplicationController

  before_action :set_customer, only: [:show, :edit, :update, :destroy, :settings]

  # GET /customers
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)
    account = Account.default
    account.customer = @customer
    begin
      Customer.transaction do
        @customer.save!
        account.save!
        redirect_to @customer, notice: 'Customer was successfully created.'
      end
    rescue ActiveRecord::RecordInvalid => e
      puts e
      render action: 'new'
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: 'Customer was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /customers/1
  def destroy
    @customer.destroy
      redirect_to customers_url
  end

  private
    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:name)
    end
end
