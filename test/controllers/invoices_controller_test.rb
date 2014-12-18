require 'test_helper'

class InvoicesControllerTest < ActionController::TestCase
  
  def setup
    @invoice = invoices(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Invoice.count' do
      post :create, invoice: { content: "Lorem ipsum", amount: 999.99 }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Invoice.count' do
      delete :destroy, id: @invoice
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy for wrong invoice" do
    log_in_as(users(:michael))
    invoice = invoices(:ants)
    assert_no_difference 'Invoice.count' do
      delete :destroy, id: invoice
    end
    assert_redirected_to root_url
  end
end
