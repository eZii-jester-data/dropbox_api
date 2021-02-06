# frozen_string_literal: true

describe DropboxApi::Client, '#copy' do
  before :each do
    @client = DropboxApi::Client.new
  end

  it 'returns the copied file on success', cassette: 'copy/success' do
    file = @client.copy('/a.jpg', '/b.jpg')

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq('b.jpg')
  end

  it "raises an error if the file can't be found",
     cassette: 'copy/not_found' do
    expect do
      @client.copy('/z.jpg', '/b.jpg')
    end.to raise_error(DropboxApi::Errors::NotFoundError)
  end

  it 'raises an error if the path is invalid',
     cassette: 'copy/malformed_path' do
    expect do
      @client.copy('/../invalid_path.jpg', '/b.jpg')
    end.to raise_error(DropboxApi::Errors::MalformedPathError)
  end
end
