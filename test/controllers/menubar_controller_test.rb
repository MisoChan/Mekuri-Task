require 'test_helper'

class MenubarControllerTest < ActionDispatch::IntegrationTest
  test "should get sidebar" do
    get menubar_sidebar_url
    assert_response :success
  end

end
