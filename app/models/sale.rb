class Sale < ActiveRecord::Base

  
  # AR Scope
  def self.active # class method
    where("sales.starts_on <= ? AND sales.ends_on >= ?", Date.current, Date.current)
  end
  # Can also use this instead:
  # scope :active, -> { where("sales.starts_on <= ? AND sales.ends_on >= ?", Date.current, Date.current) }

  def finished?
    ends_on < Date.current # implied self.ends_on
  end

  def upcoming?
    starts_on > Date.current
  end

  def active?
    !upcoming? && !finished?
  end

end
