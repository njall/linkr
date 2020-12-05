require 'rails_helper'

RSpec.describe "links/edit", type: :view do
  before(:each) do
    @link = assign(:link, Link.create!(
      slug: "MyString",
      url: "MyString",
      counter: 1,
      user: nil
    ))
  end

  it "renders the edit link form" do
    render

    assert_select "form[action=?][method=?]", link_path(@link), "post" do

      assert_select "input[name=?]", "link[slug]"

      assert_select "input[name=?]", "link[url]"

      assert_select "input[name=?]", "link[counter]"

      assert_select "input[name=?]", "link[user_id]"
    end
  end
end
