module Foundry
  def self.setup_foundries(&blk)
    Runner.new.instance_eval(&blk)
  end

  class Runner
    def model(klass, &blk)
      @klass = klass
      @attrs = {}

      instance_eval(&blk)
    end

    def factory(name, definition=nil, &blk)
      if block_given?
        Foundry.factory(@klass, name, &blk)
      elsif definition || !@attrs.empty?
        @attrs.merge!(definition) if definition
        Foundry.factory(@klass, name, @attrs)
      else
        raise ArgumentError, "You need to provide a definition or a lambda/block definition!"
      end
    end

    alias :foundry :factory
  end
end
