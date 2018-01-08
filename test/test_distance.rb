require_relative "helper"
require 'test/unit'

class TestDistance < Test::Unit::TestCase
    def test_distancebetween_A_B_C
        assert_equal 9, $graph.distanceBetween("ABC")
    end

    def test_distancebetween_A_D
        assert_equal 5, $graph.distanceBetween("AD")
    end

    def test_distancebetween_A_D_C
        assert_equal 13, $graph.distanceBetween("ADC")
    end
    
    def test_distancebetween_A_E_B_C_D
        assert_equal 22, $graph.distanceBetween("AEBCD")
    end

    def test_distancebetween_A_E_D
        assert_equal "NO SUCH ROUTE", $graph.distanceBetween("AED")
    end
end