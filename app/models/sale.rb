class Sale < ActiveRecord::Base

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
