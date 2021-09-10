class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: {minimum: 250}
  validates :summary, length: {maximum: 250}
  validate :clickbait_title?

  category_inclusion_keywords = ["Fiction", "Non-Fiction"]
  validates :category, inclusion: {in: category_inclusion_keywords}

  CLICKBAIT= ["Won't Believe", "Secret", "Guess"]
  i = 0

  # Top 1 to Top 100 add to list
  while i <= 100 do
    CLICKBAIT << "Top " + i.to_s
    i = i + 1
  end


  def clickbait_title?
    if title == nil || CLICKBAIT.none? {|keyword| title.include?(keyword)}
      errors.add(:title, "must be clickbait")
    end
  end
end
