module TrapdoorCore
  OLD_HASH = ENV.method(:[])
  OLD_ASSIGN = ENV.method(:[]=)
  OLD_TO_H = ENV.method(:to_h)
  SMUGGLED = {}

  def start_smuggling(backend:)
    @backend = backend
    @smuggling = true

    define_singleton_method(:[], self.method(:hash_get))
    define_singleton_method(:[]=, self.method(:hash_set))
    define_singleton_method(:to_h, self.method(:to_h))
    define_singleton_method(:trapdoor_set?, ->() { true })
  end

  def hash_get(key)
    value = OLD_HASH.call key
    return value unless value.nil?
    return @backend[key] if @smuggling
  end

  def hash_set(key, value)
    if @smuggling
      @backend[key] = value
    else
      OLD_ASSIGN.call(key, value)
    end
  end

  def trapdoor_set?
    false
  end

  def to_h
    original = OLD_TO_H.call.to_h
    original += @backend.loaded.map { |k|
      [k, "**REDACTED**"]
    } if @backend.respond_to? :loaded

    return original
  end

  def inspect
    to_h.inspect
  end
end

