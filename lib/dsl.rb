module Foundry
  def self.setup_foundries(&blk)
    Runner.new.instance_eval(&blk)
  end

  class Runner
    def model(klass, &blk)
      @klass = klass
      @attrs = {}

      instance_eval(&blk)
      add_with_scope unless klass.respond_to?(:with)
    end

    def factory(name, definition=nil, &blk)
      if block_given?
        behavior = proc { {:conditions => blk.call} }
        Foundry.factory(@klass, name, &behavior)
      elsif definition || !@attrs.empty?
        @attrs.merge!(definition) if definition
        Foundry.factory(@klass, name, @attrs)
      else
        raise ArgumentError, "You need to provide a definition or a lambda/block definition!"
      end
    end
    
    alias :foundry :factory
    
  private
    def add_with_scope
      Foundry.factory(@klass, :with) do |opts|
        {:conditions => opts}
      end
    end
  end
end
