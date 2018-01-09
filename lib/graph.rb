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
	
	def shortestRouteLength(route_string)
        routes = getPaths(route_string, 1, 20, 1, [])
        shortest = nil
        routes[:nodes][0].each{ |node|
            route_size = 0
            node.each_with_index{|e, i|
                if !node[i+1].nil?
                    route_size += distanceBetween(e + node[i+1]).to_i
                end
            }
            if shortest.nil?
                shortest = route_size
            elsif route_size < shortest
                shortest = route_size
            end
        }
        return shortest
        
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
    def findOcurrency(city_id, pos)
        #pos has to be 0 or 1
        valids = []
        @valid_nodes.each_with_index{ |node, i| 
            if node[:valids][0][pos] == city_id
                valids << node[:valids]
            end
        } 
        if valids.empty? then return "NO SUCH ROUTES" end
        return valids
    end 

    def getPaths(node, stops, max_stops, current, new_nodes)
        pos = 1
        if !new_nodes.any? {|x| x != findOcurrency(node[0], 0)}
            new_nodes << findOcurrency(node[0], 0)
        end
        
            for i in (current..max_stops)
                new_nodes[0].each{ |nod|
                if nod.last != node[1] 
                    findOcurrency(nod.last, 0).each{ |ocurr|
                        obj = {nodes: new_nodes}
                        if ocurr[0] != nod[nod.index(nod.last) - 1] && ocurr[1] != nod[nod.index(nod.last) - 1]
                            nod << ocurr[0]
                            nod << ocurr[1]
                        end
                        pos += 1
                        nod.group_by(&:itself).values
                    }
                end
            }
            end
        
        return {nodes: new_nodes}
    end
end