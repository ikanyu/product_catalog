require "rails_helper"

describe "Categories page request" do
  it "displays all categories #index" do
    category = create(:category)

    get categories_path

    expect(response).to have_http_status :ok
    expect(response.body).to include category.name
  end

  it "displays form #new" do
    get new_category_path

    expect(response).to have_http_status :ok
  end

  it "displays product details #show" do
    category = create(:category)

    get category_path(category.id)

    expect(response).to have_http_status :ok
  end

  describe "creates category #create" do
    it "successfully" do
      post categories_path, params: {
        category: {
          name: "abc",
          parent_id: ""
        }
      }

      expect(Category.count).to eq 1
      expect(Category.first.name).to eq "abc"
      expect(response).to have_http_status 302

      follow_redirect!

      expect(response).to have_http_status :success
    end

    it "unsuccessfully" do
      post categories_path, params: {
        category: {
          name: "",
          parent_id: ""
        }
      }

      expect(Category.count).to eq 0
      expect(response).to have_http_status :ok
    end
  end

  describe "updates category #update" do
    it "successfully" do
      category = create(:category)

      put category_path(category.id), params: {
        category: {
          name: "new name",
          parent_id: ""
        }
      }

      expect(category.reload.name).to eq "new name"
    end

    it "successfully" do
      category = create(:category)
      category_name = category.name

      put category_path(category.id), params: {
        category: {
          name: nil,
          parent_id: ""
        }
      }

      expect(category.reload.name).to eq category_name
      expect(response).to have_http_status :ok
    end
  end

  it "deletes category #destroy" do
    category = create(:category)

    delete category_path(category.id)

    expect(Category.count).to eq 0
  end

  it "displays form #edit" do
    category = create(:category)
    get edit_category_path(category)

    expect(response).to have_http_status :ok
  end
end

