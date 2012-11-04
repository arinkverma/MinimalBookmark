class Bookmark < ActiveRecord::Base
	has_many :bookmark_tags
	has_many :tags, :through => :bookmark_tags		
	attr_accessible :url, :tag_ids
	accepts_nested_attributes_for :bookmark_tags
end
