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

  it "creates category #create" do
    post categories_path, params: {
      category: {
        name: "abc",
        parent_id: ""
      }
    }

    expect(Category.first.name).to eq "abc"
  end

  it "updates category #update" do
    category = create(:category)

    put category_path(category.id), params: {
      category: {
        name: "new name",
        parent_id: ""
      }
    }

    expect(category.reload.name).to eq "new name"
  end

  it "deletes category #destroy" do
    category = create(:category)

    delete category_path(category.id)

    expect(Category.count).to eq 0
  end
end

