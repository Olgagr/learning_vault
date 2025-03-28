require "test_helper"

class ResourceTest < ActiveSupport::TestCase
  test "validates presence of name" do
    resource = Resource.new(name: nil)
    assert_not resource.valid?
    assert_equal [ "can't be blank" ], resource.errors[:name]
  end

  test "validates of link" do
    resource = Resource.new(link: nil)
    assert_not resource.valid?
    assert_equal [ "can't be blank", "must be a valid URL" ], resource.errors[:link]
  end

  test "validates format of link" do
    resource = Resource.new(link: "invalid-link")
    assert_not resource.valid?
    assert_equal [ "must be a valid URL" ], resource.errors[:link]
  end

  test "validates presence of user" do
    resource = Resource.new(user: nil)
    assert_not resource.valid?
    assert_equal [ "must exist" ], resource.errors[:user]
  end

  test "validates uniqueness of name within user" do
    resource = Resource.new(name: resources(:one).name, user: users(:one))
    assert_not resource.valid?
    assert_equal [ "has already been taken" ], resource.errors[:name]
  end
end
