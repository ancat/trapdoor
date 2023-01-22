class Secret_FS
  def initialize(base:)
    @base = base
    @cache = {}
  end

  def [](key)
    return @cache[key] if @cache.include? key
    return @cache[key] = get_secret(secret: key)
  end

  def []=(key, value)
    raise "NOOOOOOOOOO"
  end

  private

  def get_secret(secret:)
    open("#{@base}/#{secret.downcase}.txt").read
  end
end
