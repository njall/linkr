class Link < ApplicationRecord
  belongs_to :user

  validates :url, :slug, presence: true, allow_blank: false

  after_create do |record|
    record.update(counter: 0)
  end

  def increment_count!
    update(counter: counter + 1)
  end
end
