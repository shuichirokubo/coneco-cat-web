class InstagramCat < ActiveRecord::Base
  soft_deletable
  paginates_per 30
end
