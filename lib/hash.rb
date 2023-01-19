class Secret_Hash
  attr_accessor :hash

  def initialize(hash:)
    @hash = hash
  end

  def [](key)
    @hash[key]
  end

  def []=(key, value)
    raise "No writing please"

    @hash[key] = value
  end
end
