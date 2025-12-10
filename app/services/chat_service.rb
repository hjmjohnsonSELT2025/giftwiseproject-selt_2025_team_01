# Video walkthrough: https://www.youtube.com/watch?v=DTHCa6P_ZLE
class ChatService
  attr_reader :message

  def initialize (message:)
    @message = message
  end

  def call
    # first you get the training prompt for the AI
    messages = training_prompts.map do |prompt|
      { role: "system", content: prompt }
    end

    json_prompt = {
      role: "system",
      content: "You must respond with a single JSON object. The object MUST strictly adhere to the following schema and
                contain these three keys: 'title' (a string for the gift name), 'notes' (a string with the gift description/rationale),
                and 'url' (a string containing a direct purchase link). Do not include any text or characters outside of the JSON object."
    }
    # this appends the json training prompt
    messages << json_prompt

    # this appends the actual request data to the messages array
    messages << { role: "user", content: message }

    # create the chat gpt client
    # send our user message
    response = client.chat(
      parameters: {
        model: "gpt-4o", # chatgpt model we are using
        response_format: { type: "json_object" }, # the response format the model should be returning in
        messages: messages, # the messages it is taking in (prompt and user message)
        temperature: 0.7,
      }
    )

    begin
      # 1. Extract the JSON string
      json_string = response.dig("choices", 0, "message", "content")

      # 2. Parse the JSON string into a Ruby Hash and return it
      #    We use .with_indifferent_access for convenience in the controller
      return JSON.parse(json_string).with_indifferent_access

    rescue JSON::ParserError, NoMethodError => e
      # Handle cases where the API fails or returns non-JSON data gracefully
      Rails.logger.error "AI Service Error: Failed to parse JSON response. #{e.message}"
      # Return a safe, known error hash
      return { title: "AI Error", notes: "Could not generate suggestion. Please check server logs.", url: "" }
    end
  end

  private

  # train the client with some prompt
  def training_prompts
    [
      "You are a helpful assistant that helps people find their gift ideas.",
      "Your gift ideas must be highly relevant to the recipient's relationship status, age, hobbies, and dislikes.",
      "The suggested gift must be something that can be purchased online.",
    ]
  end

  def client
    @_client ||= OpenAI::Client.new(
      access_token: Rails.application.credentials.open_ai_api_key,
      log_errors: true # Highly recommended in development, so you can see what errors OpenAI is returning. Not recommended in production because it could leak private data to your logs.
    )
  end
end
