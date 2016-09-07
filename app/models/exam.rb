class Exam < ActiveRecord::Base
  belongs_to :course
  has_many :exam_grades

  validates :date, presence: true

  def bonus_for(p)
    verteilung = Hash[*bonus.split(",")].map{ |k,v| [k.to_i, v.to_f]}.sort.reverse
    verteilung.each do |b|
      if (p.to_f >= b[0].to_f)
        return b[1].to_f
      end
    end
    return 0
  end
end
