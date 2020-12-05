require 'rails_helper'

RSpec.describe Link, type: :model do

  before do
    @user = User.create!(email: "bob@example.com", password: "horses", first_name: "Bob")
  end


  context 'valid slug and url' do
    it 'creates a link' do
      expect { @user.links.create(slug: "blah", url: "http://google.com") }.to change{ Link.count }.by(1)
    end
  end

  context 'blank slug or url' do
    it 'should give errors' do
      expect { @user.links.create!(slug: '', url: '') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end


end
