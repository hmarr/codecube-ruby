require "spec_helper"

describe "CodeCube" do
  describe ".api_key=" do
    it "sets the api key" do
      expect { CodeCube.api_key = 'foo' }.to change { CodeCube.api_key }
    end
  end

  describe ".run_sync" do
    subject { CodeCube.run_sync }

    context "when required args are missing" do
      it "throws an exception" do
        expect { CodeCube.run_sync }.to raise_error(ArgumentError)
      end
    end

    context "with valid params" do
      let(:api_endpoint) { "http://api.codecube.io/sync-run/" }
      let(:api_key) { "valid-api-key" }
      let(:params) { { code: "puts 1", language: "ruby" } }
      let(:run_code) do
        VCR.use_cassette("run_sync", match_requests_on: [:headers]) do
          CodeCube.run_sync(params)
        end
      end

      before { CodeCube.api_key = api_key }

      context "but no api key" do
        let(:api_key) { nil }

        it "throws an exception" do
          expect { run_code }.to raise_error(CodeCube::AuthenticationError)
        end
      end

      context "but an invalid api key" do
        let(:api_key) { "invalid-api-key" }

        it "throws an exception" do
          expect {
            VCR.use_cassette("bad_auth") do
              CodeCube.run_sync(params)
            end
          }.to raise_error(CodeCube::AuthenticationError)
        end
      end

      it "hits the codecube api" do
        run_code
        expect(WebMock).to have_requested(:post, api_endpoint)
      end

      it "sends a json body" do
        run_code
        expect(WebMock).to have_requested(:post, api_endpoint).with do |req|
          JSON.parse(req.body, symbolize_names: true) == params
        end
      end

      it "includes an auth header" do
        run_code
        expect(WebMock).to have_requested(:post, api_endpoint).
          with(headers: { "Authorization" => /#{api_key}/ })
      end

      it "returns a Response object" do
        response = run_code
        expect(response).to be_a(CodeCube::Response)
        expect(response.text_output).to eq("1")
      end
    end
  end
end
