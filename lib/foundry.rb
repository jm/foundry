module Foundry
  def self.factory(model, name=nil, definition=nil, &block)
    name ||= :valid

    raise ArgumentError, "#{model.name} already has a method/scope named #{name}" if model.respond_to?(name)

    if definition.is_a? Hash
      definition = { :conditions => definition }
    elsif block_given?
      definition = block
    else
      raise ArgumentError, "You need to provide a definition or a lambda/block definition!"
    end

    model.named_scope name, definition
  end

  class <<self
    alias :foundry :factory
  end
end
