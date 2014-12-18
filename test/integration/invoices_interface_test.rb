require 'test_helper'

class InvoicesInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "invoice interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Invoice.count' do
      post invoices_path, invoice: { content: "" }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    content = "This invoice really ties the room together"
    assert_difference 'Invoice.count', 1 do
      post invoices_path, invoice: { content: content }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete a post.
    assert_select 'a', text: 'delete'
    first_invoice = @user.invoices.paginate(page: 1).first
    assert_difference 'Invoice.count', -1 do
      delete invoice_path(first_invoice)
    end
    # Visit a different user.
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end