class DashboardsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:search]

  # def search
  #   query = params[:query]
  #   openai_service = OpenaiService.new(Rails.application.config.openai_api_key)
  #   @answer = openai_service.chat(query)
  #   render json: { answer: @answer }
  # end

  def search
    image_url = params[:image_url]
    openai_service = OpenaiService.new(Rails.application.config.openai_api_key)
    caption = openai_service.get_caption(image_url)
    render json: { caption: caption }
  end

#   def search
#     input_text = params[:input_text]
#     image_url = params[:image_url]
#     task_type = params[:task_type]

#     openai_service = OpenaiService.new(Rails.application.config.openai_api_key)

#     if task_type == 'image_caption' && image_url.present?
#       prompt = "Describe the content of the image: '#{image_url}'"
#     elsif input_text.present?
#       prompt = "#{input_text} (task_type: #{task_type})"
#     else
#       render json: { result: 'Invalid input' }
#       return
#     end

#     response = openai_service.generate_response(prompt, 'user', task_type)

#     if response.present? && response['choices'].present?
#       result = response['choices'][0]['text'] || response['choices'][0]['message']['content']
#       render json: { result: result }
#     else
#       render json: { result: 'No answer from OpenAI' }
#     end
#   end
# end
end