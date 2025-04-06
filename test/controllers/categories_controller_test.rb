require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @valid_params = { category: { name: "New Category", description: "Test description" } }
  end

  test "should create category with valid parameters" do
    assert_difference("Category.count") do
      post categories_url, params: @valid_params
    end

    assert_redirected_to categories_url
    assert_equal "Category created", flash[:notice]
  end

  test "should create category with Turbo Stream format" do
    assert_difference("Category.count") do
      post categories_url, params: @valid_params, as: :turbo_stream
    end

    assert_response :success
    assert_equal "text/vnd.turbo-stream.html; charset=utf-8", response.content_type
    assert_equal "Category created", flash.now[:notice]

    # 1. Test flash update stream
    # Asserts a stream exists targeting 'flashes' with action 'update'
    # and checks its template content
    assert_select "turbo-stream[action='update'][target='flashes']" do |elements|
      assert_equal 1, elements.count, "Expected exactly one turbo-stream updating flashes"
      assert_select "template" do # Selects the template within this specific stream
         # Be more specific if possible, e.g., assert_select "div#flash-notice", text: "Category created"
         # Adjust selector based on your shared/flash partial structure
         assert_select ".flash", text: "Category created"
      end
    end

    assert_select "turbo-stream[action='prepend'][target='categories']" do |elements|
      assert_equal 1, elements.count, "Expected exactly one turbo-stream updating categories"
      assert_select "template" do
        category = Category.last
        assert_select "##{dom_id(category)}", html: /#{category.name}/
      end
    end

    assert_select "turbo-stream", count: 2
  end

  test "should not create category with invalid parameters" do
    assert_no_difference("Category.count") do
      post categories_url, params: { category: { name: "" } }
    end

    assert_response :unprocessable_entity
  end

  test "should not create category for unauthenticated user" do
    sign_out

    assert_no_difference("Category.count") do
      post categories_url, params: { category: { name: "New Category" } }
    end

    assert_redirected_to new_session_url
  end
end
