class Link < ApplicationRecord
  belongs_to :user

  validates :slug, uniqueness: true, presence: true, allow_blank: false
  validates :url, presence: true, allow_blank: false

  validate :url_matches_pattern,
           :url_has_no_restricted_words,
           :slug_matches_pattern,



  def url_matches_pattern
      errors.add(:url, "must begin with http://") unless url =~ /https?:\/\/[\w|.]+$/
  end

  def url_has_no_restricted_words
    %w[links users].each do |word|
      errors.add(:url, "cannot begin with #{word}") if url =~ /$#{word}\/\/[\w|.]+$/
    end
  end

  def slug_matches_pattern
    errors.add(:slug, "must only contain numbers and letters") unless slug =~ /^[\w]+$/
  end


  def expiration_date_cannot_be_in_the_past
    if expiration_date.present? && expiration_date < Date.today
      errors.add(:expiration_date, "can't be in the past")
    end
  end

  def discount_cannot_be_greater_than_total_value
    if discount > total_value
      errors.add(:discount, "can't be greater than total value")
    end
  end


  after_create do |record|
    record.update(counter: 0)
  end

  def increment_count!
    update(counter: counter + 1)
  end
end