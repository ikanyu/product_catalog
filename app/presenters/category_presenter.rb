class CategoryPresenter < SimpleDelegator
  include CollectiveIdea::Acts::NestedSet::Helper

  def options_for_all_categories
    nested_set_options(Category.all) do |category|
      category_label(category)
    end
  end

  def options_exclude_leaf
    options = nested_set_options(Category.all) do |category|
      category_label(category) if !category.leaf?
    end

    options.reject { |c| c[0] == nil }
  end

  def options_exclude_self_level_and_leaf
    options = nested_set_options(Category.all) do |category|
      category_label(category) if not_same_level_and_leaf?(category)
    end

    options.reject { |c| c[0] == nil }
  end

  def hierarchy
    return if blank?

    self_and_ancestors&.pluck(:name)&.join(" > ")
  end

  def root_and_not_new_record?
    root? && !new_record?
  end

  private

  def category_label(category)
    "#{'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' * category.level} #{category.name}".
      html_safe
  end

  def not_same_level_and_leaf?(category)
    !category.leaf? && !(level == category.level)
  end
end
