require "test_helper"

class WeatherControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should not search over HTTP plain method" do
    post weather_search_url, params: {query: "95129"}
    assert_response :not_found
  end

  test "should search over xhr" do
    post weather_search_url, params: {query: "95129"}, xhr: true
    assert_response :success
  end

end
