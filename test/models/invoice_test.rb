require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    # This code is not idiomatically correct.
    @invoice = @user.invoices.build(content: "Lorem ipsum", amount: 999.99)
  end

  test "should be valid" do
    assert @invoice.valid?
  end

  test "user id should be present" do
    @invoice.user_id = nil
    assert_not @invoice.valid?
  end
  
  test "content should be present " do
    @invoice.content = "   "
    assert_not @invoice.valid?
  end

  test "content should be at most 140 characters" do
    @invoice.content = "a" * 141
    assert_not @invoice.valid?
  end
  
  test "order should be most recent first" do
    assert_equal Invoice.first, invoices(:most_recent)
  end
end
