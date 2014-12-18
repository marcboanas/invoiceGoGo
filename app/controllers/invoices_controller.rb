class InvoicesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @invoice = current_user.invoices.build(invoice_params)
    if @invoice.save
      flash[:success] = "Invoice created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @invoice.destroy
    flash[:sucess] = "Invoice deleted"
    redirect_to request.referrer || root_url
  end

  private

    def invoice_params
      params.require(:invoice).permit(:content, :amount, :picture)
    end
  
    def correct_user
      @invoice = current_user.invoices.find_by(id: params[:id])
      redirect_to root_url if @invoice.nil?
    end
end
