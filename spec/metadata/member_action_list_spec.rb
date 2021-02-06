# frozen_string_literal: true

context DropboxApi::Metadata::MemberActionList do
  it 'can be initialized from an empty Array' do
    actions = DropboxApi::Metadata::MemberActionList.new([])

    expect(actions).to be_a(DropboxApi::Metadata::MemberActionList)
    expect(actions.to_a).to eq([])
  end

  it 'can be initialized from a Array of String' do
    strings = %w[
      remove
      leave_a_copy
    ]
    actions = DropboxApi::Metadata::MemberActionList.new strings

    expect(actions).to be_a(DropboxApi::Metadata::MemberActionList)
    expect(actions.to_a.map(&:to_s)).to eq(strings)
  end

  it 'can be initialized from a Array of Symbol' do
    symbols = %i[
      remove
      leave_a_copy
    ]
    actions = DropboxApi::Metadata::MemberActionList.new symbols

    expect(actions).to be_a(DropboxApi::Metadata::MemberActionList)
    expect(actions.to_a.map(&:to_sym)).to eq(symbols)
  end

  it 'can be initialized from another MemberActionList' do
    member_action_list = DropboxApi::Metadata::MemberActionList.new(%i[
      remove
      leave_a_copy
                                                                    ])
    actions = DropboxApi::Metadata::MemberActionList.new member_action_list

    expect(actions).to be_a(DropboxApi::Metadata::MemberActionList)
    expect(actions).to eq(member_action_list)
  end

  it 'can be serialized just as an Array' do
    array = %i[
      remove
      leave_a_copy
    ]

    expect(DropboxApi::Metadata::MemberActionList.new(array).to_json)
      .to eq(array.to_json)
  end

  it 'will raise an exception if one of the entries is invalid' do
    expect do
      DropboxApi::Metadata::MemberActionList.new [:invalid_action]
    end.to raise_error ArgumentError
  end
end
