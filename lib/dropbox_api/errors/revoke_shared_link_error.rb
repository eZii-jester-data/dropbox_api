# frozen_string_literal: true

module DropboxApi::Errors
  class RevokeSharedLinkError < BasicError
    ErrorSubtypes = {
      shared_link_not_found: SharedLinkNotFoundError,
      shared_link_access_denied: SharedLinkAccessDeniedError,
      unsupported_link_type: UnsupportedLinkTypeError,
      shared_link_malformed: SharedLinkMalformedError
    }.freeze
  end
end
