class Array
  def where(params)
    self.select do |hash|
      params.all? do |key, value|
        hash[key] == value || hash[key] =~ Regexp.new(value.to_s)
      end
    end
  end
end
