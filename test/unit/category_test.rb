require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  ## Category Name
  def test_should_not_create_category_with_empty_name
    cat = build_category("")
    assert !cat.save, "Saved category with empty name"
  end
  private
  def build_category(name)
    cat = Category.new
    cat.name= name
    cat
  end
end
