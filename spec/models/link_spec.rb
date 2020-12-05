require 'rails_helper'

RSpec.describe Link, type: :model do

  before do
    @user = User.create!(email: "bob@example.com", password: "horses", first_name: "Bob")
  end


  context 'valid slug and url' do
    it 'creates a link' do
      expect { link = @user.links.create(slug: "blah", url: "http://google.com") }.to change{ Link.count }.by(1)
    end

    it 'initiates counter to zero' do
      link = @user.links.create(slug: "blah", url: "http://google.com")
      expect(link.counter).to be 0
    end
  end

  context 'blank slug or url' do
    it 'should give errors' do
      expect { @user.links.create!(slug: '', url: '') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'url or slug with spaces in' do
    it 'should give errors' do
      expect { @user.links.create!(slug: 'this is not ideal for a url', url: 'http://google.com') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { @user.links.create!(slug: 'slug', url: 'http://google.com or something') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'incorrect url format' do
    it 'should give errors' do
      expect { @user.links.create!(slug: 'slug', url: 'htpak31') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { @user.links.create!(slug: 'slug', url: 'http//:nope') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'slug already exists' do
    it 'should give errors' do
      @user.links.create!(slug: 'slug', url: 'http://google.com')
      expect { @user.links.create!(slug: 'slug', url: 'http://twoogle.com') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'hyphens and underscores are okay for slugs' do
    it 'should give errors' do
      expect { @user.links.create!(slug: 'slug-with-hyphen_and_underscore', url: 'http://twoogle.com') }.to change{ Link.count }.by(1)
    end
  end

  context 'slug should not start with links or users' do
    it 'should give errors' do
      expect { @user.links.create!(slug: 'links/3', url: 'http://twoogle.com') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { @user.links.create!(slug: 'users/new', url: 'http://twoogle.com') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end


  context '#increment_counter!' do
    before do
      @link = @user.links.create(slug: "blah", url: "http://google.com")
    end
    it 'increments counter by 1' do
      expect(@link.counter).to be 0

      expect { @link.increment_count! }.to change { @link.counter }.by(1)
    end
  end


end
