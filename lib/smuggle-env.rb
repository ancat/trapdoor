ENV.instance_eval do 
  PUBLIC_ENV = ENV.method(:[])
  KEYS = ENV.method(:keys)
  SMUGGLED = {}

  def [](key)
    value = PUBLIC_ENV.call key
    return value unless value.nil?
    return SMUGGLED[key]
  end

  def []=(key, value)
    SMUGGLED[key] = value
  end

  def smuggle(key, value)
    SMUGGLED[key] = value
  end

  def hide(key)
    SMUGGLED[key] = PUBLIC_ENV.call key
    ENV.delete key
  end

  def to_h
    ENV.map{|k,v| [k,v]}.to_h.merge(SMUGGLED.map{|k,v| [k,"**REDACTED**"]}.to_h)
  end

  def inspect
    to_h.inspect
  end
end
