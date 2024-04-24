shared_examples 'validation result' do |code, expected|
  it 'returns expected status code' do
    expect(subject).to have_http_status(code)
  end

  it 'returns expected response' do
    result = JSON.parse(subject.body)
    expect(result).to eq(expected_response)
  end
end
