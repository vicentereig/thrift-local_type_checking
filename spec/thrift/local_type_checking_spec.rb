require 'spec_helper'

describe Thrift::LocalTypeChecking do
  it 'has a version number' do
    expect(Thrift::LocalTypeChecking::VERSION).not_to be nil
  end

  let(:protocol) { Thrift::CompactProtocol.new Thrift::MemoryBufferTransport.new }

  let(:base_client) {
    Accounts::V1::AccountsService::Client.new(protocol)
  }

  let(:client) { base_client.extend(Thrift::LocalTypeChecking)}

  describe 'when invoking the client with invalid arguments' do
    let(:invalid_id) { 'should be a number :)'}
    let(:invalid_users) { nil }
    let(:invalid_account) { Accounts::V1::Account.new(id: invalid_id, users: invalid_users)}

    it 'should raise a Thrift exception' do
      expect {
        base_client.create(invalid_account)
      }.to raise_error TypeError
    end
  end
end
