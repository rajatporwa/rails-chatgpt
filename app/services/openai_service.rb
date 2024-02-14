require 'httparty'

# class OpenaiService
#   include HTTParty
#   base_uri 'https://api.openai.com/v1'

#   def initialize(api_key = Rails.application.config.openai_api_key)
#     @api_key = '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'
#   end

#   def chat(prompt)
#     response = self.class.post(
#       '/chat/completions',
#       headers: {
#         'Content-Type' => 'application/json',
#         'Authorization' => "Bearer #{@api_key}"
#       },
#       body: {
#         model: 'gpt-3.5-turbo',
#         messages: [
#           { role: 'system', content: 'You are a helpful assistant.' },
#           { role: 'user', content: prompt }
#         ],
#         max_tokens: 150
#       }.to_json
#     )

#     Rails.logger.info "OpenAI API Response: #{response.inspect}"

#     # Access 'message' instead of 'choices' and get 'content'
#     response['choices'][0]['message']['content'] if response.success? && response['choices'].present?
#   end
# end

# class OpenaiService
#   include HTTParty
#   base_uri 'https://api.openai.com/v1'

#   def initialize(api_key)
#     api_key = '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'
#     @headers = {
#       'Content-Type' => 'application/json',
#       'Authorization' => "Bearer #{api_key}"
#     }
#   end

#   def generate_prompt(input_string)
#     data = { 'input_string' => input_string }
#     response = self.class.post('https://api.openai.com/v1/prompt/generate', headers: @headers, body: data.to_json)

#     if response.success?
#       result = JSON.parse(response.body)
#       prompt = result['generated_prompt']
#       return prompt
#     else
#       raise "Error: #{response.code} - #{response.body}"
#     end
#   end
# end

class OpenaiService
  include HTTParty
  base_uri 'https://api.openai.com/v1'

  def initialize(api_key = Rails.application.config.openai_api_key)
    api_key = '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'
    @headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{api_key}"
    }
  end

  def get_caption(image_url)
    data = {
      model: 'dall-e-2',
      prompt: "Generate a caption for the image #{image_url}",
      size: '1024x1024',
      quality: 'standard',
      n: 1,
    }

    response = self.class.post('/images/generations', headers: @headers, body: data.to_json)

    Rails.logger.info "OpenAI API Response: #{response.inspect}"

    if response.success? && response['data'].present?
      return response['data'][0]['url']
    else
      raise "Error: #{response.code} - #{response.body}"
    end
  end
end

# class OpenaiService
#   include HTTParty
#   base_uri 'https://api.openai.com/v1'

#   def initialize(api_key = Rails.application.config.openai_api_key)
#     api_key = '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'
#     @headers = {
#       'Content-Type' => 'application/json',
#       'Authorization' => "Bearer #{api_key}"
#     }
#   end

#   def get_caption(image_url)
#     prompt = "Describe the content of the image at #{image_url}"

#     data = {
#       model: 'gpt-3.5-turbo',
#        messages: [
#        { role: 'system', content: 'You are a helpful assistant.' },
#        { role: 'user', content: prompt }
#       ],
#     }

#     response = self.class.post('/chat/completions', headers: @headers, body: data.to_json)

#     Rails.logger.info "OpenAI API Response: #{response.inspect}"

#     if response.success? && response['choices'].present?
#       return response['choices'][0]['text']
#     else
#       raise "Error: #{response.code} - #{response.body}"
#     end
#   end
# end

class OpenaiService
  include HTTParty
  base_uri 'https://api.openai.com/v1'

  def initialize(api_key = Rails.application.config.openai_api_key)
    @api_key = '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'
    @headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{@api_key}"
    }
  end

  def generate_response(input, role, task_type)
    prompt = generate_prompt(input, role, task_type)

    data = {
      model: 'gpt-3.5-turbo',
      messages: [
        { role: 'system', content: 'You are a helpful assistant.' },
        { role: role, content: prompt }
      ]
    }

    response = self.class.post('/chat/completions', headers: @headers, body: data.to_json)

    Rails.logger.info "OpenAI API Response: #{response.inspect}"

    if response.success? && response['choices'].present?
     answer = response['choices'][0]['text'] || response['choices'][0]['message']['content']
     return answer
    else
      raise "Error: #{response.code} - #{response.body}"
    end
  end

  private 

  def generate_prompt(input, role, task_type)
    case task_type
    when 'image_caption'
      "#{role} describes the image: '#{input}'"
    when 'translation'
      "#{role} translates the following text: '#{input}'"
    else
      "#{role} performs a generic task with input: '#{input}'"
    end
  end
end
