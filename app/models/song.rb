class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :artist_name, presence: true
  validates :title, uniqueness: { scope: :release_year }
  validates :released, inclusion: { in: [true, false] }
  validate :release_year_in_past_required_if_released


  def release_year_in_past_required_if_released
    if released
      if !release_year
        errors.add(:release_year, "Release year is required for released songs.")
      elsif release_year > Time.now.year
        errors.add(:release_year, "Release year must not be in the future.")
      end
    end
  end
end
