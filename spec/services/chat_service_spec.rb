require 'rails_helper'

RSpec.describe ChatService, type: :service do
  let(:message) { "Suggest a gift for a basketball fan" }
  let(:service) { ChatService.new(message: message) }

  # Stub the client to avoid hitting the real OpenAI API
  let(:client_double) { instance_double("OpenAI::Client") }

  before do
    allow(service).to receive(:client).and_return(client_double)
  end

  describe "#call" do
    context "when the API returns valid JSON" do
      let(:api_response) do
        {
          "choices" => [
            { "message" => { "content" => '{"title":"Basketball Jersey","notes":"Perfect for a basketball fan","url":"https://example.com"}' } }
          ]
        }
      end

      before do
        allow(client_double).to receive(:chat).and_return(api_response)
      end

      it "returns a hash with indifferent access" do
        result = service.call
        expect(result[:title]).to eq("Basketball Jersey")
        expect(result[:notes]).to eq("Perfect for a basketball fan")
        expect(result[:url]).to eq("https://example.com")
        expect(result).to be_a(ActiveSupport::HashWithIndifferentAccess)
      end
    end

    context "when the API returns invalid JSON" do
      let(:api_response) do
        {
          "choices" => [
            { "message" => { "content" => "INVALID JSON STRING" } }
          ]
        }
      end

      before do
        allow(client_double).to receive(:chat).and_return(api_response)
      end

      it "returns the error hash" do
        result = service.call
        expect(result[:title]).to eq("AI Error")
        expect(result[:notes]).to eq("Could not generate suggestion. Please check server logs.")
        expect(result[:url]).to eq("")
      end
    end

    context "when the API response is missing expected keys" do
      let(:api_response) { { "choices" => [{}] } }

      before do
        allow(client_double).to receive(:chat).and_return(api_response)
      end

      it "returns the error hash" do
        result = service.call
        expect(result[:title]).to eq("AI Error")
        expect(result[:notes]).to eq("Could not generate suggestion. Please check server logs.")
        expect(result[:url]).to eq("")
      end
    end
  end

  describe "#training_prompts" do
    it "returns an array of prompts" do
      prompts = service.send(:training_prompts)
      expect(prompts).to be_an(Array)
      expect(prompts).not_to be_empty
    end
  end
end
