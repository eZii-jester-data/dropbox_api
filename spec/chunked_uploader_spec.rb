# frozen_string_literal: true

module DropboxApi
  describe ChunkedUploader do
    let(:path_prefix) { DropboxScaffoldBuilder.prefix_for :chunked_uploader }

    before :each do
      @client = DropboxApi::Client.new
    end

    it 'uploads a empty string',
       cassette: 'chunked_uploader/success_with_empty_string' do
      content = StringIO.new('')

      uploader = DropboxApi::ChunkedUploader.new(
        @client,
        "#{path_prefix}/new_file.txt",
        content,
        {
          chunk_size: 4
        }
      )
      uploader.start
      uploader.upload
      file_data = uploader.finish

      expect(file_data).to be_a(DropboxApi::Metadata::File)
      expect(file_data.name).to eq('new_file.txt')
    end

    it 'uploads a file', cassette: 'chunked_uploader/success' do
      content = File.open(
        File.join(DropboxScaffoldBuilder.fixtures_path,
                  'file.txt')
      )

      uploader = DropboxApi::ChunkedUploader.new(
        @client, "#{path_prefix}/new_file.txt", content, {
          chunk_size: 4
        }
      )
      uploader.start
      uploader.upload
      file_data = uploader.finish

      expect(file_data).to be_a(DropboxApi::Metadata::File)
      expect(file_data.name).to eq('new_file.txt')
    end
  end
end
