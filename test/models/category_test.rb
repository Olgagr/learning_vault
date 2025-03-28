require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "validates presence of name" do
    category = Category.new(name: nil)
    assert_not category.valid?
    assert_equal [ "can't be blank" ], category.errors[:name]
  end

  test "validates uniqueness of name within user" do
    category = Category.new(name: "Books", user: users(:one))
    assert_not category.valid?
    assert_equal [ "has already been taken" ], category.errors[:name]
  end
end
