class CategoryPresenter < SimpleDelegator
  include CollectiveIdea::Acts::NestedSet::Helper

  def options_for_all_categories
    nested_set_options(Category.all) do |category|
      category_label(category)
    end
  end

  def categories_options_exclude_leaf
    options = nested_set_options(Category.all) do |category|
      category_label(category) if !category.leaf?
    end

    options.reject{ |c| c[0] == nil}
  end

  def category_label(category)
    "#{'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' * category.level} #{category.name}".html_safe
  end
end
