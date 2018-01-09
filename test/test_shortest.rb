require_relative "helper"
require 'test/unit'

class TestShortest < Test::Unit::TestCase
    def test_shortest_route_length_A_C
        assert_equal 9, $graph.shortestRouteLength("AC")
    end

end