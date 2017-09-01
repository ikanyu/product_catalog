require "rails_helper"

describe CategoryPresenter do
  describe "options_for_all_categories" do
    it "returns all categories" do
      category_presenter = CategoryPresenter.new(Category.new)

      category = create(:category)
      sub_category = setup_sub_category(category)

      result = [
        [" #{category.name}", category.id],
        [
          "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #{sub_category.name}",
          sub_category.id
        ]
      ]

      expect(category_presenter.options_for_all_categories).to eq result
    end

    it "returns categories and exclude those without child" do
      category_presenter = CategoryPresenter.new(Category.new)

      category = create(:category)
      setup_sub_category(category)

      result = [
        [" #{category.name}", category.id]
      ]

      expect(category_presenter.options_exclude_leaf).to eq result
    end

    it "returns categories' hierarchy" do
      category = create(:category)
      sub_category = setup_sub_category(category)

      category_presenter = CategoryPresenter.new(sub_category)

      expect(category_presenter.hierarchy).
        to eq "#{category.name} > #{sub_category.name}"
    end

    it "returns categories without same level and root" do
      category = create(:category)
      sub_category = setup_sub_category(category)
      setup_sub_category(sub_category)
      category_presenter = CategoryPresenter.new(sub_category)

      expect(category_presenter.options_exclude_self_level_and_leaf).
        to eq [[" #{category.name}", category.id]]
    end
  end

  private

  def setup_sub_category(category)
    sub_category = create(:category)
    sub_category.move_to_child_of(category)
  end
end
