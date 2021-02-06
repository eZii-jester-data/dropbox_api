# frozen_string_literal: true

describe DropboxApi::Client, '#get_shared_link_metadata' do
  let(:path_prefix) do
    DropboxScaffoldBuilder.prefix_for :get_shared_link_metadata
  end

  before :each do
    @client = DropboxApi::Client.new
  end

  it 'works with a file',
     cassette: 'get_shared_link_metadata/success_file' do
    shared_link = @client
      .list_shared_links(path: "#{path_prefix}/shared_file.txt")
      .links
      .first
    result = @client.get_shared_link_metadata shared_link.url

    expect(result).to be_a(DropboxApi::Metadata::FileLinkMetadata)
  end

  it 'works with a folder',
     cassette: 'get_shared_link_metadata/success_folder' do
    shared_link = @client
      .list_shared_links(path: "#{path_prefix}/shared_folder")
      .links
      .first
    result = @client.get_shared_link_metadata shared_link.url

    expect(result).to be_a(DropboxApi::Metadata::FolderLinkMetadata)
  end

  it "raises an error if the link can't be found",
     cassette: 'get_shared_link_metadata/error_not_found' do
    bad_link = 'https://www.dropbox.com/sh/abcd/1234?dl=0'

    expect do
      @client.get_shared_link_metadata bad_link
    end.to raise_error(DropboxApi::Errors::SharedLinkNotFoundError)
  end
end
