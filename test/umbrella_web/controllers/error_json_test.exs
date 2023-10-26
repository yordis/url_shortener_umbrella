defmodule UmbrellaWeb.ErrorJSONTest do
  use UmbrellaWeb.ConnCase, async: true

  test "renders 404" do
    assert UmbrellaWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert UmbrellaWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
