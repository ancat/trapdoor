class Secret_FS
  def initialize(base:)
    @base = base
  end

  def [](key)
    open("#{@base}/#{key.downcase}.txt").read
  end

  def []=(key, value)
    raise "NOOOOOOOOOO"
  end
end
