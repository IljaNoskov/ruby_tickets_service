# frozen_string_literal: true

shared_examples 'request failure' do |code|
  it 'returns expected status code' do
    expect(subject).to have_http_status(code)
  end

  it 'returns expected response' do
    result = JSON.parse(subject.body)
    expect(result).to eq({ 'message' => error_message })
  end
end
