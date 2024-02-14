class SearchController < ApplicationController
	def search
    query = params[:query]
    openai_service = OpenaiService.new(Rails.application.config.openai_api_key)
    @answer = openai_service.chat(query)
    render json: { answer: @answer }
  end
end
