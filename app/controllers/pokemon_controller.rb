class PokemonController < ApplicationController
  def index

    render json: {
      "message": "ok"
    }

  end

  def show
    api_key = ENV["GIPHY_KEY"]

    res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    body = JSON.parse(res.body)

    if body["name"] == nil
      render json: {
        "message": "Pokemon not found"
      }
      return
    end

    id = body["id"]
    name  = body["name"]
    type = body["types"][0]["type"]["name"]

    user_api = api_key

    res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{user_api}&q=#{name}&rating=g")
    body = JSON.parse(res.body)

    if user_api != api_key
      render json: {
        "message": "Invalid authentication"
      }
      return
    end

    gif_url = body["data"].sample["url"]

    render json: {
      "id": id,
      "name": name,
      "types": type,
      "GIF": gif_url
    }
  end
end
