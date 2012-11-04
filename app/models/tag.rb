class Tag < ActiveRecord::Base
	attr_accessible :name
	has_many :bookmark_tags
	has_many :bookmarks, :through => :bookmark_tags
end
