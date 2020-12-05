require 'rails_helper'

RSpec.describe "links/index", type: :view do
  before(:each) do
    assign(:links, [
      Link.create!(
        slug: "Slug",
        url: "Url",
        counter: 2,
        user: nil
      ),
      Link.create!(
        slug: "Slug",
        url: "Url",
        counter: 2,
        user: nil
      )
    ])
  end

  it "renders a list of links" do
    render
    assert_select "tr>td", text: "Slug".to_s, count: 2
    assert_select "tr>td", text: "Url".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
