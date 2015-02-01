require 'spec_helper'

describe Thrift::LocalTypeChecking do

  it 'has a version number' do
    expect(Thrift::LocalTypeChecking::VERSION).not_to be nil
  end

  let(:base_client) { Accounts::V1::AccountsService::Client.new(protocol) }

  describe 'when invoking the default Thrift client with invalid arguments' do
    let(:protocol) { Thrift::CompactProtocol.new Thrift::MemoryBufferTransport.new }

    describe 'scalars' do
      let(:invalid_id) { 'should be a number :)'}
      let(:invalid_users) { nil }
      let(:invalid_account) { Accounts::V1::Account.new(id: invalid_id, users: invalid_users)}

      it 'should raise a TypeError' do
        expect {
          base_client.create(invalid_account)
        }.to raise_error
      end
    end

    describe 'lists' do
      let(:id) { 1 }
      let(:invalid_users) { nil }
      let(:invalid_account) { Accounts::V1::Account.new(id: id, users: invalid_users)}

      it 'should not raise a TypeError' do
        expect {
          base_client.create(invalid_account)
        }.not_to raise_error
      end
    end
  end

  describe 'when invoking the enhaced Thrift client with invalid arguments' do
    let(:protocol) { Thrift::CompactProtocol.new Thrift::MemoryBufferTransport.new }
    let(:client) { Accounts::V1::AccountsService::Client.new(protocol).extend(Thrift::LocalTypeChecking)}

    describe 'scalars' do
      let(:invalid_id) { 'should be a number :)'}
      let(:invalid_users) { nil }
      let(:invalid_account) { Accounts::V1::Account.new(id: invalid_id, users: invalid_users)}

      it 'should raise a TypeError' do
        expect {
          client.create(invalid_account)
        }.to raise_error
      end
    end

    describe 'lists' do
      let(:id) { 1 }
      let(:invalid_users) { nil }
      let(:invalid_account) { Accounts::V1::Account.new(id: id, users: invalid_users)}

      it 'should not raise a TypeError' do
        expect {
          client.create(invalid_account)
        }.not_to raise_error
      end
    end

    describe 'nested structures' do
      let(:id) { 1 }
      let(:invalid_emails) { [Accounts::V1::EmailAddress.new(id: 'not a number', email: 'vicente@trolo.com')] }
      let(:invalid_users) { [Accounts::V1::User.new(emails: invalid_emails)] }
      let(:invalid_account) { Accounts::V1::Account.new(id: id, users: invalid_users)}

      it 'should not raise a TypeError' do
        expect {
          client.create(invalid_account)
        }.to raise_error Thrift::TypeError, 'Expected Types::I64, received String for field id'
      end
    end
  end
end
