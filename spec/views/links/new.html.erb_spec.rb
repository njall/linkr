require 'rails_helper'

RSpec.describe "links/new", type: :view do
  before(:each) do
    assign(:link, Link.new(
      slug: "MyString",
      url: "MyString",
      counter: 1,
      user: nil
    ))
  end

  it "renders new link form" do
    render

    assert_select "form[action=?][method=?]", links_path, "post" do

      assert_select "input[name=?]", "link[slug]"

      assert_select "input[name=?]", "link[url]"

      assert_select "input[name=?]", "link[counter]"

      assert_select "input[name=?]", "link[user_id]"
    end
  end
end
