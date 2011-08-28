class Array
  def pick
    at rand self.size
  end

  def pick!
    delete_at rand self.size
  end
end
