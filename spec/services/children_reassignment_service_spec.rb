require "rails_helper"

describe "Node reassignment" do
  describe "Parent category" do
    context "has child" do
      it "move child to root when deleting itself" do
        category = create(:category)
        sub_category = setup_sub_category(category)

        ChildrenReassignmentService.new(category).perform
        category.delete
        sub_category.reload

        expect(sub_category.parent).to_not eq category
        expect(sub_category.root?).to eq true
      end
    end
  end

  describe "Sub category" do
    context "has parent and child" do
      it "moves child to immediate parent when deleting itself" do
        category = create(:category)
        sub_category = setup_sub_category(category)
        sub_sub_category = setup_sub_category(sub_category)

        ChildrenReassignmentService.new(sub_category).perform
        sub_category.delete
        sub_sub_category.reload
        category.reload

        expect(sub_sub_category.parent).to eq category
        expect(category.children[0]).to eq sub_sub_category
      end
    end

    context "has parent and no child" do
      it "moves children to root when deleting itself" do
        category = create(:category)
        sub_category = setup_sub_category(category)

        ChildrenReassignmentService.new(category).perform
        sub_category.delete
        category.reload

        expect(category.children.count).to eq 0
      end
    end
  end

  describe "Sub sub category" do
    context "has parent" do
      it "does not affect existing record when deleting itself" do
        category = create(:category)
        sub_category = setup_sub_category(category)
        sub_sub_category = setup_sub_category(sub_category)

        ChildrenReassignmentService.new(sub_sub_category).perform
        sub_sub_category.delete
        sub_category.reload

        expect(sub_category.children.count).to eq 0
      end
    end
  end

  private

  def setup_sub_category(category)
    sub_category = create(:category)
    sub_category.move_to_child_of(category)
  end
end
