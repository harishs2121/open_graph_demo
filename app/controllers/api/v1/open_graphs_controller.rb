class Api::V1::OpenGraphsController < ApplicationController
  def index
    open_graphs = OpenGraph.order('created_at ASC').paginate(page: params[:page], per_page: 30)

    render json: { success: true, data: open_graphs }, status: 200
  end

  def set_ogp_data
    begin
      response = Faraday.get(params[:url])
      ogp_data = OGP::OpenGraph.new(response.body)

      open_graph = OpenGraph.find_or_initialize_by(url: ogp_data.data['url'])
      open_graph.assign_attributes(og_data: ogp_data.data)

      if open_graph.save
        render json: { success: true, data: open_graph }, status: 200
      else
        render json: { success: false, message: open_graph.errors.full_messages.join('. ') }, status: :unprocessable_entity
      end
    rescue StandardError => e
      render json: { success: false, message: e }, status: :unprocessable_entity
    end
  end

  def get_ogp_data
    open_graph =  OpenGraph.find_by_url(params[:url])

    if open_graph.present?
      render json: { success: true, data: open_graph }, status: 200
    else
      render json: { success: false, message: "Data not found." }, status: 404
    end
  end

end
