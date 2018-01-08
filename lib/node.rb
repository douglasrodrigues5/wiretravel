class Node
    attr_accessor :INIT_LOCATION, :END_LOCATION, :TRAVEL_DISTANCE, :NODE

    def initialize(node)
        @INIT_LOCATION = node[0]
        @END_LOCATION = node[1]
        @TRAVEL_DISTANCE = Integer(node[2])
        @NODE = node
    end

    
end
