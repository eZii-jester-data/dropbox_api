# frozen_string_literal: true

describe DropboxApi::Client, '#permanently_delete' do
  let(:path_prefix) { DropboxScaffoldBuilder.prefix_for :permanently_delete }
  before :each do
    @client = DropboxApi::Client.new
  end

  it "can't be tested without a Dropbox Business account :(",
     cassette: 'permanently_delete/invalid_account' do
    expect do
      @client.permanently_delete "#{path_prefix}/file.txt"
    end.to raise_error(DropboxApi::Errors::HttpError)
  end
end
