# frozen_string_literal: true

describe DropboxApi::Client, '#create_shared_link_with_settings' do
  before :each do
    @client = DropboxApi::Client.new
  end

  context 'on a file' do
    it 'creates a shared link for basic and pro users',
       cassette: 'create_shared_link_with_settings/success_file' do
      link = @client.create_shared_link_with_settings '/file_for_sharing.docx'

      expect(link).to be_a(DropboxApi::Metadata::FileLinkMetadata)
    end

    it 'creates a shared link with settings for pro users',
       cassette: 'create_shared_link_with_settings/success_file_with_settings' do
      link = @client.create_shared_link_with_settings(
        '/file_for_sharing.docx', { expires: '2019-03-12T10:34:42Z' }
      )

      expect(link).to be_a(DropboxApi::Metadata::FileLinkMetadata)
    end

    it 'raises an error if settings options are passed for basic users',
       cassette: 'create_shared_link_with_settings/error_no_permission_for_file' do
      expect do
        @client.create_shared_link_with_settings('/file_for_sharing.docx',
                                                 { expires: '2019-03-12T10:34:42Z' })
      end.to raise_error(DropboxApi::Errors::NoPermissionError)
    end

    it 'raises an error if already shared for basic and pro users',
       cassette: 'create_shared_link_with_settings/already_shared' do
      expect do
        @client.create_shared_link_with_settings '/file_for_sharing.docx'
      end.to raise_error(DropboxApi::Errors::SharedLinkAlreadyExistsError)
    end
  end

  context 'on a folder' do
    it 'creates a shared link for basic and pro users',
       cassette: 'create_shared_link_with_settings/success_folder' do
      link = @client.create_shared_link_with_settings '/folder_for_sharing'

      expect(link).to be_a(DropboxApi::Metadata::FolderLinkMetadata)
    end

    it 'creates a shared link with settings for pro users',
       cassette: 'create_shared_link_with_settings/success_folder_with_settings' do
      link = @client.create_shared_link_with_settings(
        '/folder_for_sharing',
        { expires: '2019-03-12T10:34:42Z' }
      )

      expect(link).to be_a(DropboxApi::Metadata::FolderLinkMetadata)
    end

    it 'raises an error if settings options are passed for basic user',
       cassette: 'create_shared_link_with_settings/error_no_permission_for_folder' do
      expect do
        @client.create_shared_link_with_settings(
          '/folder_for_sharing',
          { expires: '2019-03-12T10:34:42Z' }
        )
      end.to raise_error(DropboxApi::Errors::NoPermissionError)
    end
  end
end
