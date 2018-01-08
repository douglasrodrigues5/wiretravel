require_relative "node"

class Graph
    def initialize(route_string)
        @nodes = []
        #for the distance
        @valid_nodes = []
        #for the future recursive function
        @node_string = route_string.split(', ')
        #creates an array with all the given nodes
        @node_string.each { |node|
            reg_node = registryNode(node)
            #create a node
            reg_node_model = {
                id: reg_node.INIT_LOCATION,
                valids: []
            }
            #saves possible nodes for a given city(Ex: "A") and creates an object
            @nodes.push(reg_node)
            
            reg_node_model[:valids] << reg_node.INIT_LOCATION
            reg_node_model[:valids] << reg_node.END_LOCATION
            #reg_node_model[:distance] = distanceBetween(reg_node.INIT_LOCATION + reg_node.END_LOCATION)
            @valid_nodes.push(reg_node_model)
        } 
    end

    def registryNode(node_string)
        #return a new Node object
        node = Node.new(node_string) 
        return node
    end

    def distanceBetween(node)
        node_model = validateNode(node)
        if node_model[:valid]
        #if the node is valid, return the distance
            return node_model[:distance]
        else 
        #return an error message
            return node_model[:message]
        end
    end

    def validateNode(node)
        distance = 0
        passed_nodes = 0
        stops = 0
        #initializing vars

        node_model = {
            valid: nil,
            distance: nil,
            message: nil
        }

        node_array = node.split("")

        #get distance by actual city and next city and so on.
        node_array.each_with_index{ |e, i| 
            @nodes.each{|x|
                if x.INIT_LOCATION == e && x.END_LOCATION == node.split("")[i+1]
                    distance += x.TRAVEL_DISTANCE
                    passed_nodes += 1
                end
            }
        }

        if passed_nodes === (node.size - 1)
            node_model[:valid] = true
            node_model[:distance] = distance
            node_model[:message] = "SUCCESS."
            return node_model
        end

        node_model[:valid] = false
        node_model[:message] = "NO SUCH ROUTE"
        
        return node_model
    end
end