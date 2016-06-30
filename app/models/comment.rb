class Comment < ActiveRecord::Base
  validates :content, :author_list, presence: true
  acts_as_taggable
  acts_as_taggable_on :author
end
