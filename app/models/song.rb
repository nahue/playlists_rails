class Song < ApplicationRecord
  belongs_to :band
  has_rich_text :description
end
