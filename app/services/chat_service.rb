# Video walkthrough: https://www.youtube.com/watch?v=DTHCa6P_ZLE

class ChatService
  attr_reader :message

  def initialize (message:)
    @message = message
  end

  def call
    messages = training_prompts.map do |prompt|
      { role: "system", content: prompt }
    end

    messages << { role: "user", content: message }

    # create the chat gpt client
    response = client.chat(
      parameters: {
        model: "gpt-4o", # Required.
        messages: messages,
        temperature: 0.7,
      }
    )
    # train the client with some prompt
    # send our user message
    # parse out the response
    puts response.dig("choices", 0, "message", "content")
  end

  private

  def training_prompts
    [
      "You are a helpful assistant.",
      "You are a helpful assistant that helps people find their gift ideas."
    ]
  end

  def client
    @_client ||= OpenAI::Client.new(
      access_token: Rails.application.credentials.open_ai_api_key,
      log_errors: true # Highly recommended in development, so you can see what errors OpenAI is returning. Not recommended in production because it could leak private data to your logs.
    )
  end
end
