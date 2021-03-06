class Parking < ApplicationRecord

  belongs_to :user, :optional => true

  #valid
  validates_presence_of :parking_type, :start_at
  validates_inclusion_of :parking_type, :in => ["guest", "short-term", "long-term"]
  validate :validate_end_at_with_amount

  def validate_end_at_with_amount
    if ( end_at.present? && amount.blank? )
      errors.add(:amount, "有結束時間就必須有金額")
    end

    if ( end_at.blank? && amount.present? )
      errors.add(:end_at, "有金額就必須有結束時間")
    end
  end

  
  def duration
    ( end_at - start_at ) / 60
  end

  def calculate_amount
    if self.amount.blank? && self.start_at.present? && self.end_at.present?
      if self.user.blank?
        self.amount = calculate_guest_term_amount  # 一般費率
      elsif self.parking_type == "long-term"
          self.amount = calculate_long_term_amount # 長期費率
      elsif self.parking_type == "short-term"
        self.amount = calculate_short_term_amount  # 短期費率
      end
    end
  end

  def calculate_guest_term_amount
    if duration <= 60
      self.amount = 200
    else
      self.amount = 200 + ((duration - 60).to_f / 30).ceil * 100
    end
  end

  def calculate_short_term_amount
    if duration <= 60
      self.amount = 200
    else
      self.amount = 200 + ((duration - 60).to_f / 30).ceil * 50
    end
  end

end
